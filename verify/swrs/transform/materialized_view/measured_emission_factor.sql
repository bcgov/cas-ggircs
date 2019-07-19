-- Verify ggircs:materialized_view_measured_emission_factor on pg

begin;

select * from ggircs_swrs_transform.measured_emission_factor where false;

rollback;
