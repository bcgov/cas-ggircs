-- Deploy ggircs:swrs/history/table/report to pg
-- requires: ggircs:swrs/history/schema

begin;

create table swrs_history.report
(
    id                        integer primary key,
    eccc_xml_file_id            integer,
    source_xml                xml,
    imported_at               timestamptz,
    swrs_report_id            integer not null,
    prepop_report_id          integer,
    report_type               varchar(1000),
    swrs_facility_id          integer,
    swrs_organisation_id      integer,
    reporting_period_duration integer,
    status                    varchar(1000),
    version                   varchar(1000),
    submission_date           timestamptz,
    last_modified_by          varchar(1000),
    last_modified_date        timestamptz,
    update_comment            varchar(10000),
    grand_total_less_co2bioc  numeric,
    reporting_only_grand_total numeric,
    co2bioc                   numeric
);

comment on table swrs_history.report is 'The table housing all report data, derived from eccc_xml_file table';
comment on column swrs_history.report.id is 'The primary key';
comment on column swrs_history.report.eccc_xml_file_id is 'The internal primary key for the file';
comment on column swrs_history.report.source_xml is 'The raw xml file imported from GHGR';
comment on column swrs_history.report.imported_at is 'The timestamp noting when the file was imported';
comment on column swrs_history.report.swrs_report_id is 'The swrs report id';
comment on column swrs_history.report.prepop_report_id is 'The prepop report id';
comment on column swrs_history.report.report_type is 'The type of report';
comment on column swrs_history.report.swrs_facility_id is 'The ID for the reporting facility';
comment on column swrs_history.report.swrs_organisation_id is 'The ID for the reporting organisation';
comment on column swrs_history.report.reporting_period_duration is 'The length of the reporting period contained in report';
comment on column swrs_history.report.status is 'The status of the report';
comment on column swrs_history.report.version is 'The report version';
comment on column swrs_history.report.submission_date is 'The date the report was submitted';
comment on column swrs_history.report.last_modified_by is 'The person who last modified the report';
comment on column swrs_history.report.last_modified_date is 'The timestamp recorded in SWRS when the report was last modified';
comment on column swrs_history.report.update_comment is 'The description of the update';
comment on column swrs_history.report.update_comment is 'The total GHGR emissions reported in this report. Used by compliance and enforcement.';
comment on column swrs_history.report.update_comment is 'The total emissions under the ReportingOnly tag. Used by compliance and enforcement';
comment on column swrs_history.report.update_comment is 'The total quantity of CO2bioC reported in this report. Used by compliance and enforcement';

commit;
