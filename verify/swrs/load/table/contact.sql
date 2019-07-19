-- Verify ggircs:table_contact on pg

begin;

select pg_catalog.has_table_privilege('ggircs_swrs_load.contact', 'select');

rollback;
