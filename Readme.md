GGIRCS
[![CircleCI](https://circleci.com/gh/bcgov/cas-ggircs/tree/master.svg?style=shield)](https://circleci.com/gh/bcgov/cas-ggircs/tree/master)
======

> Greenhouse Gas Industrial Reporting and Control System
> for the Climate Action Secretariat

## Getting Started
------------
> Clone repository
> In terminal:
  - Run `make verify` to ensure minimum required versions of all dependencies are installed and postgres is online
  - Run `make install` to set up a development environment
  - Run `make test` to execute all pgTAP-based tests against a `ggircs_test` database
  - If needed, create a development database using `$ createdb ggircs_dev`
  - Run `sqitch deploy` to deploy to a `ggircs_dev` database

## Using Sqitch
------------
If you're new to Sqitch, the best place to start is with [the tutorial](https://github.com/sqitchers/sqitch/blob/master/lib/sqitchtutorial.pod) and other [docs](https://sqitch.org/docs/).

> **Add Schema**
> - sqitch add schema_[schema_name]
-
> **Add Table**
> - sqitch add table_[table_name] --require schema_[schema_name] --set schema=[schema_name]

## Dependencies
------------
1. [PostgreSQL](http://www.postgresql.org/)

- 10 or higher recommended. Usually available via your distribution's package system. Binaries and source are also available [for download](http://www.postgresql.org/download/).

- A role with the following options must be created:
    - The role name is your current user name (`$ whoami`)
    - The role has the SUPERUSER option

2. [Git](http://git-scm.com)

    1.7.0 or higher recommended. Usually available via your distribution's
    package system. Binaries and source are also available
    [for download](http://git-scm.com/downloads).

4. [Perl](http://perl.org/)

    5.10.0 or higher. Included in most Unix distributions and on OS X. Windows
    users can install
    [ActivePerl](http://www.activestate.com/activeperl/downloads).

