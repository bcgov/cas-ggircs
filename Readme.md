GGIRCS
[![CircleCI](https://circleci.com/gh/bcgov/cas-ggircs/tree/master.svg?style=shield)](https://circleci.com/gh/bcgov/cas-ggircs/tree/master)
======

> Greenhouse Gas Industrial Reporting and Control System
> for the Climate Action Secretariat

##Getting Started
------------
> Clone repository
> In terminal:
  - Run `make verify`
  - If `make verify` passes:
  - Run `make test`

##Using Sqitch
------------
> **Add Schema**
> - sqitch add schema_[schema_name]

> **Add Table**
> - sqitch add table_[table_name] --require schema_[schema_name] --set schema=[schema_name]

##Dependencies
------------
- [Postgres 10](https://www.postgresql.org/docs/10/index.html)
- [Squitch](https://sqitch.org/)

* [PostgreSQL](http://www.postgresql.org/)

    9.1.0 or higher recommended. Usually available via your distribution's
    package system. Binaries and source are also available
    [for download](http://www.postgresql.org/download/).

* [Git](http://git-scm.com)

    1.7.0 or higher recommended. Usually available via your distribution's
    package system. Binaries and source are also available
    [for download](http://git-scm.com/downloads).

* [pgTAP](http://pgtap.org/)

    0.92.0 or higher recommended. Download
    [from PGXN](http://pgxn.org/dist/pgtap/) and consult its
    [`README.md`](https://github.com/theory/pgtap/blob/master/README.md) for
    build instructions. Also available in some packaging systems.

* [Perl](http://perl.org/)

    5.10.0 or higher. Included in most Unix distributions and on OS X. Windows
    users can install
    [ActivePerl](http://www.activestate.com/activeperl/downloads).

* [`pg_prove`](http://pgtap.org/pg_prove.html)

    3.28 or higher recommended. Available in some packaging systems.
    Otherwise, Download via CPAN:

        cpan TAP::Parser::SourceHandler::pgTAP

    ActivePerl users can use PPI:

        ppm install TAP-Parser-SourceHandler-pgTAP

* [Sqitch](http://sqitch.org/)

    0.97.0 or higher recommended. Install via CPAN:

        cpan App::Sqitch DBD::Pg

    ActivePerl users should use PPI:

        ppi App-Sqitch

    [Homebrew](http://brew.sh) users can use the Sqitch Tap:

        brew tap sqitchers/sqitch
        brew install sqitch --with-postgres-suppor
