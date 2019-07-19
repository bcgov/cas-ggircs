set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select * from no_plan();

-- View should exist
select has_view(
    'ggircs', 'report_with_org',
    'ggircs_swrs_load.report_with_org should be a view'
);

-- Columns are correct
select columns_are('ggircs'::name, 'report_with_org'::name, array[
       'business_legal_name'::name,
       'facility_name'::name,
       'facility_type'::name,
       'reporting_period_duration'::name,
       'naics_classification'::name,
       'naics_code'::name,
       'report_id'::name,
       'organisation_id'::name,
       'facility_id'::name,
       'swrs_report_id'::name,
       'swrs_organisation_id'::name,
       'swrs_facility_id'::name
]);

-- Column attributes are correct

select col_type_is('ggircs', 'report_with_org', 'business_legal_name', 'character varying(1000)', 'attributable_emissions.emission_id column should be type varchar');
select col_hasnt_default('ggircs', 'report_with_org', 'business_legal_name', 'report_with_org.business_legal_name column should not have a default value');

select col_type_is('ggircs', 'report_with_org', 'facility_name', 'character varying(1000)', 'attributable_emissions.emission_id column should be type varchar');
select col_hasnt_default('ggircs', 'report_with_org', 'facility_name', 'report_with_org.facility_name column should not have a default value');

select col_type_is('ggircs', 'report_with_org', 'facility_type', 'character varying(1000)', 'attributable_emissions.emission_id column should be type varchar');
select col_hasnt_default('ggircs', 'report_with_org', 'facility_type', 'report_with_org.facility_type column should not have a default value');

select col_type_is('ggircs', 'report_with_org', 'reporting_period_duration', 'character varying(1000)', 'attributable_emissions.emission_id column should be type varchar');
select col_hasnt_default('ggircs', 'report_with_org', 'reporting_period_duration', 'report_with_org.reporting_period_duration column should not have a default value');

select col_type_is('ggircs', 'report_with_org', 'naics_classification', 'character varying(1000)', 'attributable_emissions.emission_id column should be type varchar');
select col_hasnt_default('ggircs', 'report_with_org', 'naics_classification', 'report_with_org.naics_classification column should not have a default value');

select col_type_is('ggircs', 'report_with_org', 'naics_code', 'integer', 'attributable_emissions.emission_id column should be type integer');
select col_hasnt_default('ggircs', 'report_with_org', 'naics_code', 'report_with_org.naics_code column should not have a default value');

select col_type_is('ggircs', 'report_with_org', 'report_id', 'integer', 'attributable_emissions.emission_id column should be type integer');
select col_hasnt_default('ggircs', 'report_with_org', 'report_id', 'report_with_org.report_id column should not have a default value');

select col_type_is('ggircs', 'report_with_org', 'organisation_id', 'integer', 'attributable_emissions.emission_id column should be type integer');
select col_hasnt_default('ggircs', 'report_with_org', 'organisation_id', 'report_with_org.organisation_id column should not have a default value');

select col_type_is('ggircs', 'report_with_org', 'facility_id', 'integer', 'attributable_emissions.emission_id column should be type integer');
select col_hasnt_default('ggircs', 'report_with_org', 'facility_id', 'report_with_org.facility_id column should not have a default value');

select col_type_is('ggircs', 'report_with_org', 'swrs_report_id', 'integer', 'attributable_emissions.emission_id column should be type integer');
select col_hasnt_default('ggircs', 'report_with_org', 'swrs_report_id', 'report_with_org.swrs_report_id column should not have a default value');

select col_type_is('ggircs', 'report_with_org', 'swrs_organisation_id', 'integer', 'attributable_emissions.emission_id column should be type integer');
select col_hasnt_default('ggircs', 'report_with_org', 'swrs_organisation_id', 'report_with_org.swrs_organisation_id column should not have a default value');

select col_type_is('ggircs', 'report_with_org', 'swrs_facility_id', 'integer', 'attributable_emissions.emission_id column should be type integer');
select col_hasnt_default('ggircs', 'report_with_org', 'swrs_facility_id', 'report_with_org.swrs_facility_id column should not have a default value');

