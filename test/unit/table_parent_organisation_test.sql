set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select * from no_plan();

insert into swrs_extract.eccc_xml_file (xml_file) values ($$
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
    <Contacts/>
    <ParentOrganisations>
      <ParentOrganisation>
        <Details>
          <BusinessLegalName>ABC</BusinessLegalName>
          <CRABusinessNumber>123456789</CRABusinessNumber>
          <PercentageOwned>0</PercentageOwned>
        </Details>
        <Address>
          <PhysicalAddress>
            <UnitNumber/>
            <StreetNumber>0</StreetNumber>
            <StreetNumberSuffix/>
            <StreetName/>
            <Municipality/>
            <PostalCodeZipCode/>
            <AdditionalInformation/>
            <LandSurveyDescription/>
            <NationalTopographicalDescription/>
          </PhysicalAddress>
          <MailingAddress>
            <UnitNumber>1</UnitNumber>
            <StreetNumber>2700</StreetNumber>
            <StreetNumberSuffix/>
            <StreetName>00th</StreetName>
            <StreetType>Avenue</StreetType>
            <Municipality>Vancouver</Municipality>
            <ProvTerrState>British Columbia</ProvTerrState>
            <PostalCodeZipCode>H0H0H0</PostalCodeZipCode>
            <Country>Canada</Country>
            <AdditionalInformation/>
          </MailingAddress>
        </Address>
      </ParentOrganisation>
    </ParentOrganisations>
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
    <ParentOrganisations>
      <ParentOrganisation>
        <Details>
          <BusinessLegalName>ABC</BusinessLegalName>
          <CRABusinessNumber>123456789</CRABusinessNumber>
          <PercentageOwned>0</PercentageOwned>
        </Details>
        <Address>
          <PhysicalAddress>
            <UnitNumber/>
            <StreetNumber>0</StreetNumber>
            <StreetNumberSuffix/>
            <StreetName/>
            <Municipality/>
            <PostalCodeZipCode/>
            <AdditionalInformation/>
            <LandSurveyDescription/>
            <NationalTopographicalDescription/>
          </PhysicalAddress>
          <MailingAddress>
            <UnitNumber>1</UnitNumber>
            <StreetNumber>2700</StreetNumber>
            <StreetNumberSuffix/>
            <StreetName>00th</StreetName>
            <StreetType>Avenue</StreetType>
            <Municipality>Vancouver</Municipality>
            <ProvTerrState>British Columbia</ProvTerrState>
            <PostalCodeZipCode>H0H0H0</PostalCodeZipCode>
            <Country>Canada</Country>
            <AdditionalInformation/>
          </MailingAddress>
        </Address>
      </ParentOrganisation>
    </ParentOrganisations>
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
    <ParentOrganisations/>
  </VerifyTombstone>
</ReportData>
$$);

-- Run table export function without clearing the materialized views (for data equality tests below)
SET client_min_messages TO WARNING; -- load is a bit verbose
select swrs_transform.load(true, false);

-- Table swrs.parent_organisation exists
select has_table('swrs'::name, 'parent_organisation'::name);

-- Parent Organisation has pk
select has_pk('swrs', 'parent_organisation', 'ggircs_parent_organisation has primary key');

-- Parent Organisation has fk
select has_fk('swrs', 'parent_organisation', 'ggircs_parent_organisation has foreign key constraint(s)');

-- Parent Organisation has data
select isnt_empty('select * from swrs.parent_organisation', 'there is data in swrs.parent_organisation');

-- FKey tests
-- Parent Organisation -> Report
select set_eq(
    $$
    select distinct(report.eccc_xml_file_id) from swrs.parent_organisation
    join swrs.report
    on parent_organisation.report_id = report.id
    $$,

    'select distinct(eccc_xml_file_id) from swrs.report',

    'Foreign key report_id in swrs.parent_organisation references swrs.report.id'
);

-- Parent Organisation -> Organisation
select set_eq(
    $$
    select distinct(organisation.eccc_xml_file_id) from swrs.parent_organisation
    join swrs.organisation
    on parent_organisation.organisation_id = organisation.id
    $$,

    'select eccc_xml_file_id from swrs.organisation',

    'Foreign key organisation_id in swrs.parent_organisation references swrs.organisation.id'
);

-- Data in swrs_transform.parent_organisation === data in swrs.parent_organisation
select set_eq(
              $$
              select
                  eccc_xml_file_id,
                  path_context,
                  percentage_owned,
                  french_trade_name,
                  english_trade_name,
                  duns,
                  business_legal_name,
                  website
                from swrs_transform.parent_organisation
                order by
                  eccc_xml_file_id,
                  path_context
                 asc
              $$,

              $$
              select
                  eccc_xml_file_id,
                  path_context,
                  percentage_owned,
                  french_trade_name,
                  english_trade_name,
                  duns,
                  business_legal_name,
                  website
                from swrs.parent_organisation
                order by
                  eccc_xml_file_id,
                  path_context
                 asc
              $$,

              'data in swrs_transform.parent_organisation === swrs.parent_organisation');

select * from finish();
rollback;
