-- Deploy ggircs:materialized_view_unit to pg
-- requires: table_ghgr_import

begin;

-- Units from SubActivity
-- todo: explore any other attributes for units
create materialized view ggircs_swrs.unit as (
  with x as (
    select ghgr_import_id,
           id              as activity_id,
           process_name    as activity,
           subprocess_name as sub_activity,
           xml_hunk        as activity_xml_hunk
    from ggircs_swrs.activity
    order by ghgr_import_id desc
  )
  select
         row_number() over (order by x.activity_id asc) as id,
         ghgr_import_id,
         activity_id,
         activity,
         sub_activity,
         activity_xml_hunk, -- todo: remove in cleanup phase
         unit_details.*

  from x,
       xmltable(
           '/SubProcess/Units/Unit'
           passing activity_xml_hunk
           columns
            unit_name varchar(1000) path './UnitName',
            unit_description varchar(1000) path './UnitDesc',
            unit_xml_hunk xml path '.'
         ) as unit_details
)with no data;

create unique index ggircs_unit_primary_key on ggircs_swrs.unit (id);

comment on materialized view ggircs_swrs.unit is 'The materialized view containing the information on units';
comment on column ggircs_swrs.unit.id is 'The primary key for the unit';
comment on column ggircs_swrs.unit.ghgr_import_id is 'A foreign key reference to ggircs_swrs.ghgr_import';
comment on column ggircs_swrs.unit.activity_id is 'A foreign key reference to ggrics_swrs.activity';
comment on column ggircs_swrs.unit.activity is 'The name of the activity';
comment on column ggircs_swrs.unit.sub_activity is 'The name of the sub-activity';
comment on column ggircs_swrs.unit.activity_xml_hunk is 'The raw xml hunk used to extract this unit';
comment on column ggircs_swrs.unit.unit_name is 'The name of the unit';
comment on column ggircs_swrs.unit.unit_description is 'The description of the unit';
comment on column ggircs_swrs.unit.unit_xml_hunk is 'The xml hunk beneath the unit';

commit;
