-- Deploy ggircs:function_export_permit_to_ggircs to pg
-- requires: materialized_view_facility
-- requires: materialized_view_final_report
-- requires: materialized_view_permit

begin;

create or replace function ggircs_swrs.export_permit_to_ggircs()
  returns void as
$function$
    begin

        delete from ggircs.permit;
        insert into ggircs.permit(id, ghgr_import_id, report_id, facility_id,  path_context, issuing_agency, issuing_dept_agency_program, permit_number)

        select _permit.id, _permit.ghgr_import_id, _report.id, _facility.id,  _permit.path_context, _permit.issuing_agency, _permit.issuing_dept_agency_program, _permit.permit_number

        from ggircs_swrs.permit as _permit

        inner join ggircs_swrs.final_report as _final_report on _permit.ghgr_import_id = _final_report.ghgr_import_id
        -- FK Permit -> Report
        left join ggircs_swrs.report as _report
            on _permit.ghgr_import_id = _report.ghgr_import_id
        -- FK Permit -> Facility
        left join ggircs_swrs.facility as _facility
            on _permit.ghgr_import_id = _facility.ghgr_import_id;

    end
$function$ language plpgsql volatile;

commit;