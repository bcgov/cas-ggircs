-- Verify ggircs:swrs/transform/function/load_report_history on pg

begin;

select pg_get_functiondef('swrs_transform.load_report_history()'::regprocedure);

rollback;
