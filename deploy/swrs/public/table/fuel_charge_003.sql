-- Deploy ggircs:swrs/public/table/fuel_charge_003 to pg
-- requires: swrs/public/table/fuel_charge_002

begin;

alter table swrs.fuel_charge drop column fuel_mapping_id;
alter table swrs.fuel_charge drop column fuel_carbon_tax_details_id;

commit;
