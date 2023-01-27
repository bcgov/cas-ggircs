-- Verify ggircs:swrs/transform/function/load_other_venting on pg

begin;

select pg_get_functiondef('swrs_transform.load_other_venting()'::regprocedure);

rollback;
