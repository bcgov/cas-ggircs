-- Verify ggircs:swrs/utility/mutations/create_fuel_mapping_cascade on pg

begin;

select pg_get_functiondef('swrs_utility.create_fuel_mapping_cascade(text, int)'::regprocedure);

rollback;
