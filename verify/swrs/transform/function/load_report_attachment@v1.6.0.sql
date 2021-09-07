-- Verify ggircs:swrs/transform/function/load_report_attachment on pg

begin;

select pg_get_functiondef('swrs_transform.load_report_attachment()'::regprocedure);

rollback;
