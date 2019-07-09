-- Verify ggircs:ciip_table_equipment on pg

begin;

select pg_catalog.has_table_privilege('ciip.equipment', 'select');

rollback;