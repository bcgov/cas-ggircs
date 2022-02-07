-- Revert ggircs:swrs/public/table/fuel_charge_001 from pg

begin;

alter table swrs.fuel_charge drop column fuel_carbon_tax_details_id;

commit;
