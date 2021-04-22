-- Deploy ggircs:view_pro_rated_fuel_charge to pg
-- requires: table_report
-- requires: table_fuel
-- requires: table_fuel_mapping
-- requires: table_fuel_charge

begin;

drop view swrs.pro_rated_fuel_charge;

commit;
