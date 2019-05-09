-- Deploy ggircs:materialized_view_identifier to pg
-- requires: table_ghgr_import

begin;

create materialized view ggircs_swrs.identifier as (
  with import_xml as (
    select _ghgr_import.xml_file as source_xml,
           _ghgr_import.id         as ghgr_import_id,
           _ghgr_import.imported_at
    from ggircs_swrs.ghgr_import as _ghgr_import
    order by _ghgr_import.id asc
  )
  select
         ghgr_import_id,
         swrs_identifier.*
  from import_xml,
       xmltable(
           '//Identifier'
           passing import_xml.source_xml
           columns
             swrs_facility_id numeric(1000,0) not null path '//FacilityId[normalize-space(.)]',
             identifier_type varchar(1000) not null path './IdentifierType[normalize-space(.)]',
             identifier_value varchar(1000) not null path './IdentifierValue[normalize-space(.)]'
         ) as swrs_identifier
) with no data;

create unique index ggircs_identifier_primary_key on ggircs_swrs.identifier (ghgr_import_id);
create index ggircs_swrs_identifier_history on ggircs_swrs.identifier (swrs_identifier_history_id);

comment on materialized view ggircs_swrs.identifier is 'The materialized view housing information regarding identifiers';
comment on column ggircs_swrs.identifier.ghgr_import_id is 'The foreign key referencing ggrics_swrs.ghgr_import.id';
comment on column ggircs_swrs.identifier.swrs_facility_id is 'The swrs facility id';
comment on column ggircs_swrs.identifier.identifier_type is 'The type of identifier';
comment on column ggircs_swrs.identifier.identifier_value is 'The value of the identifier';

commit;
