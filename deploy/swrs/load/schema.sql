-- Deploy ggircs:swrs/load/schema to pg

begin;

create schema ggircs_swrs_load;
comment on schema ggircs_swrs_load is 'A schema containing the loaded data from SWRS. This schema contains the data available in Metabase';

commit;
