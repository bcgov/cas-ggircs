-- Deploy ggircs:materialized_view_activity to pg
-- requires: materialized_view_report

begin;

create materialized view ggircs_swrs.activity as (
  with x as (
    select ghgr_import.id as ghgr_import_id,
           ghgr_import.xml_file as source_xml
    from ggircs_swrs.ghgr_import
  )
  select row_number() over (order by x.ghgr_import_id asc) as id,
         x.ghgr_import_id,
         activity_details.*
  from x,
       xmltable(
           '/ReportData/ActivityData/ActivityPages/Process/SubProcess'
           passing x.source_xml
           columns
             process_name varchar(1000) path '../@ProcessName[normalize-space(.)]', -- Todo: Redundant. Remove in cleanup phase
             subprocess_name varchar(1000) path './@SubprocessName[normalize-space(.)]',
             information_requirement varchar(1000) path './@InformationRequirement[normalize-space(.)]',
             xml_hunk xml path '.'
         ) as activity_details
) with no data;

comment on materialized view ggircs_swrs.activity is 'The materialized view for Activity and Subactivity from each SWRS report';
comment on column ggircs_swrs.activity.id is 'The primary key for the activity';
comment on column ggircs_swrs.activity.ghgr_import_id is 'A foreign key reference to ggircs_swrs.ghgr_import';
comment on column ggircs_swrs.activity.process_name is 'The name of the activity';
comment on column ggircs_swrs.activity.subprocess_name is 'The name of the sub-activity';
comment on column ggircs_swrs.activity.information_requirement is 'The requirement in reporting regulation to report this activity';
comment on column ggircs_swrs.activity.xml_hunk is 'The raw xml hunk used to extract this activity';

create unique index ggircs_activity_primary_key on ggircs_swrs.activity (id);

commit;

