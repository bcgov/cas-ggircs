-- Deploy ggircs:materialized_view_facility to pg
-- requires: table_eccc_xml_file

begin;

drop materialized view if exists swrs_transform.facility;
create materialized view swrs_transform.facility as (
  -- Select the XML reports from eccc_xml_files table and get the Facility ID and Report ID from reports table
  -- Walk the XML to extract facility details
  -- coalesce results from VerifyTombstone (vt) and RegistrationData (rd)
  select row_number() over () as id,
         id as eccc_xml_file_id,
         rd_facility_details.swrs_facility_id,
         coalesce(vt_facility_details.facility_name, rd_facility_details.facility_name) as facility_name,
         rd_facility_details.facility_type,
         coalesce(vt_facility_details.relationship_type,
                  rd_facility_details.relationship_type)                                as relationship_type,
         coalesce(vt_facility_details.portability_indicator,
                  rd_facility_details.portability_indicator)                            as portability_indicator,
         coalesce(vt_facility_details.status, rd_facility_details.status)               as status,
         substring(coalesce(vt_facility_details.latitude, rd_facility_details.latitude) from '-*[0-9]+\.*[0-9]+')::numeric   as latitude,
         substring(coalesce(vt_facility_details.longitude, rd_facility_details.longitude) from '-*[0-9]+\.*[0-9]+')::numeric as longitude

  from swrs_extract.eccc_xml_file,
       xmltable(
           '/ReportData'
           passing xml_file
           columns
             swrs_facility_id integer path '//FacilityId',
             facility_name varchar(1000) path './RegistrationData/Facility/Details/FacilityName',
             facility_type varchar(1000) path './ReportDetails/FacilityType', -- null
             relationship_type varchar(1000) path './RegistrationData/Facility/Details/RelationshipType',
             portability_indicator varchar(1000) path './RegistrationData/Facility/Details/PortabilityIndicator',
             status varchar(1000) path './RegistrationData/Facility/Details/Status',
             latitude varchar(1000) path './RegistrationData/Facility/Address/GeographicAddress/Latitude',
             longitude varchar(1000) path './RegistrationData/Facility/Address/GeographicAddress/Longitude'
         ) as rd_facility_details,

       xmltable(
           '/ReportData'
           passing xml_file
           columns
             facility_name varchar(1000) path './VerifyTombstone/Facility/Details/FacilityName',
             relationship_type varchar(1000) path './VerifyTombstone/Facility/Details/RelationshipType',
             portability_indicator varchar(1000) path './VerifyTombstone/Facility/Details/PortabilityIndicator',
             status varchar(1000) path './VerifyTombstone/Facility/Details/Status',
             latitude varchar(1000) path './VerifyTombstone/Facility/Address/GeographicalAddress/Latitude',
             longitude varchar(1000) path './VerifyTombstone/Facility/Address/GeographicalAddress/Longitude'
         ) as vt_facility_details
  order by eccc_xml_file_id desc
) with no data;

create unique index ggircs_facility_primary_key on swrs_transform.facility (eccc_xml_file_id);

comment on materialized view swrs_transform.facility is 'the materialized view housing all report data pertaining to the reporting facility';
comment on column swrs_transform.facility.id is 'A generated index used for keying in the ggircs schema';
comment on column swrs_transform.facility.eccc_xml_file_id is 'The primary key for the materialized view';
comment on column swrs_transform.facility.swrs_facility_id is 'The reporting facility swrs id';
comment on column swrs_transform.facility.facility_name is 'The name of the reporting facility';
comment on column swrs_transform.facility.facility_type is 'The type of the reporting facility';
comment on column swrs_transform.facility.relationship_type is 'The type of relationship';
comment on column swrs_transform.facility.portability_indicator is 'The portability indicator';
comment on column swrs_transform.facility.status is 'The status of the facility';
comment on column swrs_transform.facility.latitude is 'The latitude of the reporting facility';
comment on column swrs_transform.facility.longitude is 'The longitude of the reporting facility';

commit;
