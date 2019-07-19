set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select * from no_plan();

-- View should exist
select has_view(
    'ggircs', 'naics_category_mapping',
    'ggircs_swrs_load.naics_mapping_category should be a view'
);

-- Columns are correct
select columns_are('ggircs'::name, 'naics_category_mapping'::name, array[
    'naics_code'::name,
    'naics_category'::name,
    'naics_category_type'::name,
    'naics_category_id'::name,
    'naics_category_type_id'::name,
    'report_id'::name,
    'facility_id'::name
]);

-- XML fixture for testing
insert into ggircs_swrs_extract.ghgr_import (xml_file) values ($$
<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <RegistrationData>
  <Facility>
  </Facility>
    <NAICSCodeList>
      <NAICSCode>
        <NAICSClassification>Chemical Pulp Mills </NAICSClassification>
        <Code>111000</Code>
        <NaicsPriority>Primary</NaicsPriority>
      </NAICSCode>
    </NAICSCodeList>
  </RegistrationData>
  <ReportDetails>
    <ReportID>123500000</ReportID>
    <ReportType>R1</ReportType>
    <FacilityId>0001</FacilityId>
    <FacilityType>ABC</FacilityType>
    <OrganisationId>0000</OrganisationId>
    <ReportingPeriodDuration>2015</ReportingPeriodDuration>
    <ReportStatus>
      <Status>Submitted</Status>
      <SubmissionDate>2013-03-28T19:25:55.32</SubmissionDate>
      <LastModifiedBy>Buddy</LastModifiedBy>
    </ReportStatus>
  </ReportDetails>
</ReportData>
$$), ($$
<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <RegistrationData>
  <Facility>
  </Facility>
    <NAICSCodeList>
      <NAICSCode>
        <NAICSClassification>Chemical Pulp Mills </NAICSClassification>
        <Code>111419</Code>
        <NaicsPriority>Primary</NaicsPriority>
      </NAICSCode>
    </NAICSCodeList>
  </RegistrationData>
  <ReportDetails>
    <ReportID>123500000</ReportID>
    <ReportType>R1</ReportType>
    <FacilityId>0002</FacilityId>
    <FacilityType>ABC</FacilityType>
    <OrganisationId>0000</OrganisationId>
    <ReportingPeriodDuration>2015</ReportingPeriodDuration>
    <ReportStatus>
      <Status>Submitted</Status>
      <SubmissionDate>2013-03-28T19:25:55.32</SubmissionDate>
      <LastModifiedBy>Buddy</LastModifiedBy>
    </ReportStatus>
  </ReportDetails>
</ReportData>
$$);

-- Refresh necessary materialized views
refresh materialized view ggircs_swrs_transform.report with data;
refresh materialized view ggircs_swrs_transform.final_report with data;
refresh materialized view ggircs_swrs_transform.organisation with data;
refresh materialized view ggircs_swrs_transform.facility with data;
refresh materialized view ggircs_swrs_transform.naics with data;

-- Populate necessary ggircs tables
-- REPORT
    delete from ggircs_swrs_load.report;
    insert into ggircs_swrs_load.report (id, ghgr_import_id, source_xml, imported_at, swrs_report_id, prepop_report_id, report_type, swrs_facility_id, swrs_organisation_id,
                               reporting_period_duration, status, version, submission_date, last_modified_by, last_modified_date, update_comment)

    select _report.id, _report.ghgr_import_id, source_xml, imported_at, _report.swrs_report_id, prepop_report_id, report_type, swrs_facility_id, swrs_organisation_id,
           reporting_period_duration, status, version, submission_date, last_modified_by, last_modified_date, update_comment

    from ggircs_swrs_transform.report as _report
    inner join ggircs_swrs_transform.final_report as _final_report on _report.ghgr_import_id = _final_report.ghgr_import_id;

    -- ORGANISATION
    delete from ggircs_swrs_load.organisation;
    insert into ggircs_swrs_load.organisation (id, ghgr_import_id, report_id, swrs_organisation_id, business_legal_name, english_trade_name, french_trade_name, cra_business_number, duns, website)

    select _organisation.id, _organisation.ghgr_import_id, _report.id, _organisation.swrs_organisation_id, _organisation.business_legal_name,
           _organisation.english_trade_name, _organisation.french_trade_name, _organisation.cra_business_number, _organisation.duns, _organisation.website

    from ggircs_swrs_transform.organisation as _organisation

    inner join ggircs_swrs_transform.final_report as _final_report on _organisation.ghgr_import_id = _final_report.ghgr_import_id
    --FK Organisation -> Report
    left join ggircs_swrs_transform.report as _report
      on _organisation.ghgr_import_id = _report.ghgr_import_id
    ;

    select ggircs_swrs_transform.load_facility();

    -- NAICS
    delete from ggircs_swrs_load.naics;
    insert into ggircs_swrs_load.naics(id, ghgr_import_id, facility_id,  registration_data_facility_id, report_id, swrs_facility_id, path_context, naics_classification, naics_code, naics_priority)

    select _naics.id, _naics.ghgr_import_id, _facility.id,
        (select _facility.id where _naics.path_context = 'RegistrationData'),
        _report.id, _naics.swrs_facility_id,
        _naics.path_context, _naics.naics_classification, _naics.naics_code, _naics.naics_priority

    from ggircs_swrs_transform.naics as _naics
    inner join ggircs_swrs_transform.final_report as _final_report on _naics.ghgr_import_id = _final_report.ghgr_import_id
    -- FK Naics ->  Facility
    left join ggircs_swrs_transform.facility as _facility
      on _naics.ghgr_import_id = _facility.ghgr_import_id
    -- FK Naics -> Report
    left join ggircs_swrs_transform.report as _report
      on _naics.ghgr_import_id = _report.ghgr_import_id;

-- Test naics code -> category/type mapping
select set_eq(
    'select naics_category, naics_category_type from ggircs_swrs_load.naics_category_mapping',
    $$
    select naics_category, naics_category_type from ggircs_swrs_load.naics
    join ggircs_swrs_load.naics_naics_category as nnc
        on naics.naics_code::text like nnc.naics_code_pattern
    join ggircs_swrs_load.naics_category as nc
        on nnc.category_id = nc.id
    join ggircs_swrs_load.naics_category_type as ct
        on nnc.category_type_id = ct.id
    $$,
    'ggircs_swrs_load.naics_category_mapping properly selects categories and types from both fully and partially defined naics codes in the naics_naics_category through table'
);

select * from finish();
rollback;
