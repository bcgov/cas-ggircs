-- Deploy ggircs:table_report to pg
-- requires: schema_ggircs

begin;

create table ggircs_swrs_load.report
(
    id                        integer primary key,
    ghgr_import_id            integer,
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
    last_modified_date        timestamptz,
    update_comment            varchar(1000)
);

comment on table ggircs_swrs_load.report is 'The table housing all report data, derived from ghgr_import table';
comment on column ggircs_swrs_load.report.id is 'The primary key';
comment on column ggircs_swrs_load.report.ghgr_import_id is 'The internal primary key for the file';
comment on column ggircs_swrs_load.report.source_xml is 'The raw xml file imported from GHGR';
comment on column ggircs_swrs_load.report.imported_at is 'The timestamp noting when the file was imported';
comment on column ggircs_swrs_load.report.swrs_report_id is 'The swrs report id';
comment on column ggircs_swrs_load.report.prepop_report_id is 'The prepop report id';
comment on column ggircs_swrs_load.report.report_type is 'The type of report';
comment on column ggircs_swrs_load.report.swrs_facility_id is 'The ID for the reporting facility';
comment on column ggircs_swrs_load.report.swrs_organisation_id is 'The ID for the reporting organisation';
comment on column ggircs_swrs_load.report.reporting_period_duration is 'The length of the reporting period contained in report';
comment on column ggircs_swrs_load.report.status is 'The status of the report';
comment on column ggircs_swrs_load.report.version is 'The report version';
comment on column ggircs_swrs_load.report.submission_date is 'The date the report was submitted';
comment on column ggircs_swrs_load.report.last_modified_by is 'The person who last modified the report';
comment on column ggircs_swrs_load.report.last_modified_date is 'The timestamp recorded in SWRS when the report was last modified';
comment on column ggircs_swrs_load.report.update_comment is 'The description of the update';

commit;
