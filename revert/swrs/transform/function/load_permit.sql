-- Revert ggircs:function_load_permit from pg

begin;

drop function swrs_transform.load_permit;

commit;
