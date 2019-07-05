-- Revert ggircs:function_export_fuel_to_ggircs from pg

begin;

drop function ggircs_swrs.export_fuel_to_ggircs;

commit;
