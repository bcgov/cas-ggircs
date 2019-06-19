-- Deploy ggircs:table_activity to pg
-- requires: schema_ggircs

begin;

create table ggircs.activity (

    id                        integer primary key,
    report_id                 integer references ggircs.report(id),
    single_facility_id        integer references ggircs.single_facility(id),
    lfo_facility_id           integer references ggircs.lfo_facility(id),
    ghgr_import_id            integer,
    activity_name             varchar(1000),
    process_name              varchar(1000),
    sub_process_name          varchar(1000),
    information_requirement   varchar(1000)
);

create index ggircs_activity_report_foreign_key on ggircs.activity(report_id);
create index ggircs_activity_single_facility_foreign_key on ggircs.activity(single_facility_id);
create index ggircs_activity_lfo_facility_foreign_key on ggircs.activity(lfo_facility_id);

comment on table ggircs.activity is 'The table for Process and SubProcess from each SWRS report (the "activity")';
comment on column ggircs.activity.id is 'The primary key';
comment on column ggircs.activity.single_facility_id is 'A foreign key reference to ggircs.single_facility';
comment on column ggircs.activity.lfo_facility_id is 'A foreign key reference to ggircs.lfo_facility';
comment on column ggircs.activity.report_id is 'A foreign key reference to ggircs.report';
comment on column ggircs.activity.ghgr_import_id is 'A foreign key reference to ggircs.ghgr_import.id';
comment on column ggircs.activity.activity_name is 'The name of the activity (the name of the child class under the Activity)';
comment on column ggircs.activity.process_name is 'The name of the process';
comment on column ggircs.activity.sub_process_name is 'The name of the sub-process';
comment on column ggircs.activity.information_requirement is 'The requirement in reporting regulation to report this activity';

commit;
