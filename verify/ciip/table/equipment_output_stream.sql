-- Verify ggircs:ciip_table_equipment_output_stream on pg

begin;

select pg_catalog.has_table_privilege('ciip_2018.equipment_output_stream', 'select');

rollback;
