PERL=perl
CPAN=cpan
SQITCH=sqitch
GREP=grep
GIT=git
AWK=awk
PSQL=psql -h localhost
TEST_DB=ggircs_test
PG_PROVE=pg_prove -h localhost
DOCKER_SQITCH_IMAGE=wenzowski/sqitch
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
