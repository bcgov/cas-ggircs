-- Deploy ggircs:function_load_identifier to pg
-- requires: materialized_view_report
-- requires: materialized_view_facility
-- requires: materialized_view_final_report
-- requires: materialized_view_identifier

begin;

create or replace function ggircs_swrs_transform.load_identifier()
  returns void as
$function$
    begin

        delete from ggircs_swrs_load.identifier;
        insert into ggircs_swrs_load.identifier(id, ghgr_import_id, facility_bcghgid_id, facility_id,  report_id, swrs_facility_id, path_context, identifier_type, identifier_value)

        select _identifier.id, _identifier.ghgr_import_id, _facility_bcghgid.id, _facility.id,  _report.id, _identifier.swrs_facility_id, _identifier.path_context, _identifier.identifier_type, _identifier.identifier_value

        from ggircs_swrs_transform.identifier as _identifier

        inner join ggircs_swrs_transform.final_report as _final_report on _identifier.ghgr_import_id = _final_report.ghgr_import_id
        -- FK Identifier -> Facility
        left join ggircs_swrs_transform.facility as _facility
          on _identifier.ghgr_import_id = _facility.ghgr_import_id
        -- FK Identifier -> Report
        left join ggircs_swrs_transform.report as _report
          on _identifier.ghgr_import_id = _report.ghgr_import_id
        left join ggircs_swrs_load.facility as _facility_bcghgid
          on _identifier.ghgr_import_id = _facility_bcghgid.ghgr_import_id
          and (((_identifier.path_context = 'RegistrationData'
                 and _identifier.identifier_type = 'BCGHGID'
                 and _identifier.identifier_value is not null
                 and _identifier.identifier_value != '' )

                   and (select id from ggircs_swrs_transform.identifier as __identifier
                      where __identifier.ghgr_import_id = _facility_bcghgid.ghgr_import_id
                      and __identifier.path_context = 'VerifyTombstone'
                      and __identifier.identifier_type = 'BCGHGID'
                      and __identifier.identifier_value is not null
                      and __identifier.identifier_value != '') is null)
              or (_identifier.path_context = 'VerifyTombstone'
                 and _identifier.identifier_type = 'BCGHGID'
                 and _identifier.identifier_value is not null
                 and _identifier.identifier_value != '' ));

    end
$function$ language plpgsql volatile;

commit;
