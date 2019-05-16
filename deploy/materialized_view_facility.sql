-- Deploy ggircs:materialized_view_facility to pg
-- requires: table_ghgr_import

begin;

create materialized view ggircs_swrs.facility as (
  -- Select the XML reports from ghgr_imports table and get the Facility ID and Report ID from reports table
  with x as (
    select _ghgr_import.id               as ghgr_import_id,
           _ghgr_import.xml_file     as source_xml,
           _ghgr_import.imported_at  as imported_at
    from ggircs_swrs.ghgr_import as _ghgr_import
    order by _ghgr_import.id desc
  )
       -- Walk the XML to extract facility details
       -- coalesce results from VerifyTombstone (vt) and RegistrationData (rd)

  select x.ghgr_import_id,
         rd_facility_details.swrs_facility_id,
         coalesce(vt_facility_details.facility_name, rd_facility_details.facility_name) as facility_name,
         rd_facility_details.facility_type,
         coalesce(vt_facility_details.relationship_type,
                  rd_facility_details.relationship_type)                                as relationship_type,
         coalesce(vt_facility_details.portability_indicator,
                  rd_facility_details.portability_indicator)                            as portability_indicator,
         coalesce(vt_facility_details.status, rd_facility_details.status)               as status,
         coalesce(vt_facility_details.latitude, rd_facility_details.latitude)           as latitude,
         coalesce(vt_facility_details.longitude, rd_facility_details.longitude)         as longitude

  from x,
       xmltable(
           '/ReportData'
           passing source_xml
           columns
             swrs_facility_id integer path '//FacilityId',
             facility_name varchar(1000) path './RegistrationData/Facility/Details/FacilityName',
             facility_type varchar(1000) path './ReportDetails/FacilityType', -- null
             relationship_type varchar(1000) path './RegistrationData/Facility/Details/RelationshipType',
             portability_indicator varchar(1000) path './RegistrationData/Facility/Details/PortabilityIndicator',
             status varchar(1000) path './RegistrationData/Facility/Details/Status',
             latitude numeric path './RegistrationData/Facility/Address/GeographicAddress/Latitude',
             longitude numeric path './RegistrationData/Facility/Address/GeographicAddress/Longitude'
         ) as rd_facility_details,

       xmltable(
           '/ReportData'
           passing source_xml
           columns
             facility_name varchar(1000) path './VerifyTombstone/Facility/Details/FacilityName',
             relationship_type varchar(1000) path './VerifyTombstone/Facility/Details/RelationshipType',
             portability_indicator varchar(1000) path './VerifyTombstone/Facility/Details/PortabilityIndicator',
             status varchar(1000) path './VerifyTombstone/Facility/Details/Status',
             latitude numeric path './VerifyTombstone/Facility/Address/GeographicalAddress/Latitude',
             longitude numeric path './VerifyTombstone/Facility/Address/GeographicalAddress/Longitude'
         ) as vt_facility_details
  order by ghgr_import_id desc
) with no data;

create unique index ggircs_facility_primary_key on ggircs_swrs.facility (ghgr_import_id, swrs_facility_id);

comment on materialized view ggircs_swrs.facility is 'the materialized view housing all report data pertaining to the reporting facility';
comment on column ggircs_swrs.facility.ghgr_import_id is 'The primary key for the materialized view';
comment on column ggircs_swrs.facility.swrs_facility_id is 'The reporting facility swrs id';
comment on column ggircs_swrs.facility.facility_name is 'The name of the reporting facility';
comment on column ggircs_swrs.facility.facility_type is 'The type of the reporting facility';
comment on column ggircs_swrs.facility.relationship_type is 'The type of relationship';
comment on column ggircs_swrs.facility.portability_indicator is 'The portability indicator';
comment on column ggircs_swrs.facility.status is 'The status of the facility';
comment on column ggircs_swrs.facility.latitude is 'The latitude of the reporting facility';
comment on column ggircs_swrs.facility.longitude is 'The longitude of the reporting facility';

commit;
