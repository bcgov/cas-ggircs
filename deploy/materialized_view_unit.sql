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
           xml_hunk
    from ggircs_swrs.activity
    order by ghgr_import_id desc
  )
  select
         row_number() over (order by x.activity_id asc) as id,
         ghgr_import_id,
         activity_id,
         activity,
         sub_activity,
         xml_hunk, -- todo: remove in cleanup phase
         unit_details.*

  from x,
       xmltable(
           '/SubProcess/Units/Unit'
           passing xml_hunk
           columns
            unit_name text path './UnitName',
            unit_description text path './UnitDesc',
            unit_xml xml path '.'
         ) as unit_details
)with no data;

create unique index ggircs_unit_primary_key on ggircs_swrs.unit (id);

commit;
