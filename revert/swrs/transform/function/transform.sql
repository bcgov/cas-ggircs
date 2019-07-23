-- Revert ggircs:function_transform from pg

begin;

 drop function swrs_transform.transform;

commit;
