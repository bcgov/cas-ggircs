-- Deploy ggircs:function_load_measured_emission_factor to pg
-- requires: materialized_view_fuel
-- requires: materialized_view_final_report
-- requires: materialized_view_measured_emission_factor

begin;

drop function swrs_transform.load_measured_emission_factor;
  

commit;
