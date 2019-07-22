-- Verify ggircs:ciip_table_equipment_emission on pg

begin;

select pg_catalog.has_table_privilege('ciip.equipment_emission', 'select');

rollback;