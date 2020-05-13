-- Deploy ggircs:materialized_view_identifier to pg
-- requires: table_eccc_xml_file

begin;

create materialized view swrs_transform.identifier as (
  select
         row_number() over () as id, id as eccc_xml_file_id,
         swrs_identifier.swrs_facility_id,
         swrs_identifier.path_context,
         swrs_identifier.identifier_idx,
         swrs_identifier.identifier_type,
         -- coalesce needed for getting the bcghgid value from ProgramID if exists, otherwise from IdentifierValue
         coalesce(swrs_identifier.identifier_value, swrs_identifier.idv2) as identifier_value
  from swrs_extract.eccc_xml_file,
       xmltable(
           '//Identifier'
           passing xml_file
           columns
             swrs_facility_id integer path '//FacilityId[normalize-space(.)]' not null,
             path_context varchar(1000) path 'name(./ancestor::VerifyTombstone|./ancestor::RegistrationData)',
             identifier_idx integer path 'string(count(./ancestor-or-self::Identifier/preceding-sibling::Identifier))' not null,
             identifier_type varchar(1000) path './IdentifierType[normalize-space(.)]' not null,
             identifier_value varchar(1000) path '(./IdentifierType[not(text() = "BCGHGID")]/following-sibling::IdentifierValue[normalize-space(.)]|./ancestor::RegistrationData/parent::*/OperationalWorkerReport/ProgramID)[1]',
             idv2 varchar(1000) path './IdentifierValue'
         ) as swrs_identifier
  order by eccc_xml_file_id
) with no data;

create unique index ggircs_identifier_primary_key on swrs_transform.identifier (eccc_xml_file_id, swrs_facility_id, path_context, identifier_idx);

comment on materialized view swrs_transform.identifier is 'The materialized view housing information regarding identifiers';
comment on column swrs_transform.identifier.id is 'A generated index used for keying in the ggircs schema';
comment on column swrs_transform.identifier.eccc_xml_file_id is 'The foreign key referencing ggrics_swrs.eccc_xml_file.id';
comment on column swrs_transform.identifier.swrs_facility_id is 'The swrs facility id';
comment on column swrs_transform.identifier.path_context is 'The path context to the Identifier node (from VerifyTombstone or RegistrationDetails)';
comment on column swrs_transform.identifier.identifier_idx is 'The number of preceding Identifier siblings before this Identifier';
comment on column swrs_transform.identifier.identifier_type is 'The type of identifier';
comment on column swrs_transform.identifier.identifier_value is 'The value of the identifier';

commit;
