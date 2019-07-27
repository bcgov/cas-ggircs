-- Deploy ggircs:function_load_naics to pg
-- requires: materialized_view_report
-- requires: materialized_view_facility
-- requires: materialized_view_final_report
-- requires: table_naics_mapping
-- requires: materialized_view_naics

begin;

create or replace function swrs_transform.load_naics()
  returns void as
$function$
    begin

        delete from swrs_load.naics;
        insert into swrs_load.naics(id, ghgr_import_id, facility_id,  registration_data_facility_id, report_id, swrs_facility_id, path_context, naics_classification, naics_code, naics_priority)

        select _naics.id, _naics.ghgr_import_id, _facility.id,
            (select _facility.id where _naics.path_context = 'RegistrationData'),
            _report.id, _naics.swrs_facility_id,
            _naics.path_context, _naics.naics_classification, _naics.naics_code, _naics.naics_priority

        from swrs_transform.naics as _naics
        inner join swrs_transform.final_report as _final_report on _naics.ghgr_import_id = _final_report.ghgr_import_id
        -- FK Naics ->  Facility
        left join swrs_transform.facility as _facility
          on _naics.ghgr_import_id = _facility.ghgr_import_id
        -- FK Naics -> Report
        left join swrs_transform.report as _report
          on _naics.ghgr_import_id = _report.ghgr_import_id;

    end
$function$ language plpgsql volatile;

commit;
