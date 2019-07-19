-- Revert ggircs:function_load_fuel from pg

begin;

drop function ggircs_swrs_transform.load_fuel;

commit;
