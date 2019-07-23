-- Revert ggircs:function_load_unit from pg

begin;

drop function swrs_transform.load_unit;

commit;
