-- Verify ggircs:ciip_table_contact on pg

begin;

select pg_catalog.has_table_privilege('ciip.contact', 'select');

rollback;

