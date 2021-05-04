-- Revert ggircs:swrs/public/table/fuel_charge_003 from pg

begin;

alter table swrs.fuel_charge add column fuel_carbon_tax_details_id int;
alter table swrs.fuel_charge add column fuel_mapping_id int;

commit;
