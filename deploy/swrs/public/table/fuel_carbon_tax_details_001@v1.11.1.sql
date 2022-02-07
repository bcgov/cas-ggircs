-- Deploy ggircs:swrs/public/table/fuel_carbon_tax_details_001 to pg
-- requires: swrs/public/table/fuel_carbon_tax_details
-- requires: swrs/public/table/carbon_tax_act_fuel_type

begin;

alter table swrs.fuel_carbon_tax_details drop column cta_mapping;
alter table swrs.fuel_carbon_tax_details add column carbon_tax_act_fuel_type_id int references swrs.carbon_tax_act_fuel_type(id);
create index swrs_ctd_ct_fuels_foreign_key on swrs.fuel_carbon_tax_details(carbon_tax_act_fuel_type_id);

commit;
