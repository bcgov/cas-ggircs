-- Deploy ggircs:load_unit to pg
-- requires: materialized_view_final_report
-- requires: materialized_view_activity
-- requires: materialized_view_unit

begin;

create or replace function swrs_transform.load_unit()
  returns void as
$function$
    begin

        delete from swrs_load.unit;
        insert into swrs_load.unit (id, eccc_xml_file_id, activity_id, activity_name, unit_name, unit_description, cogen_unit_name, cogen_cycle_type, cogen_nameplate_capacity,
                                 cogen_net_power, cogen_steam_heat_acq_quantity, cogen_steam_heat_acq_name, cogen_supplemental_firing_purpose, cogen_thermal_output_quantity,
                                 non_cogen_nameplate_capacity, non_cogen_net_power, non_cogen_unit_name)

        select _unit.id, _unit.eccc_xml_file_id, _activity.id, _unit.activity_name, _unit.unit_name, _unit.unit_description, _unit.cogen_unit_name, _unit.cogen_cycle_type,
               _unit.cogen_nameplate_capacity, _unit.cogen_net_power, _unit.cogen_steam_heat_acq_quantity, _unit.cogen_steam_heat_acq_name, _unit.cogen_supplemental_firing_purpose,
               _unit.cogen_thermal_output_quantity, _unit.non_cogen_nameplate_capacity, _unit.non_cogen_net_power, _unit.non_cogen_unit_name

        from swrs_transform.unit as _unit

        inner join swrs_transform.final_report as _final_report on _unit.eccc_xml_file_id = _final_report.eccc_xml_file_id

        -- FK Unit -> Activity
        left join swrs_transform.activity as _activity
          on _unit.eccc_xml_file_id = _activity.eccc_xml_file_id
          and _unit.process_idx = _activity.process_idx
          and _unit.sub_process_idx = _activity.sub_process_idx
          and _unit.activity_name = _activity.activity_name;

    end
$function$ language plpgsql volatile;

commit;
