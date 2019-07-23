-- Deploy ggircs:swrs/extract/schema to pg

begin;

create schema swrs_extract;
comment on schema swrs_extractschema containing the extracted raw XML data from SWRS (Single Window Reporting System) operated by ECCC (Environment and Climate Change Canada)';

commit;
