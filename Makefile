PERL=perl
CPAN=cpan
SQITCH=sqitch
GREP=grep
GIT=git
AWK=awk
PSQL=psql -h localhost
TEST_DB=ggircs_test
PG_PROVE=pg_prove -h localhost
DOCKER=docker
DOCKER_HUB_PREFIX=wenzowski/
DOCKER_SQITCH_IMAGE=sqitch
DOCKER_SQITCH_TAG=0.9999
DOCKER_GGIRCS_IMAGE=ggircs
DOCKER_GGIRCS_TAG=latest
DOCKER_POSTGRES_IMAGE=postgres
DOCKER_POSTGRES_TAG=11.2
OC:=oc
OC_DEV_PROJECT:=wksv3k-dev
OC_TEST_PROJECT:=wksv3k-test
OC_PROD_PROJECT:=wksv3k-prod
OC_TOOLS_PROJECT:=wksv3k-tools

test:
	@@${MAKE} -s ${MAKEFLAGS} createdb;
	@@${MAKE} -s ${MAKEFLAGS} deploy;
	@@${MAKE} -s ${MAKEFLAGS} revert;
	@@${MAKE} -s ${MAKEFLAGS} deploy;
	@@${MAKE} -s ${MAKEFLAGS} prove_unit;
	@@${MAKE} -s ${MAKEFLAGS} prove_style;
	@@${MAKE} -s ${MAKEFLAGS} dropdb;
.PHONY: test

unit: dropdb createdb deploy prove_unit
.PHONY: unit

deploy: 
	# Deploy all changes to ${TEST_DB} using sqitch
	@@${SQITCH} deploy ${TEST_DB};
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
	@@${SQITCH} revert -y ${TEST_DB};
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

verify_installed:
	# ensure perl >= 5.10.0
	@@${PERL} -e 'print $$] . "\n";'
	@@${PERL} -e 'if ($$] < 5.010001) { exit 1 }'
	# show all perl install paths
	@@${PERL} -V:'install.*'
	# ensure cpan is defined
	@@${PERL} -MCPAN -e 'print $$CPAN::VERSION . "\n";'
	# ensure sqitch is >= 0.97.0
	@@${PERL} -MApp::Sqitch -e 'print $$App::Sqitch::VERSION . "\n";'
	@@${PERL} -MApp::Sqitch -e 'if ($$App::Sqitch::VERSION < 0.97) { exit 1 };'
	# ensure postgres driver is installed
	@@${PERL} -MDBD::Pg -e 'print $$DBD::Pg::VERSION . "\n";'
	# ensure pg_prove is >= 3.28
	@@${PERL} -MTAP::Parser::SourceHandler::pgTAP -e 'print $$TAP::Parser::SourceHandler::pgTAP::VERSION . "\n";'
	@@${PERL} -MTAP::Parser::SourceHandler::pgTAP -e 'if ($$TAP::Parser::SourceHandler::pgTAP::VERSION < 3.28) { exit 1 };'
	# ensure awk is installed
	@@${AWK} --version | ${AWK} '{print $$NF}';
	# ensure git is installed
	@@${GIT} --version | ${AWK} '{print $$NF}';
	# ensure psql is installed
	@@${PSQL} --version | ${AWK} '{print $$NF}';
.PHONY: verify_installed

verify_ready:
	# ensure postgres is online
	@@${PSQL} -tc 'show server_version;' | ${AWK} '{print $$NF}';
.PHONY: verify_ready

verify: verify_installed verify_ready
.PHONY: verify

pgtap:
	# clone the source for pgTAP
	@@${GIT} clone https://github.com/theory/pgtap.git && \
		cd pgtap && \
		${GIT} checkout v1.0.0;

install_pgtap: pgtap
	# install pg_prove
	@@${CPAN} TAP::Parser::SourceHandler::pgTAP
	# install pgTAP into postgres
	@@cd pgtap && \
		$(MAKE) -s $(MAKEFLAGS) && \
		$(MAKE) -s $(MAKEFLAGS) installcheck && \
		$(MAKE) -s $(MAKEFLAGS) install;
.PHONY: install_pgtap

install_sqitch:
	# install sqitch
	@@${CPAN} App::Sqitch
	# install postgres driver for sqitch
	@@${CPAN} DBD::Pg
	# install pg_prove
	@@${CPAN} TAP::Parser::SourceHandler::pgTAP
.PHONY: install_sqitch

install: install_sqitch install_pgtap
.PHONY: install

docker_build_sqitch:
	# rebuild sqitch
	@@${DOCKER} build -t docker.io/${DOCKER_HUB_PREFIX}${DOCKER_SQITCH_IMAGE}:${DOCKER_SQITCH_TAG} -f docker/sqitch/Dockerfile .
.PHONY: docker_build_sqitch

docker_push_sqitch: docker_build_sqitch
	# push sqitch
	@@${DOCKER} push docker.io/${DOCKER_HUB_PREFIX}${DOCKER_SQITCH_IMAGE}:${DOCKER_SQITCH_TAG}
.PHONY: docker_push_sqitch

docker_build_ggircs:
	# rebuild ggircs
	@@${DOCKER} build -t docker.io/${DOCKER_HUB_PREFIX}${DOCKER_GGIRCS_IMAGE}:${DOCKER_GGIRCS_TAG} -f docker/ggircs/Dockerfile .
