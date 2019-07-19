-- Revert ggircs:function_load_identifier from pg

begin;

drop function ggircs_swrs_transform.load_identifier;

commit;
