set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(6);

insert into swrs_extract.eccc_xml_file (xml_file) values ($$
<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <ReportDetails>
    <ReportID>800855555</ReportID>
    <ReportType>R7</ReportType>
    <FacilityId>666</FacilityId>
    <OrganisationId>1337</OrganisationId>
    <ReportingPeriodDuration>1999</ReportingPeriodDuration>
    <ReportStatus>
      <Status>Archived</Status>
      <SubmissionDate>2018-11-14T12:35:27.226</SubmissionDate>
      <Version>3</Version>
      <LastModifiedBy>Donny Donaldson McDonaldface</LastModifiedBy>
      <LastModifiedDate>2018-11-14T12:35:27.226</LastModifiedDate>
    </ReportStatus>
  </ReportDetails>
  <Facility>
    <SubProcess SubprocessName="Venting">
      <VentingDetailsOther>Found details</VentingDetailsOther>
      <CheckDeeper>
        <OtherScrambledVentingDetails>Found deeper</OtherScrambledVentingDetails>
      </CheckDeeper>
    </SubProcess>
  </Facility>
  <OtherVentingDetails>Missing subprocess venting</OtherVentingDetails>
</ReportData>
$$);

-- Run table export function without clearing the materialized views (for data equality tests below)
SET client_min_messages TO WARNING; -- load is a bit verbose
select swrs_transform.load(true, false);

-- Table swrs.other_venting exists
select has_table('swrs'::name, 'other_venting'::name);

-- other_venting has pk
select has_pk('swrs', 'other_venting', 'other_venting has primary key');

-- other_venting has fk
select has_fk('swrs', 'other_venting', 'other_venting has foreign key constraint(s)');

-- other_venting has data
select isnt_empty('select * from swrs.other_venting', 'there is data in swrs.other_venting');

-- FKey tests
-- other_venting -> Report
select set_eq(
    $$
    select distinct(report.eccc_xml_file_id) from swrs.other_venting
    join swrs.report
    on other_venting.report_id = report.id
    $$,

    'select distinct(eccc_xml_file_id) from swrs.report',

    'Foreign key report_id in swrs.other_venting references swrs.report.id'
);

-- Data in swrs_transform.other_venting === data in swrs.other_venting
select set_eq(
    $$
    select
        id,
        eccc_xml_file_id,
        detail_tag,
        detail_value
      from swrs_transform.other_venting
      order by
          eccc_xml_file_id
        asc
    $$,

    $$
    select
        id,
        eccc_xml_file_id,
        detail_tag,
        detail_value
      from swrs.other_venting
      order by
          eccc_xml_file_id
        asc
    $$,

    'data in swrs_transform.other_venting === swrs.other_venting'
);


select * from finish();
rollback;
