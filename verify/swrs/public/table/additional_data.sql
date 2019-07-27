-- Verify ggircs:table_additional_data on pg

begin;

select pg_catalog.has_table_privilege('swrs.additional_data', 'select');

rollback;
