-- Deploy ggircs:swrs/transform/schema to pg

begin;

create schema swrs_transform;
comment on schema swrs_transform is 'A schema containing the transformed data from SWRS (Single Window Reporting System) operated by ECCC (Environment and Climate Change Canada)';

commit;
