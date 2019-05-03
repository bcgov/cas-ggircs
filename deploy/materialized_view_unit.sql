-- Deploy ggircs:materialized_view_unit to pg
-- requires: materialized_view_activity

begin;

-- Units from SubActivity
-- todo: explore any other attributes for units
create materialized view ggircs_swrs.unit as (
  with x as (
    select ghgr_import_id,
           id              as activity_id,
           xml_hunk        as activity_xml_hunk
    from ggircs_swrs.activity
    order by ghgr_import_id desc
  )
  select
         row_number() over (order by ghgr_import_id asc, x.activity_id asc) as id,
         ghgr_import_id,
         activity_id,
         unit_details.*

  from x,
       xmltable(
           '/SubProcess/Units/Unit'
           passing activity_xml_hunk
           columns
            unit_name varchar(1000) path './UnitName',
            unit_description varchar(1000) path './UnitDesc',
            xml_hunk xml path '.'
         ) as unit_details
)with no data;

create unique index ggircs_unit_primary_key on ggircs_swrs.unit (id);

comment on materialized view ggircs_swrs.unit is 'The materialized view containing the information on swrs machinery units';
comment on column ggircs_swrs.unit.id is 'The primary key for the unit';
comment on column ggircs_swrs.unit.ghgr_import_id is 'A foreign key reference to ggircs_swrs.ghgr_import.id';
comment on column ggircs_swrs.unit.activity_id is 'A foreign key reference to ggrics_swrs.activity.id';
comment on column ggircs_swrs.unit.unit_name is 'The name of the unit of machinery emitting greenhouse gas';
comment on column ggircs_swrs.unit.unit_description is 'The description of the unit of machinery emitting greenhouse gas';
comment on column ggircs_swrs.unit.xml_hunk is 'The raw xml hunk representing the unit';

commit;
