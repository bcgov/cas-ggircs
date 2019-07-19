-- Verify ggircs:table_additional_data on pg

begin;

select pg_catalog.has_table_privilege('ggircs_swrs_load.additional_data', 'select');

rollback;
