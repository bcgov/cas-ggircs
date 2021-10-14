-- Verify ggircs:swrs/history/table/attachments_002 on pg

begin;

select pg_catalog.has_table_privilege('swrs_history.report_attachment', 'select');

rollback;
