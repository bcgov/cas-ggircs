-- Verify ggircs:function_export_contact_to_ggircs on pg

begin;

select pg_get_functiondef('ggircs_swrs.export_contact_to_ggircs()'::regprocedure);

rollback;
