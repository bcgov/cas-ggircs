-- Deploy ggircs:function_load_parent_organisation to pg
-- requires: materialized_view_report
-- requires: materialized_view_organisation
-- requires: materialized_view_final_report
-- requires: materialized_view_parent_organisation

begin;

create or replace function swrs_transform.load_parent_organisation()
  returns void as
$function$
    begin

        delete from swrs_load.parent_organisation;
        insert into swrs_load.parent_organisation (id, eccc_xml_file_id, report_id, organisation_id, path_context, percentage_owned, french_trade_name, english_trade_name,
                                                duns, business_legal_name, website)

        select _parent_organisation.id, _parent_organisation.eccc_xml_file_id, _report.id, _organisation.id, _parent_organisation.path_context, _parent_organisation.percentage_owned,
               _parent_organisation.french_trade_name, _parent_organisation.english_trade_name, _parent_organisation.duns, _parent_organisation.business_legal_name, _parent_organisation.website

        from swrs_transform.parent_organisation as _parent_organisation

        inner join swrs_transform.final_report as _final_report on _parent_organisation.eccc_xml_file_id = _final_report.eccc_xml_file_id
        --FK Parent Organisation -> Organisation
        left join swrs_transform.organisation as _organisation
          on _parent_organisation.eccc_xml_file_id = _organisation.eccc_xml_file_id
        -- FK Parent Organisation -> Report
        left join swrs_transform.report as _report
          on _parent_organisation.eccc_xml_file_id = _report.eccc_xml_file_id;

    end
$function$ language plpgsql volatile;

commit;
