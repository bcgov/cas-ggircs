-- Deploy ggircs:materialized_view_organisation to pg
-- requires: schema_ggircs_swrs
-- requires: table_ghgr_import

begin;

create materialized view ggircs_swrs_transform.organisation as (
  select
         row_number() over () as id,
         id as ghgr_import_id,
         report_details.swrs_organisation_id,
         coalesce(vt_business_legal_name, rd_business_legal_name)       as business_legal_name,
         coalesce(vt_english_trade_name, rd_english_trade_name)         as english_trade_name,
         coalesce(vt_french_trade_name, rd_french_trade_name)           as french_trade_name,
         coalesce(vt_cra_business_number, rd_cra_business_number)       as cra_business_number,
         translate(coalesce(vt_duns, rd_duns), '-', '')::varchar(1000)  as duns,
         coalesce(vt_web_site, rd_web_site)                             as website
  from ggircs_swrs_extract.ghgr_import,
       xmltable(
           '/ReportData/ReportDetails'
           passing xml_file
           columns
             swrs_organisation_id integer not null path 'OrganisationId[normalize-space(.)]'
         ) as report_details,
       xmltable(
           '/ReportData'
           passing xml_file
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
           passing xml_file --/ReportData/VerifyTombstone/Organisation/Details/DUNSNumber
           columns
             vt_business_legal_name varchar(1000) path './VerifyTombstone/Organisation/Details/BusinessLegalName',
             vt_english_trade_name varchar(1000) path './VerifyTombstone/Organisation/Details/EnglishTradeName',
             vt_french_trade_name varchar(1000) path './VerifyTombstone/Organisation/Details/FrenchTradeName',
             vt_cra_business_number varchar(1000) path './VerifyTombstone/Organisation/Details/CRABusinessNumber',
             vt_duns varchar(1000) path './VerifyTombstone/Organisation/Details/DUNSNumber',
             vt_web_site varchar(1000) path './VerifyTombstone/Organisation/Details/WebSite'
         ) as vt_organisation_details
) with no data;
create unique index ggircs_organisation_primary_key on ggircs_swrs_transform.organisation (ghgr_import_id);

comment on materialized view ggircs_swrs_transform.organisation is 'the materialized view housing all report data pertaining to the reporting organisation';
comment on column ggircs_swrs_transform.organisation.id is 'A generated index used for keying in the ggircs schema';
comment on column ggircs_swrs_transform.organisation.ghgr_import_id is 'The internal reference to the file imported from ghgr';
comment on column ggircs_swrs_transform.organisation.swrs_organisation_id is 'The reporting organisation swrs id';
comment on column ggircs_swrs_transform.organisation.business_legal_name is 'The legal business name of the reporting organisation';
comment on column ggircs_swrs_transform.organisation.english_trade_name is 'The trade name in english';
comment on column ggircs_swrs_transform.organisation.french_trade_name is 'The trade name in french';
comment on column ggircs_swrs_transform.organisation.cra_business_number is 'The organisation business number according to cra';
comment on column ggircs_swrs_transform.organisation.duns is 'The organisation duns number';
comment on column ggircs_swrs_transform.organisation.website is 'The organisation website address';

commit;
