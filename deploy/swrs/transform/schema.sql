-- Deploy ggircs:swrs/transform/schema to pg

begin;

create schema ggircs_swrs_transform;
comment on schema ggircs_swrs_transform is 'A schema containing the transformed data from SWRS (Single Window Reporting System) operated by ECCC (Environment and Climate Change Canada)';

commit;
