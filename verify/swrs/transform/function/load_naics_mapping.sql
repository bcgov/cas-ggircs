-- Verify ggircs:swrs/transform/function/load_naics_mapping on pg

begin;

select pg_get_functiondef('swrs_transform.load_naics_mapping()'::regprocedure);

rollback;

