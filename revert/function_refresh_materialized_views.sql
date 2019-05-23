-- Revert ggircs:function_refresh_materialized_views from pg

begin;

 drop function ggircs_swrs.refresh_materialized_views;

commit;
