-- Revert ggircs:swrs/public/table/fuel_mapping_002 from pg

begin;

alter table swrs.fuel_mapping drop constraint fuel_carbon_tax_details_foreign_key;

commit;
