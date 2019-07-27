-- Revert ggircs:function_load_identifier from pg

begin;

drop function swrs_transform.load_identifier;

commit;
