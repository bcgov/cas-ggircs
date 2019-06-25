-- Deploy ggircs:function_export_facility_to_ggircs to pg
-- requires: schema_ggircs_swrs
-- requires: materialized_view_facility

BEGIN;

create or replace function ggircs_swrs.export_facility_to_ggircs()
  returns void as
$function$

  begin

    delete from ggircs.facility;

    set constraints all deferred;

    with _final_lfo_facility as (
        -- facility.id will as the parent facility FK.
        -- swrs_organisation_id and reporting_period_duration are the join constraints
        select _facility.id, _organisation.swrs_organisation_id, _report.reporting_period_duration
        from ggircs_swrs.facility as _facility
        inner join ggircs_swrs.final_report as _final_report
            on _facility.ghgr_import_id = _final_report.ghgr_import_id
            and _facility.facility_type = 'LFO'
        left join ggircs_swrs.organisation as _organisation
            on _facility.ghgr_import_id = _organisation.ghgr_import_id
        left join ggircs_swrs.report as _report
            on _facility.ghgr_import_id = _report.ghgr_import_id
    )
    insert into ggircs.facility (id, ghgr_import_id, organisation_id, report_id, swrs_facility_id,
                                 parent_facility_id,
                                 facility_name, facility_type,
                                 relationship_type, portability_indicator, status,
                                 latitude, longitude)

    select _facility.id as fac_id, _facility.ghgr_import_id, _organisation.id as org_id, _report.id as rep_id,
           _facility.swrs_facility_id,
           _final_lfo_facility.id as lfo_id,
           _facility.facility_name, _facility.facility_type,
           _facility.relationship_type, _facility.portability_indicator,
           _facility.status, _facility.latitude, _facility.longitude

    from ggircs_swrs.facility as _facility
    inner join ggircs_swrs.final_report as _final_report on _facility.ghgr_import_id = _final_report.ghgr_import_id
    -- FK Facility -> Organisation
    left join ggircs_swrs.organisation as _organisation
        on _facility.ghgr_import_id = _organisation.ghgr_import_id
    -- FK Facility -> Report
    left join ggircs_swrs.report as _report
        on _facility.ghgr_import_id = _report.ghgr_import_id

    -- FK Single Facility -> LFO Facility
    left join _final_lfo_facility
        on _organisation.swrs_organisation_id = _final_lfo_facility.swrs_organisation_id
        and _report.reporting_period_duration = _final_lfo_facility.reporting_period_duration
        and (_facility.facility_type = 'IF_a' or _facility.facility_type = 'IF_b' or _facility.facility_type = 'L_c');

    end;

$function$ language plpgsql volatile;

COMMIT;

