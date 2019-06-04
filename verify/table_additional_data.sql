-- Verify ggircs:table_additional_data on pg

begin;

select pg_catalog.has_table_privilege('ggircs.additional_data', 'select');

rollback;
