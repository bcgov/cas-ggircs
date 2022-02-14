-- Deploy ggircs:swrs/parameters/schema to pg

begin;

create schema ggircs_parameters;
comment on schema ggircs_parameters is 'A schema containing functions, mutations and contextual data relating to the ETL swrs schema that should not be dropped during the ETL process';

commit;
