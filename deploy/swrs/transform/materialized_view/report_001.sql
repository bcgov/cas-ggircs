-- Deploy ggircs:swrs/transform/materialized_view/report_001 to pg
-- requires: swrs/transform/materialized_view/report

begin;

-- drop cascades to swrs_transform.final_report
drop materialized view swrs_transform.report cascade;

create materialized view swrs_transform.report as (
  select
    row_number() over () as id,
    id as eccc_xml_file_id,
    xml_file as source_xml,
    imported_at,
    report_details.swrs_report_id,
    report_details.prepop_report_id,
    report_details.report_type,
    report_details.swrs_facility_id,
    report_details.swrs_organisation_id,
    (regexp_matches(report_details.reporting_period_duration::varchar(1000), '\d\d\d\d'))[1]::integer as reporting_period_duration,
    report_status.*
  from swrs_extract.eccc_xml_file,
       xmltable(
           '/ReportData/ReportDetails'
           passing xml_file
           columns
             swrs_report_id integer path 'ReportID[normalize-space(.)]' not null,
             prepop_report_id integer path 'PrepopReportID[normalize-space(.)]',
             report_type varchar(1000) path 'ReportType[normalize-space(.)]' not null,
             swrs_facility_id integer path 'FacilityId[normalize-space(.)]' not null,
             swrs_organisation_id integer path 'OrganisationId[normalize-space(.)]' not null,
             reporting_period_duration integer path 'ReportingPeriodDuration[normalize-space(.)]' not null
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
             update_comment varchar(100000) path 'UpdateComment[normalize-space(.)]'
         ) as report_status
) with no data;

create unique index ggircs_report_primary_key on swrs_transform.report (eccc_xml_file_id);

comment on materialized view swrs_transform.report is 'The materialized view housing all report data, derived from eccc_xml_file table';
comment on column swrs_transform.report.id is 'A generated index used for keying in the ggircs schema';
comment on column swrs_transform.report.eccc_xml_file_id is 'The internal primary key for the file';
comment on column swrs_transform.report.source_xml is 'The raw xml file imported from GHGR';
comment on column swrs_transform.report.imported_at is 'The timestamp noting when the file was imported';
comment on column swrs_transform.report.swrs_report_id is 'The swrs report id';
comment on column swrs_transform.report.prepop_report_id is 'The prepop report id';
comment on column swrs_transform.report.report_type is 'The type of report';
comment on column swrs_transform.report.swrs_facility_id is 'The ID for the reporting facility';
comment on column swrs_transform.report.swrs_organisation_id is 'The ID for the reporting organisation';
comment on column swrs_transform.report.reporting_period_duration is 'The length of the reporting period contained in report';
comment on column swrs_transform.report.status is 'The status of the report';
comment on column swrs_transform.report.version is 'The report version';
comment on column swrs_transform.report.submission_date is 'The date the report was submitted';
comment on column swrs_transform.report.last_modified_by is 'The person who last modified the report';
comment on column swrs_transform.report.last_modified_date is 'The timestamp recorded in SWRS when the report was last modified';
comment on column swrs_transform.report.update_comment is 'The description of the update';

create view swrs_transform.final_report as (
    with _report as (
    select *,
           row_number() over (
             partition by swrs_facility_id, reporting_period_duration
             order by
               swrs_report_id desc,
               submission_date desc,
               imported_at desc
               ) as _history_id
    from swrs_transform.report
    where submission_date is not null
      and report_type != 'SaleClosePurchase'
    and eccc_xml_file_id not in (select report.eccc_xml_file_id
                       from swrs_transform.ignore_organisation
                       join swrs_transform.report on ignore_organisation.swrs_organisation_id = report.swrs_organisation_id)
    order by swrs_report_id
  )
  select row_number() over () as id, swrs_report_id, eccc_xml_file_id
  from _report
  where _history_id = 1
  order by swrs_report_id asc
);

comment on view swrs_transform.final_report is 'The view showing the latest submitted report by swrs_transform.report.id';
comment on column swrs_transform.final_report.id is 'A generated index used for keying in the swrs schema';
comment on column swrs_transform.final_report.swrs_report_id is 'The foreign key referencing swrs_transform.report.id';
comment on column swrs_transform.final_report.eccc_xml_file_id is 'The foreign key referencing swrs_extract.eccc_xml_file.id';

commit;
