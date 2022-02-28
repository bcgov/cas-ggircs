set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(2);

select has_view(
    'swrs', 'facility_details',
    'swrs.facility_details should be a view'
);

select columns_are('swrs', 'facility_details', array[
  'id', 'report_id', 'organisation_id', 'parent_facility_id',
  'eccc_xml_file_id', 'swrs_facility_id', 'facility_name',
  'facility_type', 'relationship_type', 'portability_indicator',
  'status', 'latitude', 'longitude', 'facility_bc_ghg_id', 'naics_id',
  'naics_classification', 'naics_code'
]);

select * from finish();
rollback;
