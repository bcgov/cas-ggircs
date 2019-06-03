-- Deploy ggircs:table_report to pg
-- requires: schema_ggircs

begin;

create table ggircs.report
(
    ghgr_import_id            integer primary key,
    source_xml                xml,
    imported_at               timestamptz,
    swrs_report_id            integer not null,
    prepop_report_id          integer,
    report_type               varchar(1000),
    swrs_facility_id          integer,
    swrs_organisation_id      integer,
    reporting_period_duration varchar(1000),
    status                    varchar(1000),
    version                   varchar(1000),
    submission_date           timestamptz,
    last_modified_by          varchar(1000),
    last_modified_date        timestamp,
    update_comment            varchar(1000),
    swrs_report_history_id    integer
);

comment on table ggircs.report is 'The materialized view housing all report data, derived from ghgr_import table';
comment on column ggircs.report.ghgr_import_id is 'The internal primary key for the file';
comment on column ggircs.report.source_xml is 'The raw xml file imported from GHGR';
comment on column ggircs.report.imported_at is 'The timestamp noting when the file was imported';
comment on column ggircs.report.swrs_report_id is 'The swrs report id';
comment on column ggircs.report.prepop_report_id is 'The prepop report id';
comment on column ggircs.report.report_type is 'The type of report';
comment on column ggircs.report.swrs_facility_id is 'The ID for the reporting facility';
comment on column ggircs.report.swrs_organisation_id is 'The ID for the reporting organisation';
comment on column ggircs.report.reporting_period_duration is 'The length of the reporting period contained in report';
comment on column ggircs.report.status is 'The status of the report';
comment on column ggircs.report.version is 'The report version';
comment on column ggircs.report.submission_date is 'The date the report was submitted';
comment on column ggircs.report.last_modified_by is 'The person who last modified the report';
comment on column ggircs.report.last_modified_date is 'The timestamp recorded in SWRS when the report was last modified';
comment on column ggircs.report.update_comment is 'The description of the update';
comment on column ggircs.report.swrs_report_history_id is 'The id denoting the history of the report (1 = latest)';

commit;
