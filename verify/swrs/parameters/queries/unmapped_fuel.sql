-- Verify ggircs:swrs/parameters/queries/unmapped_fuel on pg

begin;

select pg_get_functiondef('ggircs_parameters.unmapped_fuel()'::regprocedure);

rollback;
