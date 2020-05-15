-- Deploy ggircs:materialized_view_activity to pg
-- requires: table_eccc_xml_file

begin;

create materialized view swrs_transform.activity as (
  select row_number() over () as id, id as eccc_xml_file_id, activity_details.*
  from swrs_extract.eccc_xml_file,
       xmltable(
           '//SubProcess'
           passing xml_file
           columns
             process_idx integer path 'string(count(./ancestor::Process/preceding-sibling::Process))' not null,
             sub_process_idx integer path 'string(count(./preceding-sibling::SubProcess))' not null,
             activity_name varchar(1000) path 'name(./ancestor::Process/parent::*)' not null,
             process_name varchar(1000) path './ancestor::Process/@ProcessName[normalize-space(.)]',
             sub_process_name varchar(1000) path './@SubprocessName[normalize-space(.)]',
             information_requirement varchar(1000) path './@InformationRequirement[normalize-space(.)]'
         ) as activity_details
) with no data;

create unique index ggircs_activity_primary_key on swrs_transform.activity (eccc_xml_file_id, process_idx, sub_process_idx, activity_name);

comment on materialized view swrs_transform.activity is 'The materialized view for Process and SubProcess from each SWRS report (the "activity")';
comment on column swrs_transform.activity.id is 'A generated index used for keying in the ggircs schema';
comment on column swrs_transform.activity.eccc_xml_file_id is 'A foreign key reference to swrs_extract.eccc_xml_file.id';
comment on column swrs_transform.activity.process_idx is 'The number of preceding Process siblings before this activity';
comment on column swrs_transform.activity.sub_process_idx is 'The number of preceding SubProcess siblings before this activity';
comment on column swrs_transform.activity.activity_name is 'The name of the activity (the name of the child class under the Activity)';
comment on column swrs_transform.activity.process_name is 'The name of the process';
comment on column swrs_transform.activity.sub_process_name is 'The name of the sub-process';
comment on column swrs_transform.activity.information_requirement is 'The requirement in reporting regulation to report this activity';

commit;
