-- Revert ggircs:function_load_unit from pg

begin;

drop function ggircs_swrs_transform.load_unit;

commit;
