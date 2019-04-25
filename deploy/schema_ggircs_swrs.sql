-- Deploy ggircs:schema_ggircs_swrs to pg

begin;

create schema ggircs_swrs;
comment on schema ggircs_swrs is 'A schema to encapsulate interaction with the SWRS (Single Window Reporting System) operated by ECCC (Environment and Climate Change Canada)';

commit;
