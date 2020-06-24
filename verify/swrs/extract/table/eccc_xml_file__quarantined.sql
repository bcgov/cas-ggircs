-- Verify ggircs:swrs/extract/table/eccc_xml_file__quarantined on pg

begin;

select true
from information_schema.columns
where table_schema='swrs_extract' and table_name='eccc_xml_file' and column_name='quarantined';

rollback;
