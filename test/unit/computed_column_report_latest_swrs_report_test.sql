set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(2);

-- Setup
truncate swrs_extract.eccc_zip_file restart identity cascade;
truncate swrs_history.report restart identity cascade;
insert into swrs_extract.eccc_zip_file(zip_file_name) values ('zip1'), ('zip2');
insert into swrs_extract.eccc_xml_file(xml_file, xml_file_name, zip_file_id) values ('<report></report>', 'xml1', 1), ('<report></report>', 'xml1', 2);
insert into swrs_history.report(id, eccc_xml_file_id, swrs_report_id, version) values (1, 1, 1, 1), (2, 2, 1, 2);

-- Computed column exists
select has_function( 'swrs_history', 'report_latest_swrs_report', 'Schema swrs_history has computed_column report_latest_swrs_report' );

-- Computed column returns the latest swrs report
select results_eq (
  $$
    with record as (select row(report.*)::swrs_history.report from swrs_history.report where id=1)
    select eccc_xml_file_id, version from swrs_history.report_latest_swrs_report((select * from record))
  $$,
  $$
  values (2::integer, 2::varchar)
  $$,
  'report_latest_swrs_report returns the swrs report'
);

select finish();
rollback;
