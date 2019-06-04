-- Deploy ggircs:materialized_view_naics to pg
-- requires: table_ghgr_import

begin;

create materialized view ggircs_swrs.naics as (
  select
         row_number() over () as id,
         id as ghgr_import_id,
         naics.*
  from ggircs_swrs.ghgr_import,
       xmltable(
           '//NAICSCode'
           passing xml_file
           columns
             swrs_facility_id integer path '//FacilityId[normalize-space(.)]',
             path_context varchar(1000) path 'name(./ancestor::VerifyTombstone|./ancestor::RegistrationData)',
             naics_code_idx integer path 'string(count(./preceding-sibling::NAICSCode))' not null,
             naics_classification varchar(1000) path './NAICSClassification[normalize-space(.)]',
             naics_code integer path './Code[normalize-space(.)]',
             naics_priority varchar(1000) path './NaicsPriority[normalize-space(.)][contains(., "Primary")]|./ActivityPercentage[normalize-space(.)][contains(., "100")]'
         ) as naics
) with no data;
create unique index ggircs_naics_primary_key on ggircs_swrs.naics (ghgr_import_id, swrs_facility_id, path_context, naics_code_idx);

comment on materialized view ggircs_swrs.naics is 'The materialized view housing all report data pertaining to naics';
comment on column ggircs_swrs.naics.ghgr_import_id is 'The foreign key reference to ggircs_swrs.ghgr_import.id';
comment on column ggircs_swrs.naics.swrs_facility_id is 'The reporting facility swrs id, fk to ggircs_swrs.facility';
comment on column ggircs_swrs.naics.path_context is 'The ancestor context from which this naics code was selected (from VerifyTombstone or RegistrationData)';
comment on column ggircs_swrs.naics.naics_code_idx is 'The number of NAICSCode siblings preceding this NAICSCode node';
comment on column ggircs_swrs.naics.naics_classification is 'The naics classification';
comment on column ggircs_swrs.naics.naics_code is 'The naics code';
comment on column ggircs_swrs.naics.naics_priority is 'The naics priority';

commit;
