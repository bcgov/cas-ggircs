-- Revert ggircs:function_load_naics from pg

begin;

drop function ggircs_swrs_transform.load_naics;

commit;
