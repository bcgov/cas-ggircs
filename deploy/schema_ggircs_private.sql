-- Deploy ggircs:schema_ggircs_private to pg

begin;

create schema ggircs_private;
comment on schema ggircs_private is 'A schema to encapsulate interaction with the SWRS (Single Window Reporting System) operated by ECCC (Environment and Climate Change Canada)';

commit;
