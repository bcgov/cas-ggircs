-- Verify ggircs:swrs/extract/table/xml_schema_check on pg

begin;

select pg_catalog.has_table_privilege('swrs_extract.xml_schema_check', 'select');

rollback;
