-- Deploy ggircs:table_activity to pg
-- requires: schema_ggircs

begin;

create table ggircs_swrs_load.activity (

    id                        integer primary key,
    report_id                 integer references ggircs_swrs_load.report(id),
    facility_id               integer references ggircs_swrs_load.facility(id),
    ghgr_import_id            integer,
    activity_name             varchar(1000),
    process_name              varchar(1000),
    sub_process_name          varchar(1000),
    information_requirement   varchar(1000)
);

create index ggircs_activity_report_foreign_key on ggircs_swrs_load.activity(report_id);
create index ggircs_activity_facility_foreign_key on ggircs_swrs_load.activity(facility_id);


comment on table ggircs_swrs_load.activity is 'The table for Process and SubProcess from each SWRS report (the "activity")';
comment on column ggircs_swrs_load.activity.id is 'The primary key';
comment on column ggircs_swrs_load.activity.facility_id is 'A foreign key reference to ggircs_swrs_load.facility';
comment on column ggircs_swrs_load.activity.report_id is 'A foreign key reference to ggircs_swrs_load.report';
comment on column ggircs_swrs_load.activity.ghgr_import_id is 'A foreign key reference to ggircs_swrs_load.ghgr_import.id';
comment on column ggircs_swrs_load.activity.activity_name is 'The name of the activity (the name of the child class under the Activity)';
comment on column ggircs_swrs_load.activity.process_name is 'The name of the process';
comment on column ggircs_swrs_load.activity.sub_process_name is 'The name of the sub-process';
comment on column ggircs_swrs_load.activity.information_requirement is 'The requirement in reporting regulation to report this activity';

commit;
