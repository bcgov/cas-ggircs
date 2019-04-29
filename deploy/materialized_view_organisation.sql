-- Deploy ggircs:materialized_view_organisation to pg
-- requires: schema_ggircs_swrs
-- requires: materialized_view_report

begin;

create materialized view ggircs_swrs.organisation as (
  with x as (
    select _report.source_xml as source_xml,
           _report.id         as report_id,
           _report.swrs_report_id,
           _report.imported_at,
           _report.swrs_organisation_id
    from ggircs_swrs.report as _report
    order by _report.id desc
  )
  select row_number() over (order by report_id asc)               as id,
         report_id,
         swrs_organisation_id,
         coalesce(vt_business_legal_name, rd_business_legal_name) as business_legal_name,
         coalesce(vt_english_trade_name, rd_english_trade_name)   as english_trade_name,
         coalesce(vt_french_trade_name, rd_french_trade_name)     as french_trade_name,
         coalesce(vt_cra_business_number, rd_cra_business_number) as cra_business_number,
         coalesce(vt_duns, rd_duns)                               as duns,
         coalesce(vt_web_site, rd_web_site)                       as website,
         row_number() over (
           partition by swrs_organisation_id
           order by
             report_id desc,
             imported_at desc
           )                                                      as swrs_organisation_history_id
  from x,
       xmltable(
           '/ReportData'
           passing source_xml
           columns
             rd_business_legal_name varchar(1000) path './RegistrationData/Organisation/Details/BusinessLegalName',
             rd_english_trade_name varchar(1000) path './RegistrationData/Organisation/Details/EnglishTradeName',
             rd_french_trade_name varchar(1000) path './RegistrationData/Organisation/Details/FrenchTradeName',
             rd_cra_business_number varchar(1000) path './RegistrationData/Organisation/Details/CRABusinessNumber',
             rd_duns varchar(1000) path './RegistrationData/Organisation/Details/DUNSNumber',
             rd_web_site varchar(1000) path './RegistrationData/Organisation/Details/WebSite'
         ) as rd_organisation_details,

       xmltable(
           '/ReportData'
           passing source_xml --/ReportData/VerifyTombstone/Organisation/Details/DUNSNumber
           columns
             vt_business_legal_name varchar(1000) path './VerifyTombstone/Organisation/Details/BusinessLegalName',
             vt_english_trade_name varchar(1000) path './VerifyTombstone/Organisation/Details/EnglishTradeName',
             vt_french_trade_name varchar(1000) path './VerifyTombstone/Organisation/Details/FrenchTradeName',
             vt_cra_business_number varchar(1000) path './VerifyTombstone/Organisation/Details/CRABusinessNumber',
             vt_duns varchar(1000) path './VerifyTombstone/Organisation/Details/DUNSNumber',
             vt_web_site varchar(1000) path './VerifyTombstone/Organisation/Details/WebSite'
         ) as vt_organisation_details
);
create unique index ggircs_organisation_primary_key on ggircs_swrs.organisation (id);
create index ggircs_organisation_history on ggircs_swrs.organisation (swrs_organisation_history_id);

comment on materialized view ggircs_swrs.organisation is 'the materialized view housing all report data pertaining to the reporting organisation';
comment on column ggircs_swrs.organisation.id is 'The primary key for the materialized view';
comment on column ggircs_swrs.organisation.report_id is 'The swrs report id';
comment on column ggircs_swrs.organisation.swrs_organisation_id is 'The reporting organisation swrs id';
comment on column ggircs_swrs.organisation.business_legal_name is 'The legal business name of the reporting organisation';
comment on column ggircs_swrs.organisation.english_trade_name is 'The trade name in english';
comment on column ggircs_swrs.organisation.french_trade_name is 'The trade name in french';
comment on column ggircs_swrs.organisation.cra_business_number is 'The organisation business number according to cra';
comment on column ggircs_swrs.organisation.duns is 'The organisation duns number';
comment on column ggircs_swrs.organisation.website is 'The organisation website address';
comment on column ggircs_swrs.organisation.swrs_organisation_history_id is 'The id denoting the history attached to the organisation (1=latest)';

commit;
