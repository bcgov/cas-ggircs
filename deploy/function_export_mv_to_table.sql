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
  begin

    -- Refresh materialized views
    perform ggircs_swrs.refresh_materialized_views('with data');

    -- Populate tables
    -- REPORT
    perform ggircs_swrs.export_report_to_ggircs();

    -- ORGANISATION
    perform ggircs_swrs.export_organisation_to_ggircs();

    -- FACILITY
    perform ggircs_swrs.export_facility_to_ggircs();

    -- ACTIVITY
    perform ggircs_swrs.export_activity_to_ggircs();

    -- UNIT
    perform ggircs_swrs.export_unit_to_ggircs();

    -- IDENTIFIER
    perform ggircs_swrs.export_identifier_to_ggircs();

    -- NAICS
    perform ggircs_swrs.export_naics_to_ggircs();

    -- FUEL
    perform ggircs_swrs.export_fuel_to_ggircs();

    -- EMISSION
    perform ggircs_swrs.export_emission_to_ggircs();

    -- PERMIT
    perform ggircs_swrs.export_permit_to_ggircs();

    -- PARENT ORGANISATION
    perform ggircs_swrs.export_parent_organisation_to_ggircs();

    -- ADDRESS
    perform ggircs_swrs.export_address_to_ggircs();

    -- CONTACT
    perform ggircs_swrs.export_contact_to_ggircs();

    -- ADDITIONAL DATA
    perform ggircs_swrs.export_additional_data_to_ggircs();

    -- MEASURED EMISSION FACTOR
    perform ggircs_swrs.export_measured_emission_factor_to_ggircs();

    -- Refresh materialized views with no data
    perform ggircs_swrs.refresh_materialized_views('with no data');
  end;

$function$ language plpgsql volatile ;

commit;
