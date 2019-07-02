-- Verify ggircs:function_export_measured_emission_factor on pg

begin;

select pg_get_functiondef('ggircs_swrs.export_measured_emission_factor_to_ggircs()'::regprocedure);

rollback;
