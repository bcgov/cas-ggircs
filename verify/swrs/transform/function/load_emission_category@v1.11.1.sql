-- Verify ggircs:swrs/transform/function/load_emission_category on pg

begin;

select pg_get_functiondef('swrs_transform.load_emission_category()'::regprocedure);

rollback;
