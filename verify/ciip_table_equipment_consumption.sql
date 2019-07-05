-- Verify ggircs:ciip_table_equipment_consumption on pg

begin;

select pg_catalog.has_table_privilege('ciip.equipment_consumption', 'select');

rollback;