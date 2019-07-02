-- Deploy ggircs:function_refresh_materialized_views to pg
-- requires: table_ghgr_import

begin;

-- @view: string (the view to refresh), @data string (with or without data)
create or replace function ggircs_swrs.refresh_materialized_views(data text)
  returns void as
$function$

    declare

       mv_array text[] := $$
                          {report, organisation, facility,
                          activity, unit, identifier, naics, emission,
                          final_report, fuel, permit, parent_organisation, contact,
                          address, additional_data, measured_emission_factor}
                          $$;

begin
  -- Refresh views with data
  for i in 1 .. array_upper(mv_array, 1)
      loop
        execute format('refresh materialized view ggircs_swrs.%s %s', mv_array[i], data);
      end loop;


end

$function$ language plpgsql volatile ;

commit;


/**

declare

       mv_array text[] := $$
                          {report, organisation, facility,
                          activity, unit, identifier, naics, emission,
                          final_report, fuel, permit, parent_organisation, contact,
                          address, additional_data, measured_emission_factor}
                          $$;

  begin

    -- Refresh materialized views
    for i in 1 .. array_upper(mv_array, 1)
      loop
        perform ggircs_swrs.refresh_materialized_views(quote_ident(mv_array[i]), 'with data');
      end loop;


**/