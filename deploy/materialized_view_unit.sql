-- Deploy ggircs:materialized_view_unit to pg
-- requires: table_ghgr_import

begin;

-- Units from SubActivity
-- todo: explore any other attributes for units
create materialized view ggircs_private.unit as (
  with x as (
    select report_id,
           id              as activity_id,
           swrs_report_id,
           swrs_report_history_id,
           process_name    as activity,
           subprocess_name as sub_activity,
           sub_activity_xml
    from activity
    order by report_id desc
  )
  select
         row_number() over (order by x.activity_id asc) as id,
         report_id,
         swrs_report_id,
         activity_id,
         activity,
         sub_activity,
         sub_activity_xml, -- todo: remove in cleanup phase
         unit_details.*,
         swrs_report_history_id

  from x,
       xmltable(
           '/SubProcess/Units/Unit'
           passing sub_activity_xml
           columns
            unit_name text path './UnitName',
            unit_description text path './UnitDesc',
            unit_xml xml path '.'
         ) as unit_details
);

create unique index ggircs_unit_primary_key on ggircs_private.unit (id);

commit;
