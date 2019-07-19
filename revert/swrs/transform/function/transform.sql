-- Revert ggircs:function_transform from pg

begin;

 drop function ggircs_swrs_transform.transform;

commit;
