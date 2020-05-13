-- Deploy ggircs:table_activity to pg
-- requires: schema_ggircs

begin;

create table swrs.activity (

    id                        integer primary key,
    report_id                 integer references swrs.report(id),
    facility_id               integer references swrs.facility(id),
    eccc_xml_file_id            integer,
    activity_name             varchar(1000),
    process_name              varchar(1000),
    sub_process_name          varchar(1000),
    information_requirement   varchar(1000)
);

create index ggircs_activity_report_foreign_key on swrs.activity(report_id);
create index ggircs_activity_facility_foreign_key on swrs.activity(facility_id);


comment on table swrs.activity is 'The table for Process and SubProcess from each SWRS report (the "activity")';
comment on column swrs.activity.id is 'The primary key';
comment on column swrs.activity.facility_id is 'A foreign key reference to swrs.facility';
comment on column swrs.activity.report_id is 'A foreign key reference to swrs.report';
comment on column swrs.activity.eccc_xml_file_id is 'A foreign key reference to swrs.eccc_xml_file.id';
comment on column swrs.activity.activity_name is 'The name of the activity (the name of the child class under the Activity)';
comment on column swrs.activity.process_name is 'The name of the process';
comment on column swrs.activity.sub_process_name is 'The name of the sub-process';
comment on column swrs.activity.information_requirement is 'The requirement in reporting regulation to report this activity';

commit;
