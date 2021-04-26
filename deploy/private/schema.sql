-- Deploy ggircs:private/schema to pg

begin;

create schema swrs_private;
comment on schema swrs_private is 'A private schema containing the functions needed for the SWRS ETL';

commit;
