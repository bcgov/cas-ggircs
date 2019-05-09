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
             swrs_facility_id numeric(1000,0) path '//FacilityId[normalize-space(.)]' not null,
             path_context varchar(1000) path 'name(./ancestor::VerifyTombstone|./ancestor::RegistrationData)',
             identifier_idx integer path 'string(count(./ancestor-or-self::Identifier/preceding-sibling::Identifier))' not null,
             identifier_type varchar(1000) path './IdentifierType[normalize-space(.)]' not null,
             identifier_value varchar(1000) path './IdentifierValue[normalize-space(.)]'
         ) as swrs_identifier
  order by ghgr_import_id
) with no data;

create unique index ggircs_identifier_primary_key on ggircs_swrs.identifier (ghgr_import_id, swrs_facility_id, path_context, identifier_idx);

comment on materialized view ggircs_swrs.identifier is 'The materialized view housing information regarding identifiers';
comment on column ggircs_swrs.identifier.ghgr_import_id is 'The foreign key referencing ggrics_swrs.ghgr_import.id';
comment on column ggircs_swrs.identifier.swrs_facility_id is 'The swrs facility id';
comment on column ggircs_swrs.identifier.path_context is 'The path context to the Identifier node (from VerifyTombstone or RegistrationDetails)';
comment on column ggircs_swrs.identifier.identifier_idx is 'The number of preceding Identifier siblings before this Identifier';
comment on column ggircs_swrs.identifier.identifier_type is 'The type of identifier';
comment on column ggircs_swrs.identifier.identifier_value is 'The value of the identifier';

commit;
