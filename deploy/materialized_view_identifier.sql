-- Deploy ggircs:materialized_view_identifier to pg
-- requires: materialized_view_report

begin;

create materialized view ggircs_swrs.identifier as (
  with reportXMLs as (
    select _report.source_xml as source_xml,
           _report.id         as report_id,
           _report.swrs_report_id,
           _report.imported_at,
           _report.swrs_facility_id,
           _facility.id       as facility_id
    from ggircs_swrs.report as _report
           inner join ggircs_swrs.facility as _facility on _report.id = _facility.report_id
    order by _report.id asc
  )
  select row_number() over (order by report_id asc) as id,
         report_id,
         swrs_report_id,
         facility_id,
         swrs_facility_id,
         identifier_type,
         identifier_value,
         -- imported_at,
         row_number() over (
           partition by swrs_facility_id, identifier_type
           order by
             report_id desc,
             identifier_value desc
           ) as swrs_identifier_history_id
  from reportXMLs,
       xmltable(
           '/ReportData/RegistrationData/Facility/Identifiers/IdentifierList/Identifier/IdentifierValue[normalize-space(.)]'
           passing reportXMLs.source_xml
           columns
             identifier_type varchar(1000) path './../IdentifierType' NOT NULL,
             identifier_value varchar(1000) path '.' NOT NULL
         )
) with no data;

create unique index ggircs_identifier_primary_key on ggircs_swrs.identifier (id);
create index ggircs_swrs_identifier_history on ggircs_swrs.identifier (swrs_identifier_history_id);

comment on materialized view ggircs_swrs.identifier is 'The materialized view housing information regarding identifiers';
comment on column ggircs_swrs.identifier.id is 'The primary key for ggircs_swrs.identifier';
comment on column ggircs_swrs.identifier.swrs_report_id is 'The swrs report id';
comment on column ggircs_swrs.identifier.report_id is 'The foreign key referencing the ggrics_swrs.report Primary Key';
comment on column ggircs_swrs.identifier.facility_id is 'The foreign key referencing the ggircs_swrs.facility Primary Key';
comment on column ggircs_swrs.identifier.swrs_facility_id is 'The swrs facility id';
comment on column ggircs_swrs.identifier.identifier_type is 'The type of identifier';
comment on column ggircs_swrs.identifier.identifier_value is 'The value of the identifier';
comment on column ggircs_swrs.identifier.swrs_identifier_history_id is 'The id denoting identifier history (1=latest)';


commit;
