-- Deploy ggircs:swrs/history/computed_column/report_latest_swrs_report to pg
-- requires: swrs/history/table/report

begin;

  create or replace function swrs_history.report_latest_swrs_report(report swrs_history.report)
  returns swrs_history.report
  as $$
    select r.*
      from swrs_history.report r
      join swrs_extract.eccc_xml_file x
        on r.eccc_xml_file_id = x.id
      join swrs_extract.eccc_zip_file z
        on x.zip_file_id = z.id
      where r.swrs_report_id = report.swrs_report_id
      order by zip_file_name desc limit 1;
  $$ language 'sql' stable;

comment on function swrs_history.report_latest_swrs_report is 'Computed column returns the latest report ordered by zip_file_name';

commit;
