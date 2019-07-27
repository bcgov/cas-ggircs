-- Deploy ggircs:schema_ciip to pg

begin;

create schema ciip_2018;
comment on schema ciip_2018 is 'A schema for the CleanBC Industrial Incentive Program (CIIP)';

commit;
