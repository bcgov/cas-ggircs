-- deploy ggircs:function_refresh_materialized_views to pg
-- requires: materialized_view_report

begin;

create or replace function ggircs_swrs.refresh_materialized_views(data boolean)
  returns void as
$$

begin
  -- Refresh views with data
  if data then
    refresh materialized view ggircs_swrs.report with data;
    refresh materialized view ggircs_swrs.final_report with data;
    refresh materialized view ggircs_swrs.facility with data;
    refresh materialized view ggircs_swrs.organisation with data;
    refresh materialized view ggircs_swrs.activity with data;
    refresh materialized view ggircs_swrs.unit with data;
    refresh materialized view ggircs_swrs.fuel with data;
    refresh materialized view ggircs_swrs.emission with data;
    refresh materialized view ggircs_swrs.measured_emission_factor with data;
    refresh materialized view ggircs_swrs.descriptor with data;
    refresh materialized view ggircs_swrs.address with data;
    refresh materialized view ggircs_swrs.identifier with data;
    refresh materialized view ggircs_swrs.naics with data;
    refresh materialized view ggircs_swrs.contact with data;
    refresh materialized view ggircs_swrs.permit with data;
    refresh materialized view ggircs_swrs.parent_organisation with data;
    refresh materialized view ggircs_swrs.flat with data;
  end if;
  -- Refresh views with no data
  if not data then
    refresh materialized view ggircs_swrs.report with no data;
    refresh materialized view ggircs_swrs.final_report with no data;
    refresh materialized view ggircs_swrs.facility with no data;
    refresh materialized view ggircs_swrs.organisation with no data;
    refresh materialized view ggircs_swrs.activity with no data;
    refresh materialized view ggircs_swrs.unit with no data;
    refresh materialized view ggircs_swrs.fuel with no data;
    refresh materialized view ggircs_swrs.emission with no data;
    refresh materialized view ggircs_swrs.measured_emission_factor with no data;
    refresh materialized view ggircs_swrs.descriptor with no data;
    refresh materialized view ggircs_swrs.address with no data;
    refresh materialized view ggircs_swrs.identifier with no data;
    refresh materialized view ggircs_swrs.naics with no data;
    refresh materialized view ggircs_swrs.contact with no data;
    refresh materialized view ggircs_swrs.permit with no data;
    refresh materialized view ggircs_swrs.parent_organisation with no data;
    refresh materialized view ggircs_swrs.flat with no data;
  end if;
end

$$ language plpgsql volatile ;

commit;
