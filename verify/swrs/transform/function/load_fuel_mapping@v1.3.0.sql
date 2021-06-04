-- Verify ggircs:swrs/transform/function/load_fuel_mapping on pg

begin;

select pg_get_functiondef('swrs_transform.load_fuel_mapping()'::regprocedure);

rollback;
