set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;

select plan(15);


select has_materialized_view(
    'swrs_transform', 'other_venting',
    'swrs_transform.other_venting should be a materialized view'
);

select columns_are('swrs_transform'::name, 'other_venting'::name, array[
    'id'::name,
    'eccc_xml_file_id'::name,
    'detail_tag'::name,
    'detail_value'::name
]);


select col_type_is('swrs_transform', 'other_venting', 'eccc_xml_file_id', 'integer', 'other_venting.eccc_xml_file_id column should be type integer');
select col_hasnt_default('swrs_transform', 'other_venting', 'eccc_xml_file_id', 'other_venting.eccc_xml_file_id column should not have a default value');

select col_type_is('swrs_transform', 'other_venting', 'detail_tag', 'character varying(1000)', 'other_venting.detail_tag column should be type varchar');
select col_is_null('swrs_transform', 'other_venting', 'detail_tag', 'other_venting.detail_tag column should not allow null');
select col_hasnt_default('swrs_transform', 'other_venting', 'detail_tag', 'other_venting.detail_tag column should not have a default');

select col_type_is('swrs_transform', 'other_venting', 'detail_value', 'character varying(1000)', 'other_venting.detail_value column should be type varchar');
select col_is_null('swrs_transform', 'other_venting', 'detail_value', 'other_venting.detail_value column should not allow null');
select col_hasnt_default('swrs_transform', 'other_venting', 'detail_value', 'other_venting.detail_value column should not have a default');



insert into swrs_extract.eccc_xml_file (id, xml_file) overriding system value values (
  111111, $$
  <ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <ReportDetails>
      <ReportID>111111111</ReportID>
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
$$),(
  222222, $$
  <ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <ReportDetails>
      <ReportID>222222222</ReportID>
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
        <VentingDetailsOther>Different detail same tag</VentingDetailsOther>
        <VentingDetailsOtherDifferentTag>Found details</VentingDetailsOtherDifferentTag>
        <CheckDeeper>
          <OtherScrambledVentingDetails>Found deeper</OtherScrambledVentingDetails>
        </CheckDeeper>
        <ShouldMissVentingDetails>Missing Other in tag name</ShouldMissVentingDetails>
      </SubProcess>
    </Facility>
    <ShouldMissOtherVentingDetails>Missing subprocess venting</ShouldMissOtherVentingDetails>
  </ReportData>
$$);

refresh materialized view swrs_transform.other_venting with data;

select results_eq(
  'select distinct eccc_xml_file_id from swrs_transform.other_venting order by eccc_xml_file_id asc',
  'select distinct id from swrs_extract.eccc_xml_file order by id asc',
  'swrs_transform.other_venting.eccc_xml_file_id relates to swrs_extract.eccc_xml_file.id'
);

--
select results_eq(
  'select count(*) from swrs_transform.other_venting',
  ARRAY[6::bigint],
  'There are exactly six (6) entries in swrs_transform.other_venting'
);

-- Test xml column parsing, and ensure that tags that do not meet all of the criteria are not parsed
select results_eq(
  'select detail_tag from swrs_transform.other_venting where eccc_xml_file_id=111111',
  ARRAY['VentingDetailsOther'::varchar, 'OtherScrambledVentingDetails'::varchar],
  'column detail_tag in swrs_transform.other_venting was properly parsed from xml'
);

select results_eq(
  'select detail_value from swrs_transform.other_venting where eccc_xml_file_id=111111',
  ARRAY['Found details'::varchar, 'Found deeper'::varchar],
  'column detail_value in swrs_transform.other_venting was properly parsed from xml'
);

-- Checks that both "VentingDetails" & "Other" are in the tag name,
-- and that the tag has a parent SubProcess with SubprocessName of "Venting"
select is_empty(
  $$
    select id from swrs_transform.other_venting where detail_value like 'ShouldMiss%'
  $$,
  'Does not parse data that does not meet the requirements of other_venting'
);

select * from finish();

rollback;
