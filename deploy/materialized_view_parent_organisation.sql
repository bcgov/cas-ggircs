-- Deploy ggircs:materialized_view_parent_organisation to pg
-- requires: table_ghgr_import

begin;

create materialized view ggircs_swrs.parent_organisation as (
  with x as (
    select _ghgr_import.xml_file as source_xml,
           _ghgr_import.id         as ghgr_import_id
    from ggircs_swrs.ghgr_import as _ghgr_import
    order by ghgr_import_id asc
  )
  select ghgr_import_id, parent_organisation_details.*
  from x,
       xmltable(
           '//ParentOrganisation'
           passing source_xml
           columns
                swrs_organisation_id numeric(1000,0) path './ancestor-or-self::ParentOrganisation/ancestor::ReportData/ReportDetails/OrganisationId[normalize-space(.)]',
                path_context varchar(1000) path 'name(./ancestor::VerifyTombstone|./ancestor::RegistrationData)',
                parent_organisation_idx integer path 'string(count(./ancestor-or-self::ParentOrganisation/preceding-sibling::ParentOrganisation))' not null,
                percentage_owned numeric(1000,2) path './Details/PercentageOwned',
                french_trade_name varchar(1000) path './Details/FrenchTradeName',
                english_trade_name varchar(1000) path './Details/EnglishTradeName',
                duns varchar(1000) path './Details/DUNSNumber',
                business_legal_name varchar(1000) path './Details/BusinessLegalName|./LegalName',
                website varchar(1000) path './Details/WebSite'

         ) as parent_organisation_details
) with no data;

create unique index ggircs_parent_organisation_primary_key
    on ggircs_swrs.parent_organisation (ghgr_import_id, swrs_organisation_id, path_context, parent_organisation_idx);

comment on materialized view ggircs_swrs.parent_organisation is 'The materialized view housing parent organisation information';
comment on column ggircs_swrs.parent_organisation.ghgr_import_id is 'The foreign key reference to ggircs_swrs.ghgr_import';
comment on column ggircs_swrs.parent_organisation.ghgr_import_id is 'The organisation id according to the swrs report fk to ggircs_swrs.organisation';

commit;

