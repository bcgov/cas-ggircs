-- Deploy ggircs:function_load_fuel to pg
-- requires: materialized_view_report
-- requires: materialized_view_final_report
-- requires: materialized_view_unit
-- requires: table_fuel_mapping
-- requires: materialized_view_fuel

begin;

create or replace function ggircs_swrs_transform.load_fuel()
  returns void as
$function$
    begin

        delete from ggircs_swrs_load.fuel;
        insert into ggircs_swrs_load.fuel(id, ghgr_import_id, report_id, unit_id, fuel_mapping_id,
                                activity_name, sub_activity_name, unit_name, sub_unit_name, fuel_type, fuel_classification, fuel_description,
                                fuel_units, annual_fuel_amount, annual_weighted_avg_carbon_content, annual_weighted_avg_hhv, annual_steam_generation, alternative_methodology_description,
                                other_flare_details, q1, q2, q3, q4)

        select _fuel.id, _fuel.ghgr_import_id, _report.id, _unit.id, _fuel_mapping.id,
               _fuel.activity_name, _fuel.sub_activity_name, _fuel.unit_name, _fuel.sub_unit_name, _fuel.fuel_type, _fuel.fuel_classification, _fuel.fuel_description,
               _fuel.fuel_units, _fuel.annual_fuel_amount, _fuel.annual_weighted_avg_carbon_content, _fuel.annual_weighted_avg_hhv, _fuel.annual_steam_generation,
               _fuel.alternative_methodology_description, _fuel.other_flare_details, _fuel.q1, _fuel.q2, _fuel.q3, _fuel.q4

        from ggircs_swrs_transform.fuel as _fuel
        inner join ggircs_swrs_transform.final_report as _final_report on _fuel.ghgr_import_id = _final_report.ghgr_import_id
        -- FK Fuel -> Report
        left join ggircs_swrs_transform.report as _report
        on _fuel.ghgr_import_id = _report.ghgr_import_id
        -- FK Fuel -> Unit
        left join ggircs_swrs_transform.unit as _unit
          on _fuel.ghgr_import_id = _unit.ghgr_import_id
          and _fuel.process_idx = _unit.process_idx
          and _fuel.sub_process_idx = _unit.sub_process_idx
          and _fuel.activity_name = _unit.activity_name
          and _fuel.units_idx = _unit.units_idx
          and _fuel.unit_idx = _unit.unit_idx
        left join ggircs_swrs_load.fuel_mapping as _fuel_mapping
          on _fuel.fuel_type = _fuel_mapping.fuel_type;

    end
$function$ language plpgsql volatile;

commit;
