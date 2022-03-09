-- Verify ggircs:swrs/parameters/mutations/create_fuel_mapping_cascade on pg

begin;

select pg_get_functiondef('ggircs_parameters.create_fuel_mapping_cascade(text, integer)'::regprocedure);

rollback;
