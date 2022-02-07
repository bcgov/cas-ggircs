-- Deploy ggircs:swrs/public/table/fuel_mapping_001 to pg
-- requires: swrs/public/table/fuel_mapping

begin;

create index fuel_mapping_ct_details_foreign_key on swrs.fuel_mapping(fuel_carbon_tax_details_id);

commit;
