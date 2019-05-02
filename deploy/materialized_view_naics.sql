-- Deploy ggircs:materialized_view_naics to pg
-- requires: table_ghgr_import

begin;

create materialized view ggircs_swrs.naics as (
  with x as (
    select _ghgr_import.xml_file as source_xml,
           _ghgr_import.id         as ghgr_id,
           _ghgr_import.imported_at
    from ggircs_swrs.ghgr_import as _ghgr_import
    order by _ghgr_import.id asc
  )
  select row_number() over (order by ghgr_id asc) as id,
         ghgr_id,
         naics.*,
         row_number() over (
           partition by swrs_facility_id
           order by
             ghgr_id desc,
             naics_priority desc,
             naics_code desc
           ) as swrs_naics_history_id
  from x,
       xmltable(
           '/ReportData'
           passing x.source_xml
           columns
             swrs_facility_id numeric(1000,0) path '//descendant-or-self::FacilityId',
             naics_classification varchar(1000) path '//descendant-or-self::NAICSClassification[normalize-space(.)]',
             naics_code varchar(1000) path '//descendant-or-self::Code[normalize-space(.)]',
             naics_priority varchar(1000) path '//descendant-or-self:: NaicsPriority[normalize-space(.)][contains(., "Primary")]|NAICSCode/ActivityPercentage[normalize-space(.)][contains(., "100")]'
         ) as naics
) with no data;
create unique index ggircs_naics_primary_key on ggircs_swrs.naics (id);
create index ggircs_swrs_naics_history on ggircs_swrs.naics (swrs_naics_history_id);

comment on materialized view ggircs_swrs.naics is 'The materialized view housing all report data pertaining to naics';
comment on column ggircs_swrs.naics.id is 'The primary key for the materialized view';
comment on column ggircs_swrs.naics.ghgr_id is 'The ghgr_import id (foreign key)';
comment on column ggircs_swrs.naics.swrs_facility_id is 'The reporting facility swrs id';

comment on column ggircs_swrs.naics.naics_classification is 'The naics classification';
comment on column ggircs_swrs.naics.naics_code is 'The naics code';
comment on column ggircs_swrs.naics.naics_priority is 'The naics priority';
comment on column ggircs_swrs.naics.swrs_naics_history_id is 'The id denoting the history (1=latest)';


commit;
