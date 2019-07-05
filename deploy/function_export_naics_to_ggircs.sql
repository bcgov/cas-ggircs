-- Deploy ggircs:function_export_naics_to_ggircs to pg
-- requires: materialized_view_report
-- requires: materialized_view_facility
-- requires: materialized_view_final_report
-- requires: table_naics_mapping
-- requires: materialized_view_naics

begin;

create or replace function ggircs_swrs.export_naics_to_ggircs()
  returns void as
$function$
    begin

        delete from ggircs.naics;
        insert into ggircs.naics(id, ghgr_import_id, facility_id,  registration_data_facility_id, report_id, swrs_facility_id, path_context, naics_classification, naics_code, naics_priority)

        select _naics.id, _naics.ghgr_import_id, _facility.id,
            (select _facility.id where _naics.path_context = 'RegistrationData'),
            _report.id, _naics.swrs_facility_id,
            _naics.path_context, _naics.naics_classification, _naics.naics_code, _naics.naics_priority

        from ggircs_swrs.naics as _naics
        inner join ggircs_swrs.final_report as _final_report on _naics.ghgr_import_id = _final_report.ghgr_import_id
        -- FK Naics ->  Facility
        left join ggircs_swrs.facility as _facility
          on _naics.ghgr_import_id = _facility.ghgr_import_id
        -- FK Naics -> Report
        left join ggircs_swrs.report as _report
          on _naics.ghgr_import_id = _report.ghgr_import_id;

    end
$function$ language plpgsql volatile;

commit;
