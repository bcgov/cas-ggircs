-- Revert ggircs:swrs/public/table/fuel_charge_002 from pg

begin;

alter table swrs.fuel_charge drop column carbon_tax_act_fuel_type_id;

commit;
