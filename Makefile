SHELL := /usr/bin/env bash

ifndef CI_NO_POSTGRES
PERL=perl
RSYNC=rsync
PERL_VERSION=$(shell $(PERL) -e 'print substr($$^V, 1)')
PERL_MIN_VERSION=5.10
CPAN=cpan
CPANM=cpanm
SQITCH=sqitch
SQITCH_VERSION=$(word 3,$(shell $(SQITCH) --version))
SQITCH_MIN_VERSION=0.97
GREP=grep
AWK=awk
PSQL=psql -h localhost
# "psql --version" prints "psql (PostgreSQL) XX.XX"
PSQL_VERSION=$(word 3,$(shell $(PSQL) --version))
PG_SERVER_VERSION=$(strip $(shell $(PSQL) -tc 'show server_version;' || echo error))
PG_MIN_VERSION=9.1
TEST_DB=ggircs_test
PG_PROVE=pg_prove -h localhost
PG_SHAREDIR=$(shell pg_config --sharedir)
PG_ROLE=$(shell whoami)

.PHONY: test
test:
	@@$(MAKE) -s $(MAKEFLAGS) createdb;
	@@$(MAKE) -s $(MAKEFLAGS) deploy;
	@@$(MAKE) -s $(MAKEFLAGS) revert;
	@@$(MAKE) -s $(MAKEFLAGS) deploy;
	@@$(MAKE) -s $(MAKEFLAGS) prove_unit;
	@@$(MAKE) -s $(MAKEFLAGS) prove_style;
	@@$(MAKE) -s $(MAKEFLAGS) dropdb;

.PHONY: unit
unit: dropdb createdb deploy prove_unit

.PHONY: deploy
deploy:
	# Deploy all changes to $(TEST_DB) using sqitch
	@@$(SQITCH) deploy $(TEST_DB);

