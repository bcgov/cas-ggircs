-- Revert ggircs:swrs/public/table/fuel_carbon_tax_details_001 from pg

begin;

alter table swrs.fuel_carbon_tax_details add column cta_mapping varchar(1000);
alter table swrs.fuel_carbon_tax_details drop column carbon_tax_act_fuel_type_id;

commit;
