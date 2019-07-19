-- Deploy ggircs:materialized_view_report to pg
-- requires: schema_ggircs_swrs
-- requires: table_ghgr_import

begin;

create materialized view ggircs_swrs_transform.report as (
  select
    row_number() over () as id,
    id as ghgr_import_id,
    xml_file as source_xml,
    imported_at,
    report_details.swrs_report_id,
    report_details.prepop_report_id,
    report_details.report_type,
    report_details.swrs_facility_id,
    report_details.swrs_organisation_id,
    (regexp_matches(report_details.reporting_period_duration, '\d\d\d\d'))[1]::varchar(1000) as reporting_period_duration,
    report_status.*
  from ggircs_swrs_extract.ghgr_import,
       xmltable(
           '/ReportData/ReportDetails'
           passing xml_file
           columns
             swrs_report_id integer path 'ReportID[normalize-space(.)]' not null,
             prepop_report_id integer path 'PrepopReportID[normalize-space(.)]',
             report_type varchar(1000) path 'ReportType[normalize-space(.)]' not null,
             swrs_facility_id integer path 'FacilityId[normalize-space(.)]' not null,
             swrs_organisation_id integer path 'OrganisationId[normalize-space(.)]' not null,
             reporting_period_duration varchar(1000) path 'ReportingPeriodDuration[normalize-space(.)]' not null
         ) as report_details,

       xmltable(
           '/ReportData/ReportDetails/ReportStatus'
           passing xml_file
           columns
             status varchar(1000) path 'Status|ReportStatus[normalize-space(.)]' not null, -- Unknown, In Progress, Submitted, Archived, Completed
             version varchar(1000) path 'Version[normalize-space(.)]',
             submission_date timestamptz path 'SubmissionDate[normalize-space(.)]',
             last_modified_by varchar(1000) path 'LastModifiedBy[normalize-space(.)]' not null,
             last_modified_date timestamp with time zone path 'LastModifiedDate[normalize-space(.)]',
             update_comment varchar(1000) path 'UpdateComment[normalize-space(.)]'
         ) as report_status
) with no data;


create unique index ggircs_report_primary_key on ggircs_swrs_transform.report (ghgr_import_id);

comment on materialized view ggircs_swrs_transform.report is 'The materialized view housing all report data, derived from ghgr_import table';
comment on column ggircs_swrs_transform.report.id is 'A generated index used for keying in the ggircs schema';
comment on column ggircs_swrs_transform.report.ghgr_import_id is 'The internal primary key for the file';
comment on column ggircs_swrs_transform.report.source_xml is 'The raw xml file imported from GHGR';
comment on column ggircs_swrs_transform.report.imported_at is 'The timestamp noting when the file was imported';
comment on column ggircs_swrs_transform.report.swrs_report_id is 'The swrs report id';
comment on column ggircs_swrs_transform.report.prepop_report_id is 'The prepop report id';
comment on column ggircs_swrs_transform.report.report_type is 'The type of report';
comment on column ggircs_swrs_transform.report.swrs_facility_id is 'The ID for the reporting facility';
comment on column ggircs_swrs_transform.report.swrs_organisation_id is 'The ID for the reporting organisation';
comment on column ggircs_swrs_transform.report.reporting_period_duration is 'The length of the reporting period contained in report';
comment on column ggircs_swrs_transform.report.status is 'The status of the report';
comment on column ggircs_swrs_transform.report.version is 'The report version';
comment on column ggircs_swrs_transform.report.submission_date is 'The date the report was submitted';
comment on column ggircs_swrs_transform.report.last_modified_by is 'The person who last modified the report';
comment on column ggircs_swrs_transform.report.last_modified_date is 'The timestamp recorded in SWRS when the report was last modified';
comment on column ggircs_swrs_transform.report.update_comment is 'The description of the update';

commit;
