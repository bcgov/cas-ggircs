-- Deploy ggircs:function_load to pg
-- requires:
  -- table_ghgr_import materialized_view_report materialized_view_final_report
  -- materialized_view_facility materialized_view_organisation
  -- materialized_view_address materialized_view_contact
  -- materialized_view_naics materialized_view_identifier
  -- materialized_view_permit materialized_view_parent_organisation
  -- materialized_view_activity materialized_view_unit materialized_view_fuel
  -- materialized_view_emission materialized_view_additional_data

begin;

create or replace function ggircs_swrs_transform.load()
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
    perform ggircs_swrs_transform.transform('with data');

    -- Create the load schema, without records
    drop schema if exists ggircs_swrs_load cascade;
    raise notice '[%] Creating temporary schema ggircs_swrs_load...', timeofday()::timestamp;
    perform ggircs_swrs_transform.clone_schema('ggircs', 'ggircs_swrs_load', false);

    -- Loop to populate ggircs tables with data from ggircs_swrs
        for i in 1 .. array_upper(mv_array, 1)
      loop
        execute format('select ggircs_swrs_transform.load_%s()', mv_array[i]);
        raise notice '[%] Loaded %...', timeofday()::timestamp, mv_array[i];
      end loop;

    -- Refresh materialized views with no data
    perform ggircs_swrs_transform.transform('with no data');


    raise notice 'Overriding to the live data schema';
    drop schema if exists ggircs cascade;
    alter schema ggircs_swrs_load rename to ggircs;

  end;

$function$ language plpgsql volatile ;

commit;
