-- Verify ggircs:swrs/transform/function/load_fuel_charge on pg

begin;

select pg_get_functiondef('swrs_transform.load_fuel_charge()'::regprocedure);

rollback;

