-- Deploy ggircs:schema_ciip to pg

begin;

create schema ciip;
comment on schema ggircs is 'A schema for the CleanBC Industrial Incentive Program (CIIP)';

commit;
