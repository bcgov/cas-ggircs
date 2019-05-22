-- deploy ggircs:function_refresh_materialized_views to pg
-- requires: materialized_view_report

begin;

create or replace function ggircs_swrs.refresh_materialized_views()
  returns void as
$$

begin
  refresh materialized view ggircs_swrs.report;
  refresh materialized view ggircs_swrs.final_report;
  refresh materialized view ggircs_swrs.facility;
  refresh materialized view ggircs_swrs.organisation;
  refresh materialized view ggircs_swrs.activity;
  refresh materialized view ggircs_swrs.unit;
  refresh materialized view ggircs_swrs.fuel;
  refresh materialized view ggircs_swrs.emission;
  refresh materialized view ggircs_swrs.measured_emission_factor;
  refresh materialized view ggircs_swrs.descriptor;
  refresh materialized view ggircs_swrs.address;
  refresh materialized view ggircs_swrs.identifier;
  refresh materialized view ggircs_swrs.naics;
  refresh materialized view ggircs_swrs.contact;
  refresh materialized view ggircs_swrs.permit;
  refresh materialized view ggircs_swrs.parent_organisation;
  refresh materialized view ggircs_swrs.flat;
end

$$ language plpgsql stable ;

commit;
