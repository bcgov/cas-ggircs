-- Revert ggircs:materialized_view_measured_emission_factor from pg

begin;

drop materialized view swrs_transform.measured_emission_factor;

commit;
