-- Deploy ggircs:swrs/extract/schema to pg

begin;

create schema ggircs_swrs_extract;
comment on schema ggircs_swrs_extract is 'A schema containing the extracted raw XML data from SWRS (Single Window Reporting System) operated by ECCC (Environment and Climate Change Canada)';

commit;
