-- Deploy ggircs:materialized_view_identifier to pg
-- requires: table_ghgr_import

begin;

create materialized view ggircs_swrs.identifier as (
  with import_xml as (
    select _ghgr_import.xml_file as source_xml,
           _ghgr_import.id         as ghgr_id,
           _ghgr_import.imported_at
    from ggircs_swrs.ghgr_import as _ghgr_import
    order by _ghgr_import.id asc
  )
  select row_number() over (order by ghgr_id asc) as id,
         ghgr_id,
         report_details.swrs_report_id,
         report_details.swrs_facility_id,
         identifier_type,
         identifier_value,
         -- imported_at,
         row_number() over (
           partition by swrs_facility_id, identifier_type
           order by
             ghgr_id desc,
             identifier_value desc
           ) as swrs_identifier_history_id
  from import_xml,
       xmltable(
           '/ReportData'
           passing import_xml.source_xml
           columns
           swrs_report_id numeric(1000,0) path '//descendant-or-self::ReportID[normalize-space(.)]' NOT NULL,
           swrs_facility_id numeric(1000,0) path '//descendant-or-self::FacilityId[normalize-space(.)]' NOT NULL
        ) as report_details,
       xmltable(
           '/ReportData//descendant-or-self::Identifier'
           passing import_xml.source_xml
           columns
             -- _report.swrs_report_id,
             -- _report.swrs_facility_id,
             identifier_type varchar(1000) path '//descendant-or-self::IdentifierType[normalize-space(.)]' NOT NULL,
             identifier_value varchar(1000) path '//descendant-or-self::IdentifierValue[normalize-space(.)]' NOT NULL
         )
) with no data;

create unique index ggircs_identifier_primary_key on ggircs_swrs.identifier (id);
create index ggircs_swrs_identifier_history on ggircs_swrs.identifier (swrs_identifier_history_id);

comment on materialized view ggircs_swrs.identifier is 'The materialized view housing information regarding identifiers';
comment on column ggircs_swrs.identifier.id is 'The primary key for ggircs_swrs.identifier';
comment on column ggircs_swrs.identifier.swrs_report_id is 'The swrs report id';
comment on column ggircs_swrs.identifier.ghgr_id is 'The foreign key referencing the ggrics_swrs.report Primary Key';
comment on column ggircs_swrs.identifier.swrs_facility_id is 'The swrs facility id';
comment on column ggircs_swrs.identifier.identifier_type is 'The type of identifier';
comment on column ggircs_swrs.identifier.identifier_value is 'The value of the identifier';
comment on column ggircs_swrs.identifier.swrs_identifier_history_id is 'The id denoting identifier history (1=latest)';


commit;
