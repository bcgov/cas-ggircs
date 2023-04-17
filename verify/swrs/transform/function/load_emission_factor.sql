-- Verify ggircs:swrs/transform/function/load_emission_factor on pg

begin;

select pg_get_functiondef('swrs_transform.load_emission_factor()'::regprocedure);

rollback;