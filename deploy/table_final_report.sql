-- Deploy ggircs:table_final_report to pg
-- requires: schema_ggircs

begin;

create table ggircs.final_report (

    id                        integer primary key,
    ghgr_import_id            integer,
    swrs_report_id            integer
);

comment on table ggircs.final_report is 'The table showing the latest submitted report by ggircs.report.id';
comment on column ggircs.final_report.id is 'The primary key';
comment on column ggircs.final_report.swrs_report_id is 'The foreign key referencing ggircs.report.id';
comment on column ggircs.final_report.ghgr_import_id is 'The foreign key referencing ggircs.ghgr_import.id';

commit;
