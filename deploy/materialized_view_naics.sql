-- Deploy ggircs:materialized_view_naics to pg
-- requires: table_ghgr_import

begin;

create materialized view ggircs_swrs.naics as (
  with x as (
    select _ghgr_import.xml_file as source_xml,
           _ghgr_import.id         as ghgr_import_id,
           _ghgr_import.imported_at
    from ggircs_swrs.ghgr_import as _ghgr_import
    order by _ghgr_import.id asc
  )
  select
         ghgr_import_id,
         naics.*
  from x,
       xmltable(
           '//NAICSCode'
           passing x.source_xml
           columns
             swrs_facility_id numeric(1000,0) path '//FacilityId[normalize-space(.)]',
             path_context varchar(1000) path 'name(./ancestor::VerifyTombstone|./ancestor::RegistrationData)',
             naics_code_idx integer path 'string(count(./preceding-sibling::NAICSCode))' not null,
             naics_classification varchar(1000) path './NAICSClassification[normalize-space(.)]',
             naics_code varchar(1000) path './Code[normalize-space(.)]',
             naics_priority varchar(1000) path './NaicsPriority[normalize-space(.)][contains(., "Primary")]|./ActivityPercentage[normalize-space(.)][contains(., "100")]'
         ) as naics
) with no data;
create unique index ggircs_naics_primary_key on ggircs_swrs.naics (ghgr_import_id, swrs_facility_id, path_context, naics_code_idx);

comment on materialized view ggircs_swrs.naics is 'The materialized view housing all report data pertaining to naics';
comment on column ggircs_swrs.naics.ghgr_import_id is 'The foreign key reference to ggircs_swrs.ghgr_import.id';
comment on column ggircs_swrs.naics.swrs_facility_id is 'The reporting facility swrs id';
comment on column ggircs_swrs.naics.naics_classification is 'The naics classification';
comment on column ggircs_swrs.naics.naics_code is 'The naics code';
comment on column ggircs_swrs.naics.naics_priority is 'The naics priority';

commit;
