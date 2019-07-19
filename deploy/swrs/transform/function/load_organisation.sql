-- Deploy ggircs:function_load_organisation to pg
-- requires: materialized_view_report
-- requires: materialized_view_organisation
-- requires: materialized_view_final_report

begin;

create or replace function ggircs_swrs_transform.load_organisation()
  returns void as
$function$
    begin

        delete from ggircs_swrs_load.organisation;
        insert into ggircs_swrs_load.organisation (id, ghgr_import_id, report_id, swrs_organisation_id, business_legal_name, english_trade_name, french_trade_name, cra_business_number, duns, website)

        select _organisation.id, _organisation.ghgr_import_id, _report.id, _organisation.swrs_organisation_id, _organisation.business_legal_name,
               _organisation.english_trade_name, _organisation.french_trade_name, _organisation.cra_business_number, _organisation.duns, _organisation.website

        from ggircs_swrs_transform.organisation as _organisation

        inner join ggircs_swrs_transform.final_report as _final_report on _organisation.ghgr_import_id = _final_report.ghgr_import_id
        --FK Organisation -> Report
        left join ggircs_swrs_transform.report as _report
          on _organisation.ghgr_import_id = _report.ghgr_import_id;

    end
$function$ language plpgsql volatile;

commit;
