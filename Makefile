PERL=perl
RSYNC=rsync
PERL_VERSION=${shell ${PERL} -e 'print substr($$^V, 1)'}
PERL_MIN_VERSION=5.10
CPAN=cpan
CPANM=cpanm
SQITCH=sqitch
SQITCH_VERSION=${word 3,${shell ${SQITCH} --version}}
SQITCH_MIN_VERSION=0.97
GREP=grep
GIT=git
GIT_BRANCH=${shell ${GIT} rev-parse --abbrev-ref HEAD}
# openshift doesn't like slashes
GIT_BRANCH_NORM=${subst /,-,${GIT_BRANCH}}
AWK=awk
PSQL=psql -h localhost
# "psql --version" prints "psql (PostgreSQL) XX.XX"
PSQL_VERSION=${word 3,${shell ${PSQL} --version}}
PG_SERVER_VERSION=${strip ${shell ${PSQL} -tc 'show server_version;' || echo error}}
PG_MIN_VERSION=9.1
TEST_DB=ggircs_test
PG_PROVE=pg_prove -h localhost
PG_SHAREDIR=${shell pg_config --sharedir}
PG_ROLE=${shell whoami}
DOCKER=docker
DOCKER_HUB_PREFIX=wenzowski/
DOCKER_SQITCH_IMAGE=sqitch
DOCKER_SQITCH_TAG=0.9999
DOCKER_GGIRCS_IMAGE=ggircs
DOCKER_GGIRCS_TAG=latest
DOCKER_POSTGRES_IMAGE=postgresql
DOCKER_POSTGRES_TAG=10
OC=oc
OC_PROJECT= # overridden as needed
OC_DEV_PROJECT=wksv3k-dev
OC_TEST_PROJECT=wksv3k-test
OC_PROD_PROJECT=wksv3k-prod
OC_TOOLS_PROJECT=wksv3k-tools
OC_REGISTRY=docker-registry.default.svc:5000

.PHONY: test
test:
	@@${MAKE} -s ${MAKEFLAGS} createdb;
	@@${MAKE} -s ${MAKEFLAGS} deploy;
	@@${MAKE} -s ${MAKEFLAGS} revert;
	@@${MAKE} -s ${MAKEFLAGS} deploy;
	@@${MAKE} -s ${MAKEFLAGS} prove_unit;
	@@${MAKE} -s ${MAKEFLAGS} prove_style;
	@@${MAKE} -s ${MAKEFLAGS} dropdb;

.PHONY: unit
unit: dropdb createdb deploy prove_unit

.PHONY: deploy
deploy:
	# Deploy all changes to ${TEST_DB} using sqitch
	@@${SQITCH} deploy ${TEST_DB};

