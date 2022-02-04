-- Deploy ggircs:swrs/utility/schema to pg

begin;

create schema swrs_utility;
grant usage on schema swrs_utility to ggircs_user;
comment on schema swrs is 'A schema containing functions, mutations and contextual data relating to the ETL swrs schema that should not be dropped during the ETL process';

commit;