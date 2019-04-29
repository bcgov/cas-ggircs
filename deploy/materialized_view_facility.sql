-- Deploy ggircs:materialized_view_facility to pg
-- requires: schema_ggircs_swrs
-- requires: table_ghgr_import
-- requires: materialized_view_report

begin;

create materialized view ggircs_private.facility as (
  -- Select the XML reports from raw_reports table and get the Facility ID and Report ID from reports table
  with x as (
    select _report.id               as report_id,
           _report.swrs_report_id   as swrs_report_id,
           _raw_report.xml_file     as source_xml,
           _raw_report.imported_at  as imported_at,
           _report.swrs_facility_id as swrs_facility_id
    from ggircs_private.report as _report
           inner join ggircs_private.raw_report as _raw_report
                      on _report.ghgr_id = _raw_report.id
    order by _report.id desc
  )
       -- Walk the XML to extract facility details
       -- coalesce results from VerifyTombstone (vt) and RegistrationData (rd)

  select row_number() over (order by report_id asc)                                     as id,
         x.report_id,
         x.swrs_facility_id,
         coalesce(vt_facility_details.facility_name, rd_facility_details.facility_name) as name,
         rd_facility_details.facility_type,
         coalesce(vt_facility_details.relationship_type,
                  rd_facility_details.relationship_type)                                as relationship_type,
         coalesce(vt_facility_details.portability_indicator,
                  rd_facility_details.portability_indicator)                            as portability_indicator,
         coalesce(vt_facility_details.status, rd_facility_details.status)               as status,
         coalesce(vt_facility_details.latitude, rd_facility_details.latitude)           as latitude,
         coalesce(vt_facility_details.longitude, rd_facility_details.longitude)         as longitude,
         row_number() over (
           partition by swrs_facility_id
           order by
             imported_at desc,
             x.report_id desc
           )                                                                            as swrs_facility_history_id

  from x,
       xmltable(
           '/ReportData'
           passing source_xml
           columns
             facility_name text path './RegistrationData/Facility/Details/FacilityName',
             facility_type text path './ReportDetails/FacilityType', -- null
             relationship_type text path './RegistrationData/Facility/Details/RelationshipType',
             portability_indicator text path './RegistrationData/Facility/Details/PortabilityIndicator',
             status text path './RegistrationData/Facility/Details/Status',
             latitude text path './RegistrationData/Facility/Address/GeographicAddress/Latitude',
             longitude text path './RegistrationData/Facility/Address/GeographicAddress/Longitude'
         ) as rd_facility_details,

       xmltable(
           '/ReportData'
           passing source_xml
           columns
             facility_name text path './VerifyTombstone/Facility/Details/FacilityName',
             relationship_type text path './VerifyTombstone/Facility/Details/RelationshipType',
             portability_indicator text path './VerifyTombstone/Facility/Details/PortabilityIndicator',
             status text path './VerifyTombstone/Facility/Details/Status',
             latitude text path './VerifyTombstone/Facility/Address/GeographicalAddress/Latitude',
             longitude text path './VerifyTombstone/Facility/Address/GeographicalAddress/Longitude'
         ) as vt_facility_details
);

create unique index ggircs_facility_primary_key on ggircs_private.facility (id);
create index ggircs_facility_history on ggircs_private.facility (swrs_facility_history_id);

commit;
