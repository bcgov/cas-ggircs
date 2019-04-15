PERL=perl
CPAN=cpan
SQITCH=sqitch
GREP=grep
PSQL=psql
TEST_DB=ggircs_test

test:
	@@$(MAKE) $(MAKEFLAGS) createdb;
	@@$(MAKE) $(MAKEFLAGS) deploy;
	@@$(MAKE) $(MAKEFLAGS) revert;
	@@$(MAKE) $(MAKEFLAGS) deploy;
	@@$(MAKE) $(MAKEFLAGS) dropdb;
.PHONY: test

deploy: 
	# Deploy all changes to ${TEST_DB} using sqitch
	@@sqitch deploy ${TEST_DB};
.PHONY: deploy

revert:
	# Revert all changes to ${TEST_DB} using sqitch
	@@yes | sqitch revert ${TEST_DB};
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