.PHONY: prove_style
prove_style:
	# Run style-related test suite on all objects in db using pg_prove
	@@$(PG_PROVE) -v -d $(TEST_DB) test/style/*_test.sql

.PHONY: prove_unit
prove_unit:
	# Run unit test suite using pg_prove
	@@$(PG_PROVE) -d $(TEST_DB) test/unit/*_test.sql

.PHONY: revert
revert:
	# Revert all changes to $(TEST_DB) using sqitch
	@@$(SQITCH) revert -y $(TEST_DB);

.PHONY: createdb
createdb:
	# Ensure the $(TEST_DB) database exists
	-@@$(PSQL) -tc "SELECT 1 FROM pg_database WHERE datname = '$(TEST_DB)'" | \
		$(GREP) -q 1 || \
		$(PSQL) -c "CREATE DATABASE $(TEST_DB)";

.PHONY: dropdb
dropdb:
	# Drop the $(TEST_DB) database
	-@@$(PSQL) -tc "SELECT 1 FROM pg_database WHERE datname = '$(TEST_DB)'" | \
		$(GREP) -q 0 || \
		$(PSQL) -c "DROP DATABASE $(TEST_DB)";

define check_file_in_path
	$(if $(shell which $(word 1,$(1))),
		$(info ✓ Found $(word 1,$(1))),
		$(error ✖ No $(word 1,$(1)) in path.)
	)
endef

define check_min_version_num
	$(if $(shell printf '%s\n%s\n' "$(3)" "$(2)" | sort -CV || echo error),
		$(error ✖ $(word 1,$(1)) version needs to be at least $(3).),
		$(info ✓ $(word 1,$(1)) version is at least $(3).)
	)
endef

.PHONY: verify_installed
verify_installed:
	$(call check_file_in_path,$(PERL))
	$(call check_min_version_num,$(PERL),$(PERL_VERSION),$(PERL_MIN_VERSION))

	$(call check_file_in_path,$(CPAN))
	$(call check_file_in_path,$(GIT))
	$(call check_file_in_path,$(RSYNC))

	$(call check_file_in_path,$(PSQL))
	$(call check_min_version_num,$(PSQL),$(PSQL_VERSION),$(PG_MIN_VERSION))
	@@echo ✓ External dependencies are installed

.PHONY: verify_pg_server
verify_pg_server:
ifeq (error,$(PG_SERVER_VERSION))
	$(error Error while connecting to postgres server)
else
	$(info postgres is online)
endif

ifneq ($(PSQL_VERSION), $(PG_SERVER_VERSION))
	$(error psql version ($(PSQL_VERSION)) does not match the server version ($(PG_SERVER_VERSION)) )
else
	$(info psql and server versions match)
endif

ifeq (0,$(shell $(PSQL) -qAtc "select count(*) from pg_user where usename='$(PG_ROLE)' and usesuper=true"))
	$(error A postgres role with the name "$(PG_ROLE)" must exist and have the SUPERUSER privilege.)
else
	$(info postgres role "$(PG_ROLE)" has appropriate privileges)
endif

	@@echo ✓ PostgreSQL server is ready

.PHONY: verify
verify: verify_installed verify_pg_server

.PHONY: verify_ready
verify_ready:
	# ensure postgres is online
	@@$(PSQL) -tc 'show server_version;' | $(AWK) '{print $$NF}';

.PHONY: verify
verify: verify_installed verify_ready

pgtap:
	# clone the source for pgTAP
	@@$(GIT) clone https://github.com/theory/pgtap.git && \
		pushd pgtap && \
		$(GIT) checkout v1.0.0;

.PHONY: install_pgtap
install_pgtap: pgtap
	$(info install pgTAP into postgres)
	@@$(MAKE) -C pgtap -s $(MAKEFLAGS)
	@@$(MAKE) -C pgtap -s $(MAKEFLAGS) installcheck

ifeq (error,$(shell /bin/test -w $(PG_SHAREDIR)/extension || echo error))
	@@echo "FATAL: The current user does not have permission to write to $(PG_SHAREDIR)/extension and install pgTAP.\
 It needs to be installed by a user having write access to that directory, e.g. with 'sudo make -C pgtap install'" && exit 1
else
	@@$(MAKE) -C pgtap -s $(MAKEFLAGS) install
endif

.PHONY: install_cpanm
install_cpanm:
ifeq ($(shell which $(CPANM)),)
	# install cpanm
	@@$(CPAN) App:cpanminus
endif

.PHONY: install_cpandeps
install_cpandeps:
	# install Perl dependencies from cpanfile
	$(CPANM) --installdeps .

.PHONY: postinstall_check
postinstall_check:
	@@printf '%s\n%s\n' "$(SQITCH_MIN_VERSION)" "$(SQITCH_VERSION)" | sort -CV ||\
 	(echo "FATAL: $(SQITCH) version should be at least $(SQITCH_MIN_VERSION). Make sure the $(SQITCH) executable installed by cpanminus is available has the highest priority in the PATH" && exit 1);

.PHONY: dev_install
dev_install: install_cpanm install_cpandeps postinstall_check install_pgtap
endif

ifndef CI_NO_PIPELINE
SHELL := /usr/bin/env bash
THIS_FILE := $(lastword $(MAKEFILE_LIST))
THIS_FOLDER := $(abspath $(realpath $(lastword $(MAKEFILE_LIST)))/../)
ifeq ($(MAKECMDGOALS),$(filter $(MAKECMDGOALS),help whoami project configure provision mock_storageclass install))
include $(THIS_FOLDER)/.pipeline/oc.mk
endif
PATHFINDER_PREFIX := 9212c9
PROJECT_PREFIX := cas-

.PHONY: help
help: $(call make_help,help,Explains how to use this Makefile)
	@@exit 0

.PHONY: targets
targets: $(call make_help,targets,Lists all targets in this Makefile)
	$(call make_list_targets,$(THIS_FILE))

.PHONY: whoami
whoami: $(call make_help,whoami,Prints the name of the user currently authenticated via `oc`)
	$(call oc_whoami)

.PHONY: project
project: whoami
project: $(call make_help,project,Switches to the desired $$OC_PROJECT namespace)
	$(call oc_project)

.PHONY: install
install: whoami
	@helm dep up ./helm/cas-ggircs
	@helm upgrade --install --atomic --timeout 900s \
		--namespace $(GGIRCS_NAMESPACE_PREFIX)-$(ENVIRONMENT) --set image.etl.tag=$(GIT_SHA1) \
		--set image.ecccUpload.tag=$(GIT_SHA1) --set image.ecccExtract.tag=$(GIT_SHA1) \
		--set image.app.tag=$(GIT_SHA1) --set image.schema.tag=$(GIT_SHA1) \
		--values ./helm/cas-ggircs/values.yaml \
		--values ./helm/cas-ggircs/values-$(ENVIRONMENT).yaml \
		--set ciip.release=cas-ciip-portal \
		--set ciip.namespace="$(CIIP_NAMESPACE_PREFIX)-$(ENVIRONMENT)" \
		cas-ggircs ./helm/cas-ggircs
	# Copying generated ggircs database secret to ciip namespace, removing namespace-specific metadata
	$(OC) get secret cas-ggircs --namespace=$(GGIRCS_NAMESPACE_PREFIX)-$(ENVIRONMENT) -o json \
		| jq 'del(.metadata.namespace,.metadata.resourceVersion,.metadata.uid,.metadata.annotations,.metadata.managedFields,.metadata.selfLink) | .metadata.creationTimestamp=null' \
		| oc apply --namespace="$(CIIP_NAMESPACE_PREFIX)-$(ENVIRONMENT)" -f -
endif

.PHONY: mock_storageclass
mock_storageclass:
	$(call oc_mock_storageclass, netapp-block-standard)
	$(call oc_mock_storageclass, netapp-file-standard)

.PHONY: provision
provision:
	$(call oc_new_project,$(OC_TOOLS_PROJECT))
	$(call oc_new_project,$(OC_TEST_PROJECT))
	$(call oc_new_project,$(OC_DEV_PROJECT))
	$(call oc_new_project,$(OC_PROD_PROJECT))

.PHONY: install_asdf_tools
install_asdf_tools:
	@cat .tool-versions | cut -f 1 -d ' ' | xargs -n 1 asdf plugin-add || true
	@asdf plugin-update --all
	@bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
	@#MAKELEVEL=0 is required because of https://www.postgresql.org/message-id/1118.1538056039%40sss.pgh.pa.us
	@MAKELEVEL=0 POSTGRES_EXTRA_CONFIGURE_OPTIONS='--with-libxml' asdf install
	@asdf reshim
