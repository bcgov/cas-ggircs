-- Revert ggircs:swrs/transform/materialized_view/historical_report_attachment_data from pg

begin;

drop materialized view swrs_transform.historical_report_attachment_data;

commit;
