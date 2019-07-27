-- Verify ggircs:swrs/transform/function/load_naics_category_type on pg

begin;

select pg_get_functiondef('swrs_transform.load_naics_category_type()'::regprocedure);

rollback;
