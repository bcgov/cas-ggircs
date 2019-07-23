-- Revert ggircs:function_load_activity from pg

begin;

 drop function swrs_transform.load_activity;

commit;
