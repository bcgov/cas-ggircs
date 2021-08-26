-- Verify ggircs:swrs/transform/materialized_view/historical_report_emission_data on pg

begin;

select * from swrs_transform.historical_report_emission_data where false;

rollback;
