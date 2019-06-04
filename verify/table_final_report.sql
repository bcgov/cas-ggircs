-- Verify ggircs:table_final_report on pg

begin;

select pg_catalog.has_table_privilege('ggircs.final_report', 'select');

rollback;
