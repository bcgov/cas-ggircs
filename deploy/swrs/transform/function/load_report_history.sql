-- Deploy ggircs:swrs/transform/function/load_report_history to pg
-- requires: swrs/transform/materialized_view/report
-- requires: swrs/transform/materialized_view/historical_report_emission_data
-- requires: swrs/public/table/report

begin;

create or replace function swrs_transform.load_report_history()
  returns void as
$function$
    begin
        delete from swrs_history_load.report;
        insert into swrs_history_load.report (id, eccc_xml_file_id, imported_at, swrs_report_id, prepop_report_id, report_type, swrs_facility_id, swrs_organisation_id,
                                       reporting_period_duration, status, version, submission_date, last_modified_by, last_modified_date, update_comment, grand_total_less_co2bioc, reporting_only_grand_total, co2bioc)

        select _report.id, _report.eccc_xml_file_id, imported_at, _report.swrs_report_id, prepop_report_id, report_type, swrs_facility_id, swrs_organisation_id,
               reporting_period_duration, status, version, submission_date, last_modified_by, last_modified_date, update_comment, (_hred.grand_total_emission - _hred.co2bioc), _hred.reporting_only_grand_total, _hred.co2bioc

        from swrs_transform.report as _report
          left join swrs_transform.historical_report_emission_data as _hred
          on _report.eccc_xml_file_id = _hred.eccc_xml_file_id;
    end
$function$ language plpgsql volatile;
commit;
