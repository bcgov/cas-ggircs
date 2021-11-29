-- Deploy ggircs:swrs/public/table/emission_002 to pg
-- requires: swrs/public/table/emission_001

begin;

create index emission_fuel_mapping_foreign_key on swrs.emission(fuel_mapping_id);

commit;
