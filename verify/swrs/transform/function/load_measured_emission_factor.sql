-- Verify ggircs:function_load_measured_emission_factor on pg

begin;

select pg_get_functiondef('swrs_transform.load_measured_emission_factor()'::regprocedure);

rollback;
