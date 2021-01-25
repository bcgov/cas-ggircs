# Welcome to GGIRCS

GGIRCS stands for **Greenhouse Gas Industrial Reporting and Control System** for the Climate Action Secretariat (CAS).

## Description

GGIRCS is a tool designed to modernize the annual reporting and verification of greenhouse gas industrial emissions. This project is a fulfillment to meet the requirements of the BC government initiatives including Climate Strategy, Clean Growth and CleanBC, part of the Greenhouse Gas Industrial Reporting and Control Act [GGIRCA].

## Status

- Master Pipeline: [![CircleCI](https://circleci.com/gh/bcgov/cas-ggircs/tree/master.svg?style=shield)](https://circleci.com/gh/bcgov/cas-ggircs/tree/master)

- Develop Pipeline:

- Functional Test:

## Usage

### Clone repository

> In terminal:

- Run `make verify` to ensure minimum required versions of all dependencies are installed and postgres is online (see the [dependencies](#Dependencies) section below)

- Run `make install` to set up a development environment

- Run `make test` to execute all pgTAP-based tests against a `ggircs_test` database

- If needed, create a development database using `$ createdb ggircs_dev`

- Run `sqitch deploy` to deploy to a `ggircs_dev` database

### Using Sqitch

---

If you're new to Sqitch, the best place to start is with [the tutorial](https://github.com/sqitchers/sqitch/blob/master/lib/sqitchtutorial.pod) and other [docs](https://sqitch.org/docs/).

> **Add Schema**

> - sqitch add schema\_[schema_name]

> **Add Table**

> - sqitch add table*[table_name] --require schema*[schema_name] --set schema=[schema_name]

### Dependencies

---

### [PostgreSQL](http://www.postgresql.org/)

#### Installation

Version 10 or higher recommended. Usually available via your distribution's package system. Binaries and source are also available [for download](http://www.postgresql.org/download/). The PostgreSQL wiki has a [list of detailed installation guides](https://wiki.postgresql.org/wiki/Detailed_installation_guides) where you can find some OS-specific instructions.

A role/user with the following options must be created (see [this tutorial](https://tableplus.io/blog/2018/10/how-to-create-superuser-in-postgresql.html) if you need information on how to create roles):

- The role name is your current user name (`$ whoami`)

- The role has the SUPERUSER option

### [Git](http://git-scm.com)

1.7.0 or higher recommended. Usually available via your distribution's package system. Binaries and source are also available [for download](http://git-scm.com/downloads).

### [Perl](http://perl.org/)

5.10.0 or higher. Included in most Unix distributions and on OS X. Windows users can install [ActivePerl](http://www.activestate.com/activeperl/downloads). The Perl website has [OS-specific installation instructions](https://learn.perl.org/installing/).

## Data

### Excluding Test Data

The data-set that is parsed by the ETL process includes some test data that needs to be excluded from the actual data housed in the swrs schema. This is achieved in `swrs/transform/table/ignore_organisation` by adding the `swrs_organisation_id` of organisations that were created for test purposes to this table. A join on this table in the `swrs/transform/view/final_report` view then ignores these organisations when loading data into the final schema.

### Data Architecture

(TBC)

### Project Material Publication

The materials published include:

- [Code Repositories](https://github.com/bcgov?utf8=%E2%9C%93&q=cas&type=&language=)
- /bcgov/cas-airflow-dags
- /bcgov/cas-ciip-portal
- /bcgov/cas-docker-metabase
- /bcgov/cas-docker-sqitch
- /bcgov/cas-ggircs
- /bcgov/cas-ggircs-ciip-2018-extract
- /bcgov/cas-ggircs-ciip-2018-schema
- /bcgov/cas-ggircs-metabase
- /bcgov/cas-ggircs-metabase-build
- /bcgov/cas-ggircs-metabase-builder
- /bcgov/cas-helm
- /bcgov/cas-metascript
- /bcgov/cas-pipeline
- /bcgov/cas-postgres
- /bcgov/cas-shelf
- /bcgov/cas-shipit
- /bcgov/cas-shipit-engine

### Files in this repository

```

```

## Documentation

- [GGIRCS Readme](https://raw.githubusercontent.com/bcgov/cas-ggircs/develop/Readme.md)

- [GGIRCS Project Documentation - TBD](https://github.com/bcgov/cas-ggircs/wiki)

- [GGIRCS Developer Documentation - TBD](https://github.com/bcgov/cas-ggircs-docs/)

- [GGIRCS Style Guide](https://developer.gov.bc.ca/components)

## Contributors

- [Developers](https://github.com/bcgov/cas-ggircs/graphs/contributors)
