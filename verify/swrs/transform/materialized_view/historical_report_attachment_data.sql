-- Verify ggircs:swrs/transform/materialized_view/historical_report_attachment_data on pg

begin;

select * from swrs_transform.historical_report_attachment_data where false;

rollback;
