PERL=perl
CPAN=cpan
SQITCH=sqitch
GREP=grep
GIT=git
AWK=awk
PSQL=psql
TEST_DB=ggircs_test

test:
	@@$(MAKE) -s $(MAKEFLAGS) createdb;
	@@$(MAKE) -s $(MAKEFLAGS) deploy;
	@@$(MAKE) -s $(MAKEFLAGS) revert;
	@@$(MAKE) -s $(MAKEFLAGS) deploy;
	@@$(MAKE) -s $(MAKEFLAGS) dropdb;
.PHONY: test

deploy: 
	# Deploy all changes to ${TEST_DB} using sqitch
	@@sqitch deploy ${TEST_DB};
.PHONY: deploy

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

verify:
	# ensure perl >= 5.10.0
	@@${PERL} -e 'print $$] . "\n";'
	@@${PERL} -e 'if ($$] < 5.010001) { exit 1 }'
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
	# ensure postgres is online
	@@${PSQL} -tc 'show server_version;' | ${AWK} '{print $$NF}';
.PHONY: verify

pgtap:
	# clone the source for pgTAP
	@@${GIT} clone https://github.com/theory/pgtap.git && \
		cd pgtap && \
		${GIT} checkout v1.0.0;

install: pgtap
	# install pg_prove
	@@${CPAN} TAP::Parser::SourceHandler::pgTAP
	# install pgTAP into postgres
	@@cd pgtap && \
		$(MAKE) -s $(MAKEFLAGS) && \
		$(MAKE) -s $(MAKEFLAGS) installcheck && \
		$(MAKE) -s $(MAKEFLAGS) install;
	# install sqitch
	@@${CPAN} App::Sqitch
	# install postgres driver for sqitch
	@@${CPAN} DBD::Pg
.PHONY: install
