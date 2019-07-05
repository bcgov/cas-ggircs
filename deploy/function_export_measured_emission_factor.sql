-- Deploy ggircs:function_export_measured_emission_factor to pg
-- requires: materialized_view_fuel
-- requires: materialized_view_final_report
-- requires: materialized_view_measured_emission_factor

begin;

create or replace function ggircs_swrs.export_measured_emission_factor_to_ggircs()
  returns void as
$function$
    begin

        insert into ggircs.measured_emission_factor (id, ghgr_import_id, fuel_id,
                                                     activity_name, sub_activity_name, unit_name, sub_unit_name,
                                                     measured_emission_factor_amount, measured_emission_factor_gas, measured_emission_factor_unit_type)

        select _measured_emission_factor.id, _measured_emission_factor.ghgr_import_id, _fuel.id,
               _measured_emission_factor.activity_name, _measured_emission_factor.sub_activity_name, _measured_emission_factor.unit_name, _measured_emission_factor.sub_unit_name,
               _measured_emission_factor.measured_emission_factor_amount, _measured_emission_factor.measured_emission_factor_gas, _measured_emission_factor.measured_emission_factor_unit_type

        from ggircs_swrs.measured_emission_factor as _measured_emission_factor

        inner join ggircs_swrs.final_report as _final_report on _measured_emission_factor.ghgr_import_id = _final_report.ghgr_import_id
        --FK Measured Emission Factor -> Fuel
        left join ggircs_swrs.fuel as _fuel
          on _measured_emission_factor.ghgr_import_id = _fuel.ghgr_import_id
          and _measured_emission_factor.process_idx = _fuel.process_idx
          and _measured_emission_factor.sub_process_idx = _fuel.sub_process_idx
          and _measured_emission_factor.activity_name = _fuel.activity_name
          and _measured_emission_factor.sub_activity_name = _fuel.sub_activity_name
          and _measured_emission_factor.unit_name = _fuel.unit_name
          and _measured_emission_factor.sub_unit_name = _fuel.sub_unit_name
          and _measured_emission_factor.substance_idx = _fuel.substance_idx
          and _measured_emission_factor.substances_idx = _fuel.substances_idx
          and _measured_emission_factor.sub_unit_name = _fuel.sub_unit_name
          and _measured_emission_factor.units_idx = _fuel.units_idx
          and _measured_emission_factor.unit_idx = _fuel.unit_idx
          and _measured_emission_factor.fuel_idx = _fuel.fuel_idx;

    end
$function$ language plpgsql volatile;

commit;
