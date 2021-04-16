-- Deploy ggircs:swrs/public/table/fuel_charge_002 to pg

begin;

alter table swrs.fuel_charge add column carbon_tax_act_fuel_type_id int references swrs.carbon_tax_act_fuel_type(id);
create index swrs_fuel_charge_ct_fuels_foreign_key on swrs.fuel_charge(carbon_tax_act_fuel_type_id);

commit;
