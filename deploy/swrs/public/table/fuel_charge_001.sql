-- Deploy ggircs:swrs/public/table/fuel_charge_001 to pg
-- requires: swrs/public/table/fuel_charge
-- requires: swrs/public/table/fuel_carbon_tax_details

begin;

alter table swrs.fuel_charge add column fuel_carbon_tax_details_id int references swrs.fuel_carbon_tax_details(id);
create index swrs_fuel_charge_fuel_ctd_foreign_key on swrs.fuel_charge(fuel_carbon_tax_details_id);

commit;

-- (select fuel_carbon_tax_details_id from swrs.fuel_mapping id =1)
