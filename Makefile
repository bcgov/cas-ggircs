PERL=perl
RSYNC=rsync
PERL_VERSION:=${shell ${PERL} -e 'print substr($$^V, 1)'}
PERL_MIN_VERSION=5.10
CPAN=cpan
CPANM=cpanm
SQITCH=sqitch
SQITCH_MIN_VERSION=0.97
GREP=grep
GIT=git
AWK=awk
PSQL=psql -h localhost
# "psql --version" prints "psql (PostgreSQL) XX.XX"
PSQL_VERSION:=${word 3,${shell ${PSQL} --version}}
PG_SERVER_VERSION:=${strip ${shell ${PSQL} -tc 'show server_version;' || echo error}}
PG_MIN_VERSION=9.1
TEST_DB=ggircs_test
PG_PROVE=pg_prove -h localhost
PG_SHAREDIR := ${shell pg_config --sharedir}
PG_ROLE := ${shell whoami}
DOCKER_SQITCH_TAG=0.9999
DOCKER_POSTGRES_IMAGE=wenzowski/postgres
DOCKER_POSTGRES_TAG=11.2

test:
	@@$(MAKE) -s $(MAKEFLAGS) createdb;
	@@$(MAKE) -s $(MAKEFLAGS) deploy;
	@@$(MAKE) -s $(MAKEFLAGS) revert;
	@@$(MAKE) -s $(MAKEFLAGS) deploy;
	@@$(MAKE) -s $(MAKEFLAGS) prove_unit;
	@@$(MAKE) -s $(MAKEFLAGS) prove_style;
	@@$(MAKE) -s $(MAKEFLAGS) dropdb;
.PHONY: test

unit: dropdb createdb deploy prove_unit
.PHONY: unit

deploy: 
	# Deploy all changes to ${TEST_DB} using sqitch
	@@sqitch deploy ${TEST_DB};
.PHONY: deploy

prove_style:
	# Run style-related test suite on all objects in db using pg_prove
	@@${PG_PROVE} -v -d ${TEST_DB} test/style/*_test.sql
.PHONY: prove

prove_unit:
	# Run unit test suite using pg_prove
	@@${PG_PROVE} -v -d ${TEST_DB} test/unit/*_test.sql
.PHONY: test

revert:
	# Revert all changes to ${TEST_DB} using sqitch
	@@sqitch revert -y ${TEST_DB};
.PHONY: revert

createdb:
	# Ensure the ${TEST_DB} database exists
	-@@${PSQL} -tc "SELECT 1 FROM pg_database WHERE datname = '${TEST_DB}'" | \
		${GREP} -q 1 || \
		${PSQL} -c "CREATE DATABASE ${TEST_DB}";
.PHONY: createdb

dropdb:
	# Drop the ${TEST_DB} database
	-@@${PSQL} -tc "SELECT 1 FROM pg_database WHERE datname = '${TEST_DB}'" | \
		${GREP} -q 0 || \
		${PSQL} -c "DROP DATABASE ${TEST_DB}";
.PHONY: dropdb

define check_file_in_path
	${if ${shell which ${word 1,${1}}}, 
		${info Found ${word 1,${1}}}, 
		${error No ${word 1,${1}} in path.}
	}
endef

define check_min_version_num
	${if ${shell printf '%s\n%s\n' "${3}" "${2}" | sort -CV || echo error},
		${error ${word 1,${1}} version needs to be at least ${3}.},
		${info ${word 1,${1}} version is at least ${3}.}
	}
endef


verify_installed:
	$(call check_file_in_path,${PERL})
	${call check_min_version_num,${PERL},${PERL_VERSION},${PERL_MIN_VERSION}}

	$(call check_file_in_path,${CPAN})
	$(call check_file_in_path,${GIT})
	$(call check_file_in_path,${RSYNC})

	$(call check_file_in_path,${PSQL})
	${call check_min_version_num,${PSQL},${PSQL_VERSION},${PG_MIN_VERSION}}
	@@echo ✓ External dependencies are installed
.PHONY: verify_installed

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
.PHONY: verify_ready

verify: verify_installed verify_pg_server
.PHONY: verify

pgtap:
	# clone the source for pgTAP
	@@${GIT} clone https://github.com/theory/pgtap.git && \
		pushd pgtap && \
		${GIT} checkout v1.0.0;

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
.PHONY: install_pgtap


install_cpanm: 
ifeq (${shell which ${CPANM}},)
	# install cpanm
	@@${CPAN} App:cpanminus
endif
.PHONY: install_cpanm

install_cpandeps:
	# install Perl dependencies from cpanfile
	${CPANM} --installdeps .
.PHONY: install_cpandeps

postinstall_check:
	@@printf '%s\n%s\n' "${SQITCH_MIN_VERSION}" $$(echo $$(${SQITCH} --version) | cut -d " " -f 3) | sort -CV ||\
 	(echo "FATAL: ${SQITCH} version should be at least ${SQITCH_MIN_VERSION}. Make sure the ${SQITCH} executable installed by cpanminus is available has the highest priority in the PATH" && exit 1);
.PHONY: postinstall_check

install: install_cpanm install_cpandeps postinstall_check install_pgtap 
.PHONY: install

docker_build_sqitch:
	# rebuild sqitch
	@@docker build --no-cache -t ${DOCKER_SQITCH_IMAGE}:${DOCKER_SQITCH_TAG} -f docker/sqitch/Dockerfile .
.PHONY: docker_build_sqitch

docker_push_sqitch: docker_build_sqitch
	# push sqitch
	@@docker push ${DOCKER_SQITCH_IMAGE}:${DOCKER_SQITCH_TAG}
.PHONY: docker_push_sqitch

docker_build_postgres:
	# rebuild postgres
	@@docker build --no-cache -t ${DOCKER_POSTGRES_IMAGE}:${DOCKER_POSTGRES_TAG} -f docker/postgres/Dockerfile .
.PHONY: docker_build_postgres

docker_push_postgres: docker_build_postgres
	# push postgres
	@@docker push ${DOCKER_POSTGRES_IMAGE}:${DOCKER_POSTGRES_TAG}
.PHONY: docker_push_postgres

docker_build: docker_build_sqitch docker_build_postgres
.PHONY: docker_build

docker_push: docker_push_sqitch docker_push_postgres
.PHONY: docker_push
