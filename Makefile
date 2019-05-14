PERL=perl
CPAN=cpan
CPANM=cpanm
SQITCH=sqitch
GREP=grep
GIT=git
AWK=awk
PSQL=psql -h localhost
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

verify_installed:
	# ensure perl >= 5.10.0
	@@${PERL} -e 'print $$] . "\n";'
	@@${PERL} -e 'if ($$] < 5.010001) { exit 1 }'
	# show all perl install paths
	@@${PERL} -V:'install.*'
	# ensure cpan is defined
	@@${PERL} -MCPAN -e 'print $$CPAN::VERSION . "\n";'
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
	# ensure the correct role exist in postgres
ifeq (1,${shell ${PSQL} -qAtc "select count(*) from pg_user where usename='${PG_ROLE}' and usesuper=true"})
	@@echo 'A postgres role with the name "${PG_ROLE}" must exist and have the SUPERUSER privilege.'
	@@exit 1
endif
.PHONY: verify_ready

verify: verify_installed verify_ready
.PHONY: verify

pgtap:
	# clone the source for pgTAP
	@@${GIT} clone https://github.com/theory/pgtap.git && \
		cd pgtap && \
		${GIT} checkout v1.0.0;

install_pgtap: pgtap
	# install pgTAP into postgres
	@@cd pgtap && \
		$(MAKE) -s $(MAKEFLAGS) && \
		$(MAKE) -s $(MAKEFLAGS) installcheck;

	@@/bin/test -w ${PG_SHAREDIR}/extension && \
		cd pgtap && $(MAKE) -s $(MAKEFLAGS) install || \
		echo "FATAL: The current user does not have permission to write to ${PG_SHAREDIR}/extension and install pgTAP." && \
		echo "It needs to be installed by a user having write access to that directory, e.g. with 'cd pgtap && sudo make install'";	
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

install: install_cpanm install_cpandeps install_pgtap
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