.PHONY: prove_style
prove_style:
	# Run style-related test suite on all objects in db using pg_prove
	@@${PG_PROVE} -v -d ${TEST_DB} test/style/*_test.sql

.PHONY: prove_unit
prove_unit:
	# Run unit test suite using pg_prove
	@@${PG_PROVE} -d ${TEST_DB} test/unit/*_test.sql

.PHONY: revert
revert:
	# Revert all changes to ${TEST_DB} using sqitch
	@@${SQITCH} revert -y ${TEST_DB};

.PHONY: createdb
createdb:
	# Ensure the ${TEST_DB} database exists
	-@@${PSQL} -tc "SELECT 1 FROM pg_database WHERE datname = '${TEST_DB}'" | \
		${GREP} -q 1 || \
		${PSQL} -c "CREATE DATABASE ${TEST_DB}";

.PHONY: dropdb
dropdb:
	# Drop the ${TEST_DB} database
	-@@${PSQL} -tc "SELECT 1 FROM pg_database WHERE datname = '${TEST_DB}'" | \
		${GREP} -q 0 || \
		${PSQL} -c "DROP DATABASE ${TEST_DB}";

define check_file_in_path
	${if ${shell which ${word 1,${1}}},
		${info ✓ Found ${word 1,${1}}},
		${error ✖ No ${word 1,${1}} in path.}
	}
endef

define check_min_version_num
	${if ${shell printf '%s\n%s\n' "${3}" "${2}" | sort -CV || echo error},
		${error ✖ ${word 1,${1}} version needs to be at least ${3}.},
		${info ✓ ${word 1,${1}} version is at least ${3}.}
	}
endef

.PHONY: verify_installed
verify_installed:
	$(call check_file_in_path,${PERL})
	$(call check_min_version_num,${PERL},${PERL_VERSION},${PERL_MIN_VERSION})

	$(call check_file_in_path,${CPAN})
	$(call check_file_in_path,${GIT})
	$(call check_file_in_path,${RSYNC})

	$(call check_file_in_path,${PSQL})
	$(call check_min_version_num,${PSQL},${PSQL_VERSION},${PG_MIN_VERSION})
	@@echo ✓ External dependencies are installed

.PHONY: verify_pg_server
verify_pg_server:
ifeq (error,${PG_SERVER_VERSION})
	${error Error while connecting to postgres server}
else
	${info postgres is online}
endif

ifneq (${PSQL_VERSION}, ${PG_SERVER_VERSION})
	${error psql version (${PSQL_VERSION}) does not match the server version (${PG_SERVER_VERSION}) }
else
	${info psql and server versions match}
endif

ifeq (0,${shell ${PSQL} -qAtc "select count(*) from pg_user where usename='${PG_ROLE}' and usesuper=true"})
	${error A postgres role with the name "${PG_ROLE}" must exist and have the SUPERUSER privilege.}
else
	${info postgres role "${PG_ROLE}" has appropriate privileges}
endif

	@@echo ✓ PostgreSQL server is ready

.PHONY: verify
verify: verify_installed verify_pg_server

.PHONY: verify_ready
verify_ready:
	# ensure postgres is online
	@@${PSQL} -tc 'show server_version;' | ${AWK} '{print $$NF}';

.PHONY: verify
verify: verify_installed verify_ready

pgtap:
	# clone the source for pgTAP
	@@${GIT} clone https://github.com/theory/pgtap.git && \
		pushd pgtap && \
		${GIT} checkout v1.0.0;

.PHONY: install_pgtap
install_pgtap: pgtap
	${info install pgTAP into postgres}
	@@$(MAKE) -C pgtap -s $(MAKEFLAGS)
	@@$(MAKE) -C pgtap -s $(MAKEFLAGS) installcheck

ifeq (error,${shell /bin/test -w ${PG_SHAREDIR}/extension || echo error})
	@@echo "FATAL: The current user does not have permission to write to ${PG_SHAREDIR}/extension and install pgTAP.\
 It needs to be installed by a user having write access to that directory, e.g. with 'sudo make -C pgtap install'" && exit 1
else
	@@$(MAKE) -C pgtap -s $(MAKEFLAGS) install
endif

.PHONY: install_sqitch
install_sqitch:
	# install postgres driver for sqitch
	@@${CPAN} DBD::Pg
	# install sqitch
	@@${CPAN} App::Sqitch
	# install pg_prove
	@@${CPAN} TAP::Parser::SourceHandler::pgTAP

.PHONY: install_cpanm
install_cpanm:
ifeq (${shell which ${CPANM}},)
	# install cpanm
	@@${CPAN} App:cpanminus
endif

.PHONY: install_cpandeps
install_cpandeps:
	# install Perl dependencies from cpanfile
	${CPANM} --installdeps .

.PHONY: postinstall_check
postinstall_check:
	@@printf '%s\n%s\n' "${SQITCH_MIN_VERSION}" "${SQITCH_VERSION}" | sort -CV ||\
 	(echo "FATAL: ${SQITCH} version should be at least ${SQITCH_MIN_VERSION}. Make sure the ${SQITCH} executable installed by cpanminus is available has the highest priority in the PATH" && exit 1);

.PHONY: install
install: install_cpanm install_cpandeps postinstall_check install_pgtap

define switch_project
	@@echo ✓ logged in as: $(shell ${OC} whoami)
	@@${OC} project ${OC_PROJECT} >/dev/null
	@@echo ✓ switched project to: ${OC_PROJECT}
endef

define oc_process
	@@${OC} process -f openshift/${1}.yml ${2} | ${OC} apply --wait=true --overwrite=true -f-
endef

define oc_promote
	@@$(OC) tag $(OC_TOOLS_PROJECT)/$(1):$(2) $(1)-mirror:$(2) --reference-policy=local
endef

define build
	@@echo Add all image streams and build in the tools project...
	$(call oc_process,imagestream/cas-ggircs-perl,)
	$(call oc_process,imagestream/cas-ggircs-postgres,)
	$(call oc_process,imagestream/cas-ggircs,)
	$(call oc_process,buildconfig/cas-ggircs,GIT_BRANCH=${GIT_BRANCH} GIT_BRANCH_NORM=${GIT_BRANCH_NORM})
	$(call oc_process,imagestream/cas-ggircs-metabase-builder,)
	$(call oc_process,buildconfig/cas-ggircs-metabase-builder,GIT_BRANCH=${GIT_BRANCH} GIT_BRANCH_NORM=${GIT_BRANCH_NORM})
	$(call oc_process,imagestream/cas-ggircs-metabase-build,)
	$(call oc_process,buildconfig/cas-ggircs-metabase-build,GIT_BRANCH_NORM=${GIT_BRANCH_NORM})
	$(call oc_process,imagestream/cas-ggircs-metabase,)
	$(call oc_process,buildconfig/cas-ggircs-metabase,GIT_BRANCH=${GIT_BRANCH} GIT_BRANCH_NORM=${GIT_BRANCH_NORM})
endef

define deploy
	# Allow import of images from tools namespace
	# This will fail if you're not an admin of the project
	@@${OC} policy add-role-to-group system:image-puller system:serviceaccounts:${OC_PROJECT} -n ${OC_TOOLS_PROJECT}
	# Configure...
	@@${OC} get secret cas-ggircs-postgres &>/dev/null \
		|| ${OC} process -f openshift/secret/cas-ggircs-postgres.yml \
		GGIRCS_DATABASE=ggircs_${OC_PROJECT} \
		| ${OC} apply --wait=true -f-
	@@${OC} get secret cas-ggircs-metabase-postgres &>/dev/null \
		|| ${OC} process -f openshift/secret/cas-ggircs-metabase-postgres.yml \
		METABASE_DATABASE=metabase_${OC_PROJECT} \
		| ${OC} apply --wait=true -f-
	# Deploy...
	$(call oc_process,imagestream/cas-ggircs-metabase-mirror,GIT_BRANCH_NORM=${GIT_BRANCH_NORM})
	$(call oc_promote,cas-ggircs-metabase,${GIT_BRANCH_NORM})
	$(call oc_process,imagestream/cas-ggircs-postgres-mirror,)
	$(call oc_promote,cas-ggircs-postgres-mirror,latest)
	$(call oc_process,imagestream/cas-ggircs-mirror,GIT_BRANCH_NORM=${GIT_BRANCH_NORM})
	$(call oc_promote,cas-ggircs,${GIT_BRANCH_NORM})
	$(call oc_process,persistentvolumeclaim/cas-ggircs-data,)
	$(call oc_process,persistentvolumeclaim/cas-ggircs-metabase-postgres,)
	$(call oc_process,persistentvolumeclaim/cas-ggircs-postgres,)
	$(call oc_process,deploymentconfig/cas-ggircs-postgres)
	$(call oc_process,deploymentconfig/cas-ggircs-metabase-postgres)
	$(call oc_process,deploymentconfig/cas-ggircs-metabase,GIT_BRANCH_NORM=${GIT_BRANCH_NORM})
	$(call oc_process,deploymentconfig/cas-ggircs,GIT_BRANCH_NORM=${GIT_BRANCH_NORM})
	$(call oc_process,service/cas-ggircs-postgres,)
	$(call oc_process,service/cas-ggircs-metabase-postgres,)
	$(call oc_process,service/cas-ggircs-metabase,)
	$(call oc_process,route/cas-ggircs-metabase,OC_PROJECT=${OC_PROJECT})
endef

.PHONY: deploy_tools
deploy_tools: OC_PROJECT=${OC_TOOLS_PROJECT}
deploy_tools:
	$(call switch_project)
	$(call build)

.PHONY: deploy_dev
deploy_dev: OC_PROJECT=${OC_DEV_PROJECT}
deploy_dev: deploy_tools
	$(call switch_project)
	$(call deploy)

.PHONY: deploy_test
deploy_test: OC_PROJECT=${OC_TEST_PROJECT}
deploy_test: deploy_tools
	$(call switch_project)
	$(call deploy)

.PHONY: clean_test
clean_test: OC_PROJECT=${OC_TEST_PROJECT}
clean_test:
	$(call switch_project)
	@@${OC} delete all --all
	@@${OC} delete persistentvolumeclaim/cas-ggircs-data --ignore-not-found=true --wait=true
	@@${OC} delete persistentvolumeclaim/cas-ggircs-metabase-postgres --ignore-not-found=true --wait=true
	@@${OC} delete persistentvolumeclaim/cas-ggircs-postgres --ignore-not-found=true --wait=true

.PHONY: s2i_build
s2i_build:
	# localy build COMMITTED CHANGES ONLY
	# @see https://github.com/sclorg/s2i-perl-container
	# @see https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/building_running_and_managing_containers/using_red_hat_universal_base_images_standard_minimal_and_runtimes
	s2i build https://github.com/bcgov/cas-ggircs.git -r $$(git rev-parse --verify HEAD) registry.access.redhat.com/ubi8/perl-526 cas-ggircs

.PHONY: push
push:
	# copy data to remote
	oc rsync data cas-ggircs-5-c46gh:/opt/app-root/src/
	psql -c "\copy ggircs_swrs.ghgr_import from './data/select_t_REPORT_ID__t_XML_FILE__t_WHEN_C.csv' with (format csv)";

.PHONY: rsh
rsh:
	oc exec -it cas-ggircs-5-c46gh -- bash

# .PHONY: refresh
# refresh:
# 	parallel -P8 'oc exec cas-ggircs-1-5ssz8 -- psql -c "refresh materialized view ggircs_swrs.{} with data;"' ::: \
# 		report \
# 		final_report \
# 		facility \
# 		organisation \
# 		activity unit \
# 		fuel \
# 		emission \
# 		measured_emission_factor \
# 		descriptor \
# 		address \
# 		identifier \
# 		naics \
# 		contact \
# 		permit \
# 		parent_organisation \
# 		flat

# Configure image streams
# oc start-build cas-ggircs-postgres --commit=$$(git rev-parse --verify HEAD)
# oc start-build cas-ggircs-sqitch --commit=$$(git rev-parse --verify HEAD)
