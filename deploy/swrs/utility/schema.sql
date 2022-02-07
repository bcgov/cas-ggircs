-- Deploy ggircs:swrs/utility/schema to pg

begin;

create schema swrs_utility;

comment on schema swrs_utility is 'A schema containing functions, mutations and contextual data relating to the ETL swrs schema that should not be dropped during the ETL process';

commit;
