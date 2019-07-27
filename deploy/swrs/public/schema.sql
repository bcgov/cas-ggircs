-- Deploy ggircs:swrs/public/schema to pg

begin;

create schema swrs;
comment on schema swrs is 'A schema containing the loaded data from SWRS. This schema contains the data available in Metabase';

commit;