-- XML fixture for testing
insert into ggircs_swrs_extract.ghgr_import (xml_file) values ($$
<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <RegistrationData>
    <Organisation>
      <Details>
        <BusinessLegalName>Bart Simpson</BusinessLegalName>
        <EnglishTradeName>Bart Simpson</EnglishTradeName>
        <FrenchTradeName/>
        <CRABusinessNumber>12345</CRABusinessNumber>
        <DUNSNumber>0</DUNSNumber>
        <WebSite>www.nhl.com</WebSite>
      </Details>
      <Address>
        <PhysicalAddress>
          <StreetNumber>300</StreetNumber>
          <StreetNumberSuffix/>
          <StreetName>A Drive</StreetName>
          <StreetType>Drive</StreetType>
          <StreetDirection>North</StreetDirection>
          <Municipality>Funky Town</Municipality>
          <ProvTerrState>British Columbia</ProvTerrState>
          <PostalCodeZipCode>H0H0H0</PostalCodeZipCode>
          <Country>Canada</Country>
        </PhysicalAddress>
        <MailingAddress>
          <DeliveryMode>Post Office Box</DeliveryMode>
          <POBoxNumber>1</POBoxNumber>
          <StreetNumber>300</StreetNumber>
          <StreetNumberSuffix/>
          <StreetName>A Drive</StreetName>
          <StreetType>Drive</StreetType>
          <Municipality>Funky Town</Municipality>
          <ProvTerrState>British Columbia</ProvTerrState>
          <PostalCodeZipCode>H0H0H0</PostalCodeZipCode>
          <Country>Canada</Country>
          <AdditionalInformation/>
        </MailingAddress>
      </Address>
    </Organisation>
    <Facility>
      <Details>
        <FacilityName>Bart Simpson</FacilityName>
        <Identifiers>
          <IdentifierList>
            <Identifier>
              <IdentifierType>NPRI</IdentifierType>
              <IdentifierValue>12345</IdentifierValue>
            </Identifier>
            <Identifier>
              <IdentifierType>BCGHGID</IdentifierType>
              <IdentifierValue>VT_12345</IdentifierValue>
            </Identifier>
          </IdentifierList>
          <NAICSCodeList>
            <NAICSCode>
              <Code>721310</Code>
            </NAICSCode>
          </NAICSCodeList>
        </Identifiers>
      </Details>
    </Facility>
  </RegistrationData>
  <ReportDetails>
    <ReportID>1234</ReportID>
    <ReportType>R1</ReportType>
    <FacilityId>0000</FacilityId>
    <FacilityType>ABC</FacilityType>
    <OrganisationId>0000</OrganisationId>
    <ReportingPeriodDuration>2025</ReportingPeriodDuration>
    <ReportStatus>
      <Status>Submitted</Status>
      <SubmissionDate>2013-03-27T19:25:55.32</SubmissionDate>
      <LastModifiedBy>Buddy</LastModifiedBy>
    </ReportStatus>
  </ReportDetails>
  <OperationalWorkerReport/>
  <VerifyTombstone>
    <Organisation>
      <Details>
        <BusinessLegalName>Bart Simpson</BusinessLegalName>
        <EnglishTradeName>Bart Simpson</EnglishTradeName>
        <CRABusinessNumber>123456778</CRABusinessNumber>
        <DUNSNumber>00-000-0000</DUNSNumber>
      </Details>
      <Address>
        <MailingAddress>
          <POBoxNumber>0000</POBoxNumber>
          <StreetNumber>00</StreetNumber>
          <StreetName>A Drive</StreetName>
          <StreetType>Drive</StreetType>
          <Municipality>Funky Town</Municipality>
          <ProvTerrState>British Columbia</ProvTerrState>
          <PostalCodeZipCode>H0H0H0</PostalCodeZipCode>
          <Country>Canada</Country>
        </MailingAddress>
      </Address>
    </Organisation>
  </VerifyTombstone>
</ReportData>
$$);

-- Refresh necessary materialized views
refresh materialized view ggircs_swrs_transform.report with data;
refresh materialized view ggircs_swrs_transform.final_report with data;
refresh materialized view ggircs_swrs_transform.organisation with data;
refresh materialized view ggircs_swrs_transform.facility with data;
refresh materialized view ggircs_swrs_transform.naics with data;

-- Populate necessary ggircs tables
select ggircs_swrs_transform.load_report();
select ggircs_swrs_transform.load_organisation();
select ggircs_swrs_transform.load_facility();
select ggircs_swrs_transform.load_naics();

select results_eq(
  'select * from ggircs_swrs_load.report_with_org',
  $$
    select
       o.business_legal_name,
       fc.facility_name,
       fc.facility_type,
       r.reporting_period_duration,
       n.naics_classification,
       n.naics_code,
       n.report_id,
       fc.organisation_id,
       n.facility_id,
       r.swrs_report_id,
       r.swrs_organisation_id,
       r.swrs_facility_id
    from ggircs_swrs_load.naics as n
        join ggircs_swrs_load.facility as fc
        on n.facility_id = fc.id
        join ggircs_swrs_load.organisation as o
        on fc.organisation_id = o.id
        join ggircs_swrs_load.report as r
        on n.report_id = r.id
  $$,
  'ggircs_swrs_load.report_with_org has the correct information'

);

select * from finish();
rollback;