.PHONY: docker_build_ggircs

docker_push_ggircs: docker_build_ggircs
	# push ggircs
	@@${DOCKER} push docker.io/${DOCKER_HUB_PREFIX}${DOCKER_GGIRCS_IMAGE}:${DOCKER_GGIRCS_TAG}
.PHONY: docker_push_ggircs

docker_build_postgres:
	# rebuild postgres
	@@${DOCKER} build -t docker.io/${DOCKER_HUB_PREFIX}${DOCKER_POSTGRES_IMAGE}:${DOCKER_POSTGRES_TAG} -f docker/postgres/Dockerfile .
.PHONY: docker_build_postgres

docker_push_postgres: docker_build_postgres
	# push postgres
	@@${DOCKER} push docker.io/${DOCKER_HUB_PREFIX}${DOCKER_POSTGRES_IMAGE}:${DOCKER_POSTGRES_TAG}
.PHONY: docker_push_postgres

docker_build: docker_build_sqitch docker_build_ggircs docker_build_postgres
.PHONY: docker_build

docker_push: docker_push_sqitch docker_push_ggircs docker_push_postgres
.PHONY: docker_push

whoami:
	# Ensure the openshift client has a valid access token
	@@${OC} whoami
.PHONY: whoami

tools_project: whoami
	# Ensure the openshift client is using the correct project namespace
	@@${OC} project ${OC_TOOLS_PROJECT}
.PHONY: tools_project

dev_project: whoami
	# Ensure the openshift client is using the correct project namespace
	@@${OC} project ${OC_DEV_PROJECT}
.PHONY: tools_project

import: tools_project docker_push
	# Import prebuilt images from docker.io to openshift...
	#   - sqitch
	@@${OC} import-image docker.io/${DOCKER_HUB_PREFIX}${DOCKER_SQITCH_IMAGE}:${DOCKER_SQITCH_TAG} --confirm -o yaml > openshift/imagestream-sqitch.yml
	#   - ggircs
	@@${OC} import-image docker.io/${DOCKER_HUB_PREFIX}${DOCKER_GGIRCS_IMAGE}:${DOCKER_GGIRCS_TAG} --confirm -o yaml > openshift/imagestream-ggircs.yml
	#   - postgres
	@@${OC} import-image docker.io/${DOCKER_HUB_PREFIX}${DOCKER_POSTGRES_IMAGE}:${DOCKER_POSTGRES_TAG} --confirm -o yaml > openshift/imagestream-postgres.yml
	# done.
.PHONY: import

dev_release: import # dev_project
	# Deploy...
	# oc get --export template postgresql-persistent -n openshift > openshift/template-postgresql-persistent.yml
	# ${OC} new-app --name=${DOCKER_GGIRCS_IMAGE}-${DOCKER_POSTGRES_IMAGE} --docker-image=docker-registry.default.svc:5000/${OC_TOOLS_PROJECT}/${DOCKER_POSTGRES_IMAGE}:${DOCKER_POSTGRES_TAG} -o yaml > openshift/app-ggircs-postgres.yml
	# --> Found Docker image d86bc6d (13 minutes old) from docker-registry.default.svc:5000 for "docker-registry.default.svc:5000/wksv3k-tools/postgres:11.2"
	# 
	#     * An image stream tag will be created as "ggircs-postgres:11.2" that will track this image
	#     * This image will be deployed in deployment config "ggircs-postgres"
	#     * Port 5432/tcp will be load balanced by service "ggircs-postgres"
	#       * Other containers can access this service through the hostname "ggircs-postgres"
	#     * This image declares volumes and will default to use non-persistent, host-local storage.
	#       You can add persistent volumes later by running 'volume dc/ggircs-postgres --add ...'
	# 
	# --> Creating resources ...
	#     imagestream.image.openshift.io "ggircs-postgres" created
	#     deploymentconfig.apps.openshift.io "ggircs-postgres" created
	#     service "ggircs-postgres" created
	# --> Success
	#     Application is not exposed. You can expose services to the outside world by executing one or more of the commands below:
	#      'oc expose svc/ggircs-postgres'
	#     Run 'oc status' to view your app.
	# ${OC} set volume dc/${DOCKER_GGIRCS_IMAGE}-${DOCKER_POSTGRES_IMAGE} --add --type=persistentVolumeClaim --mount-path=/var/lib/postgresql/data --claim-size=50Gi
	# Migrate...
.PHONY: dev_release

openshift_build:
	# Configure image streams
	oc new-build --dry-run=true --strategy=docker --context-dir=docker/sqitch/ --name=cas-ggircs-sqitch https://github.com/bcgov/cas-ggircs.git -o yaml > openshift/cas-ggircs-sqitch.yml
	oc new-build --dry-run=true --strategy=docker --context-dir=docker/postgres/ --name=cas-ggircs-postgres https://github.com/bcgov/cas-ggircs.git -o yaml > openshift/cas-ggircs-postgres.yml
	oc apply -f openshift/cas-ggircs-postgres.yml
	oc apply -f openshift/cas-ggircs-sqitch.yml
.PHONY: openshift_build
