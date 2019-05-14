-- Revert ggircs:materialized_view_measured_emission_factor from pg

begin;

drop materialized view ggircs_swrs.measured_emission_factor;

commit;
