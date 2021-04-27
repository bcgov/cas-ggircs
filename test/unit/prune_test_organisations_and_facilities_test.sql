set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(5);

select has_function('swrs_private', 'prune_test_organisations_and_facilities', 'Function prune_test_organisations_and_facilities should exist');

delete from swrs_extract.eccc_zip_file;
delete from swrs_extract.eccc_xml_file;

insert into swrs_extract.eccc_zip_file(zip_file_name) values
('GHGBC_PROD_00000000.zip'),
('GHGBC_QC_00000000.zip'),
('GHGBC_PROE_00000001.zip'),
('BHGBC_PROD_00000002.zip'),
('o9sa8f45789574ytfj2au727'),
('GHGBC_PROD_99999999.zip');

insert into swrs_extract.eccc_xml_file(xml_file, xml_file_name, zip_file_id) values
('', 'test_xml_1', (select id from swrs_extract.eccc_zip_file where zip_file_name = 'GHGBC_PROD_00000000.zip')),
('', 'test_xml_2', (select id from swrs_extract.eccc_zip_file where zip_file_name = 'GHGBC_PROD_00000000.zip')),
('', 'test_xml_3', (select id from swrs_extract.eccc_zip_file where zip_file_name = 'GHGBC_QC_00000000.zip')),
('', 'test_xml_4', (select id from swrs_extract.eccc_zip_file where zip_file_name = 'GHGBC_QC_00000000.zip')),
('', 'test_xml_5', (select id from swrs_extract.eccc_zip_file where zip_file_name = 'GHGBC_QC_00000000.zip')),
('', 'test_xml_6', (select id from swrs_extract.eccc_zip_file where zip_file_name = 'BHGBC_PROD_00000002.zip')),
('', '2u94hsafdv89', (select id from swrs_extract.eccc_zip_file where zip_file_name = 'o9sa8f45789574ytfj2au727'));

select results_eq(
  $$
    select count(*) from swrs_extract.eccc_zip_file
  $$,
  $$
    values(6::bigint)
  $$,
  'There should be 6 test zip files'
);
select results_eq(
  $$
    select count(*) from swrs_extract.eccc_xml_file
  $$,
  $$
    values(7::bigint)
  $$,
  'There should be 7 test xml files'
);

select swrs_private.prune_test_organisations_and_facilities();

select results_eq(
  $$
    select zip_file_name from swrs_extract.eccc_zip_file
  $$,
  $$
    values ('GHGBC_PROD_00000000.zip'::varchar), ('GHGBC_PROD_99999999.zip'::varchar)
  $$,
  'prune_test_organisations_and_facilities doesnt remove prod zip files'
);

select results_eq(
  $$
    select xml_file_name from swrs_extract.eccc_xml_file
  $$,
  $$
    values ('test_xml_1'::varchar), ('test_xml_2'::varchar)
  $$,
  'prune_test_organisations_and_facilities only removes the xml in the non-prod zip files'
);

select finish();
rollback;
