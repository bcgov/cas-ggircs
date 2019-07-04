set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select * from no_plan();

insert into ggircs_swrs.ghgr_import (xml_file) values ($$
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

        </Identifiers>
      </Details>
    </Facility>
  </VerifyTombstone>
</ReportData>
$$);

refresh materialized view ggircs_swrs.report with data;
refresh materialized view ggircs_swrs.organisation with data;
refresh materialized view ggircs_swrs.facility with data;
refresh materialized view ggircs_swrs.permit with data;
refresh materialized view ggircs_swrs.final_report with data;
select ggircs_swrs.export_report_to_ggircs();
select ggircs_swrs.export_organisation_to_ggircs();
select ggircs_swrs.export_facility_to_ggircs();
select ggircs_swrs.export_permit_to_ggircs();

-- Table ggircs.permit exists
select has_table('ggircs'::name, 'permit'::name);

-- Permit has pk
select has_pk('ggircs', 'permit', 'ggircs_permit has primary key');

-- Permit has fk
select has_fk('ggircs', 'permit', 'ggircs_permit has foreign key constraint(s)');

-- Permit has data
select isnt_empty('select * from ggircs.permit', 'there is data in ggircs.permit');

-- FKey tests
-- Permit -> Facility
select set_eq(
    $$
    select facility.ghgr_import_id from ggircs.permit
    join ggircs.facility
    on
      permit.facility_id = facility.id
      order by ghgr_import_id
    $$,

    'select ghgr_import_id from ggircs.facility order by ghgr_import_id',

    'Foreign key facility_id in ggircs.permit references ggircs.facility.id'
);

-- Data in ggircs_swrs.permit === data in ggircs.permit
select set_eq(
              $$
              select
                  ghgr_import_id,
                  path_context,
                  issuing_agency,
                  issuing_dept_agency_program,
                  permit_number
                from ggircs_swrs.permit
                order by
                  ghgr_import_id,
                  path_context
                 asc
              $$,

              $$
              select
                  ghgr_import_id,
                  path_context,
                  issuing_agency,
                  issuing_dept_agency_program,
                  permit_number
                from ggircs.permit
                order by
                  ghgr_import_id,
                  path_context
                 asc
              $$,

              'data in ggircs_swrs.permit === ggircs.permit');

select * from finish();
rollback;
