-- Deploy ggircs:swrs/public/table/fuel_charge_002 to pg

begin;

alter table swrs.fuel_charge add column comment varchar(10000);
comment on column swrs.fuel_charge.comment is 'Column contains comments pertaining to each fuel charge row';
alter table swrs.fuel_charge add column carbon_tax_act_fuel_type_id int references swrs.carbon_tax_act_fuel_type(id);
comment on column swrs.fuel_charge.carbon_tax_act_fuel_type_id is 'Foreign key references the carbon_tax_act_fuel_type table';
create index swrs_fuel_charge_ct_fuels_foreign_key on swrs.fuel_charge(carbon_tax_act_fuel_type_id);

commit;
