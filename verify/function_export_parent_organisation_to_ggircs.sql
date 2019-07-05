-- Verify ggircs:function_export_parent_organisation_to_ggircs on pg

begin;

select pg_get_functiondef('ggircs_swrs.export_parent_organisation_to_ggircs()'::regprocedure);

rollback;
