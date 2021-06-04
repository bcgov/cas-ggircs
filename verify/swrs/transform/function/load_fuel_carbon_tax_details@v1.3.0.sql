-- Verify ggircs:swrs/transform/function/load_fuel_carbon_tax_details on pg

begin;

select pg_get_functiondef('swrs_transform.load_fuel_carbon_tax_details()'::regprocedure);

rollback;
