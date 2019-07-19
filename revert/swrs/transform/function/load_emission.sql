-- Revert ggircs:function_load_emission from pg

begin;

drop function ggircs_swrs_transform.load_emission;

commit;
