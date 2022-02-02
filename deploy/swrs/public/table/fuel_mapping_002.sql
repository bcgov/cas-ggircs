-- Deploy ggircs:swrs/public/table/fuel_mapping_002 to pg
-- requires: swrs/public/table/fuel_mapping
-- requires: swrs/transform/function/load

begin;


alter table swrs.fuel_mapping
add constraint fuel_carbon_tax_details_foreign_key
foreign key (fuel_carbon_tax_details_id)
references swrs.fuel_carbon_tax_details (id);

commit;
