set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select * from no_plan();

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

refresh materialized view ggircs_swrs_transform.report with data;
refresh materialized view ggircs_swrs_transform.organisation with data;
refresh materialized view ggircs_swrs_transform.parent_organisation with data;
refresh materialized view ggircs_swrs_transform.final_report with data;
select ggircs_swrs_transform.load_report();
select ggircs_swrs_transform.load_organisation();
select ggircs_swrs_transform.load_parent_organisation();

-- Table ggircs.parent_organisation exists
select has_table('ggircs'::name, 'parent_organisation'::name);

-- Parent Organisation has pk
select has_pk('ggircs', 'parent_organisation', 'ggircs_parent_organisation has primary key');

-- Parent Organisation has fk
select has_fk('ggircs', 'parent_organisation', 'ggircs_parent_organisation has foreign key constraint(s)');

-- Parent Organisation has data
select isnt_empty('select * from ggircs.parent_organisation', 'there is data in ggircs.parent_organisation');

-- FKey tests
-- Parent Organisation -> Report
select set_eq(
    $$
    select distinct(report.ghgr_import_id) from ggircs.parent_organisation
    join ggircs.report
    on parent_organisation.report_id = report.id
    $$,

    'select distinct(ghgr_import_id) from ggircs.report',

    'Foreign key report_id in ggircs.parent_organisation references ggircs.report.id'
);

-- Parent Organisation -> Organisation
select set_eq(
    $$
    select distinct(organisation.ghgr_import_id) from ggircs.parent_organisation
    join ggircs.organisation
    on parent_organisation.organisation_id = organisation.id
    $$,

    'select ghgr_import_id from ggircs.organisation',

    'Foreign key organisation_id in ggircs.parent_organisation references ggircs.organisation.id'
);

-- Data in ggircs_swrs_transform.parent_organisation === data in ggircs.parent_organisation
select set_eq(
              $$
              select
                  ghgr_import_id,
                  path_context,
                  percentage_owned,
                  french_trade_name,
                  english_trade_name,
                  duns,
                  business_legal_name,
                  website
                from ggircs_swrs_transform.parent_organisation
                order by
                  ghgr_import_id,
                  path_context
                 asc
              $$,

              $$
              select
                  ghgr_import_id,
                  path_context,
                  percentage_owned,
                  french_trade_name,
                  english_trade_name,
                  duns,
                  business_legal_name,
                  website
                from ggircs.parent_organisation
                order by
                  ghgr_import_id,
                  path_context
                 asc
              $$,

              'data in ggircs_swrs_transform.parent_organisation === ggircs.parent_organisation');

select * from finish();
rollback;
