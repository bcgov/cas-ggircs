-- Revert ggircs:swrs/transform/function/load_report_history from pg

begin;

drop function swrs_transform.load_report_history;

commit;
