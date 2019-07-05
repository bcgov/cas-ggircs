-- Deploy ggircs:function_export_mv_to_table to pg
-- requires:
  -- table_ghgr_import materialized_view_report materialized_view_final_report
  -- materialized_view_facility materialized_view_organisation
  -- materialized_view_address materialized_view_contact
  -- materialized_view_naics materialized_view_identifier
  -- materialized_view_permit materialized_view_parent_organisation
  -- materialized_view_activity materialized_view_unit materialized_view_fuel
  -- materialized_view_emission materialized_view_additional_data

begin;

create or replace function ggircs_swrs.export_mv_to_table()
  returns void as
$function$

  declare

       mv_array text[] := $$
                          {report, organisation, facility,
                          activity, unit, identifier, naics, fuel,
                          emission, permit, parent_organisation, address,
                          contact, additional_data, measured_emission_factor}
                          $$;

  begin

    -- Refresh materialized views
    perform ggircs_swrs.refresh_materialized_views('with data');

    -- Loop to populate ggircs tables with data from ggircs_swrs
        for i in 1 .. array_upper(mv_array, 1)
      loop
        execute format('select ggircs_swrs.export_%s_to_ggircs()', mv_array[i]);
      end loop;

    -- Refresh materialized views with no data
    perform ggircs_swrs.refresh_materialized_views('with no data');
  end;

$function$ language plpgsql volatile ;

commit;
