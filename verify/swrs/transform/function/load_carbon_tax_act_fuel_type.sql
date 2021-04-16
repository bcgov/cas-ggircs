-- Verify ggircs:swrs/transform/function/load_carbon_tax_act_fuel_type on pg

begin;

select pg_get_functiondef('swrs_transform.load_carbon_tax_rate_mapping()'::regprocedure);

rollback;
