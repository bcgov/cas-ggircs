-- Revert ggircs:swrs/transform/materialized_view/historical_report_emission_data from pg

begin;

drop materialized view swrs_transform.historical_report_emission_data;

commit;
