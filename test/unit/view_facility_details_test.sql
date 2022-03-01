set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(4);

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

insert into swrs.report(id, swrs_report_id) values (1,1), (2,2);

insert into swrs.organisation(id, report_id) values (1,1), (2,2);

insert into swrs.facility(id, report_id, organisation_id) values (1,1,1), (2,2,2);

insert into swrs.naics(id, report_id, facility_id, registration_data_facility_id, naics_code, naics_priority, naics_classification)
  values (1,1,1,1,00000,'Primary', 'Primary'), (2,1,1,1,12345,'Not Primary','Not Primary');

select results_eq(
  $$
    select naics_code, naics_classification from swrs.facility_details where id=1
  $$,
  $$
    values(00000::integer, 'Primary'::varchar)
  $$,
  'facility_details retrieves the Primary naics_code for a facility'
);

select is(
  (select count(*) from swrs.facility_details where naics_code = 12345),
  0::bigint,
  'facility_details does not retrieve Non-Primary naics_codes for a facility'
);

select * from finish();
rollback;
