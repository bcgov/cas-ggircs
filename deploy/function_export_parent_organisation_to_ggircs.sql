-- Deploy ggircs:function_export_parent_organisation_to_ggircs to pg
-- requires: materialized_view_report
-- requires: materialized_view_organisation
-- requires: materialized_view_final_report
-- requires: materialized_view_parent_organisation

begin;

create or replace function ggircs_swrs.export_parent_organisation_to_ggircs()
  returns void as
$function$
    begin

        delete from ggircs.parent_organisation;
        insert into ggircs.parent_organisation (id, ghgr_import_id, report_id, organisation_id, path_context, percentage_owned, french_trade_name, english_trade_name,
                                                duns, business_legal_name, website)

        select _parent_organisation.id, _parent_organisation.ghgr_import_id, _report.id, _organisation.id, _parent_organisation.path_context, _parent_organisation.percentage_owned,
               _parent_organisation.french_trade_name, _parent_organisation.english_trade_name, _parent_organisation.duns, _parent_organisation.business_legal_name, _parent_organisation.website

        from ggircs_swrs.parent_organisation as _parent_organisation

        inner join ggircs_swrs.final_report as _final_report on _parent_organisation.ghgr_import_id = _final_report.ghgr_import_id
        --FK Parent Organisation -> Organisation
        left join ggircs_swrs.organisation as _organisation
          on _parent_organisation.ghgr_import_id = _organisation.ghgr_import_id
        -- FK Parent Organisation -> Report
        left join ggircs_swrs.report as _report
          on _parent_organisation.ghgr_import_id = _report.ghgr_import_id;

    end
$function$ language plpgsql volatile;

commit;
