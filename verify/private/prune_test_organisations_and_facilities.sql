-- Verify ggircs:private/prune_test_organisations_and_facilities on pg

begin;

select pg_get_functiondef('swrs_private.prune_test_organisations_and_facilities()'::regprocedure);

rollback;
