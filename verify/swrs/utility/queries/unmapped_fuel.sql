-- Verify ggircs:swrs/utility/queries/unmapped_fuel on pg

begin;

select pg_get_functiondef('swrs_utility.unmapped_fuel()'::regprocedure);

rollback;
