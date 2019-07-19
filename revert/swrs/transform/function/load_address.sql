-- Revert ggircs:function_load_address from pg

begin;

drop function ggircs_swrs_transform.load_address;

commit;
