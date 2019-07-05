-- Deploy ggircs:function_export_unit_to_ggircs to pg
-- requires: materialized_view_final_report
-- requires: materialized_view_activity
-- requires: materialized_view_unit

begin;

create or replace function ggircs_swrs.export_unit_to_ggircs()
  returns void as
$function$
    begin

        delete from ggircs.unit;
        insert into ggircs.unit (id, ghgr_import_id, activity_id, activity_name, unit_name, unit_description, cogen_unit_name, cogen_cycle_type, cogen_nameplate_capacity,
                                 cogen_net_power, cogen_steam_heat_acq_quantity, cogen_steam_heat_acq_name, cogen_supplemental_firing_purpose, cogen_thermal_output_quantity,
                                 non_cogen_nameplate_capacity, non_cogen_net_power, non_cogen_unit_name)

        select _unit.id, _unit.ghgr_import_id, _activity.id, _unit.activity_name, _unit.unit_name, _unit.unit_description, _unit.cogen_unit_name, _unit.cogen_cycle_type,
               _unit.cogen_nameplate_capacity, _unit.cogen_net_power, _unit.cogen_steam_heat_acq_quantity, _unit.cogen_steam_heat_acq_name, _unit.cogen_supplemental_firing_purpose,
               _unit.cogen_thermal_output_quantity, _unit.non_cogen_nameplate_capacity, _unit.non_cogen_net_power, _unit.non_cogen_unit_name

        from ggircs_swrs.unit as _unit

        inner join ggircs_swrs.final_report as _final_report on _unit.ghgr_import_id = _final_report.ghgr_import_id

        -- FK Unit -> Activity
        left join ggircs_swrs.activity as _activity
          on _unit.ghgr_import_id = _activity.ghgr_import_id
          and _unit.process_idx = _activity.process_idx
          and _unit.sub_process_idx = _activity.sub_process_idx
          and _unit.activity_name = _activity.activity_name;

    end
$function$ language plpgsql volatile;

commit;
