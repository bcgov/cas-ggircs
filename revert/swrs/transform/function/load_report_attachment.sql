-- Revert ggircs:swrs/transform/function/load_report_attachment from pg

begin;

drop function swrs_transform.load_report_attachment;

commit;
