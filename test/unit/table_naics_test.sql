set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select * from no_plan();

insert into swrs_extract.ghgr_import (xml_file) values ($$
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
    </Organisation>
    <Facility>
      <Details>
        <FacilityName>fname</FacilityName>
        <RelationshipType>Owned and Operated</RelationshipType>
        <PortabilityIndicator>N</PortabilityIndicator>
        <Status>Active</Status>
      </Details>
      <Identifiers>
        <NAICSCodeList>
          <NAICSCode>
            <NAICSClassification>Chemical Pulp Mills </NAICSClassification>
            <Code>721310</Code>
            <NaicsPriority>Primary</NaicsPriority>
          </NAICSCode>
        </NAICSCodeList>
      </Identifiers>
    </Facility>
    <Contacts/>
  </RegistrationData>
  <ReportDetails>
    <ReportID>1234</ReportID>
    <ReportType>R1</ReportType>
    <FacilityId>0000</FacilityId>
    <FacilityType>EIO</FacilityType>
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
  </VerifyTombstone>
</ReportData>
$$), ($$
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
    </Organisation>
    <Facility>
      <Details>
        <FacilityName>fname</FacilityName>
        <RelationshipType>Owned and Operated</RelationshipType>
        <PortabilityIndicator>N</PortabilityIndicator>
        <Status>Active</Status>
      </Details>
      <Identifiers>
        <IdentifierList>
          <Identifier>
            <IdentifierType>BCGHGID</IdentifierType>
            <IdentifierValue>RD_123456</IdentifierValue>
          </Identifier>
          <Identifier>
            <IdentifierType>GHGRP Identification Number</IdentifierType>
            <IdentifierValue>654321</IdentifierValue>
          </Identifier>
          <Identifier>
            <IdentifierType>National Emission Reduction Masterplan</IdentifierType>
            <IdentifierValue>1234</IdentifierValue>
          </Identifier>
          <Identifier>
            <IdentifierType>National Pollutant Release Inventory Identifier</IdentifierType>
            <IdentifierValue>0000</IdentifierValue>
          </Identifier>
        </IdentifierList>
      </Identifiers>
    </Facility>
  </RegistrationData>
  <ReportDetails>
    <ReportID>1235</ReportID>
    <ReportType>R1</ReportType>
    <FacilityId>0001</FacilityId>
    <FacilityType>LF_a</FacilityType>
    <OrganisationId>0000</OrganisationId>
    <ReportingPeriodDuration>2020</ReportingPeriodDuration>
    <ReportStatus>
      <Status>Submitted</Status>
      <SubmissionDate>2013-03-28T19:25:55.32</SubmissionDate>
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
              <IdentifierValue></IdentifierValue>
            </Identifier>
          </IdentifierList>
          <NAICSCodeList>
            <NAICSCode>
              <Code>321111</Code>
            </NAICSCode>
          </NAICSCodeList>
        </Identifiers>
      </Details>
    </Facility>
    <ParentOrganisations/>
  </VerifyTombstone>
</ReportData>
$$), ($$
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
    </Organisation>
    <Facility>
      <Details>
        <FacilityName>fname</FacilityName>
        <RelationshipType>Owned and Operated</RelationshipType>
        <PortabilityIndicator>N</PortabilityIndicator>
        <Status>Active</Status>
      </Details>
      <Identifiers>
        <NAICSCodeList>
          <NAICSCode>
            <NAICSClassification>Chemical Pulp Mills </NAICSClassification>
            <Code>321111</Code>
            <NaicsPriority>Primary</NaicsPriority>
          </NAICSCode>
        </NAICSCodeList>
        <Permits>
          <Permit>
            <IssuingAgency>British Columbia</IssuingAgency>
            <PermitNumber>0000</PermitNumber>
          </Permit>
        </Permits>
      </Identifiers>
    </Facility>
  </RegistrationData>
  <ReportDetails>
    <ReportID>1236</ReportID>
    <ReportType>R1</ReportType>
    <FacilityId>0002</FacilityId>
    <FacilityType>LFO</FacilityType>
    <OrganisationId>0000</OrganisationId>
    <ReportingPeriodDuration>2020</ReportingPeriodDuration>
    <ReportStatus>
      <Status>Submitted</Status>
      <SubmissionDate>2013-03-28T19:25:55.32</SubmissionDate>
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
    </Organisation>
    <Facility>
      <Details>
        <FacilityName>Bart Simpson</FacilityName>
        <Identifiers>
          <NAICSCodeList>
            <NAICSCode>
              <Code>321111</Code>
            </NAICSCode>
          </NAICSCodeList>
        </Identifiers>
      </Details>
    </Facility>
    <ParentOrganisations/>
  </VerifyTombstone>
</ReportData>
$$);

refresh materialized view swrs_transform.report with data;
refresh materialized view swrs_transform.organisation with data;
refresh materialized view swrs_transform.facility with data;
refresh materialized view swrs_transform.naics with data;
refresh materialized view swrs_transform.final_report with data;
select swrs_transform.load_report();
select swrs_transform.load_organisation();
select swrs_transform.load_facility();
select swrs_transform.load_naics();

-- Table swrs.naics exists
select has_table('ggircs'::name, 'naics'::name);

-- Naics has pk
select has_pk('ggircs', 'naics', 'ggircs_naics has primary key');

-- Naics has fk
select has_fk('ggircs', 'naics', 'ggircs_naics has foreign key constraint(s)');

-- Naics has data
select isnt_empty('select * from swrs.naics', 'there is data in swrs.naics');

-- FKey tests
-- NAICS -> Facility
select set_eq(
    $$
    select distinct(facility.ghgr_import_id) from swrs.naics
    join swrs.facility
    on
      naics.facility_id = facility.id
      order by ghgr_import_id
    $$,

    'select ghgr_import_id from swrs.facility order by ghgr_import_id',

    'Foreign key facility_id in swrs.naics references swrs.facility.id'
);

-- Naics -> Facility (path_context = RegistrationData)
select set_eq(
    $$
    select facility.ghgr_import_id from swrs.naics
    join swrs.facility
    on
      naics.registration_data_facility_id = facility.id
    $$,

    $$ select facility.ghgr_import_id
       from swrs.naics
       join swrs.facility
       on
         naics.facility_id = facility.id
         and path_context = 'RegistrationData' order by naics_code $$,

    'Foreign key registration_data_facility_id in swrs.naics references swrs.facility.id'
);

-- Naics -> Report
select set_eq(
    $$
    select report.ghgr_import_id from swrs.naics
    join swrs.report
    on naics.report_id = report.id
    $$,

    'select ghgr_import_id from swrs.report',

    'Foreign key report_id in swrs.naics references swrs.report.id'
);

-- Data in swrs_transform.naics === data in swrs.naics
select set_eq(
              $$
              select
                  ghgr_import_id,
                  swrs_facility_id,
                  path_context,
                  naics_classification,
                  naics_code,
                  naics_priority
                from swrs_transform.naics
              $$,

              $$
              select
                  ghgr_import_id,
                  swrs_facility_id,
                  path_context,
                  naics_classification,
                  naics_code,
                  naics_priority
                from swrs.naics
              $$,

              'data in swrs_transform.naics === swrs.naics');

select * from finish();
rollback;
