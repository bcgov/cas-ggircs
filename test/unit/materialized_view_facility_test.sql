set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(32);

-- Test matview report exists in schema ggircs_swrs
select has_materialized_view('ggircs_swrs', 'facility', 'Materialized view facility exists');

-- Test column names in matview report exist and are correct
select has_column('ggircs_swrs', 'facility', 'id', 'ggircs_swrs.facility has column: id');
-- select has_column('ggircs_swrs', 'facility', 'report_id', 'ggircs_swrs.facility has column: report_id');
select has_column('ggircs_swrs', 'facility', 'swrs_facility_id', 'ggircs_swrs.facility has column: swrs_facility_id');
select has_column('ggircs_swrs', 'facility', 'facility_name', 'ggircs_swrs.facility has column: facility_name');
select has_column('ggircs_swrs', 'facility', 'facility_type', 'ggircs_swrs.facility has column: facility_type');
select has_column('ggircs_swrs', 'facility', 'relationship_type', 'ggircs_swrs.facility has column: relationship_type');
select has_column('ggircs_swrs', 'facility', 'portability_indicator', 'ggircs_swrs.facility has column: portability_indicator');
select has_column('ggircs_swrs', 'facility', 'status', 'ggircs_swrs.facility has column: status');
select has_column('ggircs_swrs', 'facility', 'latitude', 'ggircs_swrs.facility has column: latitude');
select has_column('ggircs_swrs', 'facility', 'longitude', 'ggircs_swrs.facility has column: longitude');
select has_column('ggircs_swrs', 'facility', 'swrs_facility_history_id', 'ggircs_swrs.facility has column: swrs_facility_history_id');

-- Test index names in matview report exist and are correct
select has_index('ggircs_swrs', 'facility', 'ggircs_facility_primary_key', 'ggircs_swrs.facility has index: ggircs_facility_primary_key');
select has_index('ggircs_swrs', 'facility', 'ggircs_swrs_facility_history', 'ggircs_swrs.facility has index: ggircs_swrs_facility_history');

-- Test unique indicies are defined unique
select index_is_unique('ggircs_swrs', 'facility', 'ggircs_facility_primary_key', 'Matview report index ggircs_facility_primary_key is unique');

-- Test columns in matview report have correct types
select col_type_is('ggircs_swrs', 'facility', 'id', 'bigint', 'ggircs_swrs.facility column id has type bigint');
-- select col_type_is('ggircs_swrs', 'facility', 'report_id', 'bigint', 'ggircs_swrs.facility column report_id has type bigint');
select col_type_is('ggircs_swrs', 'facility', 'swrs_facility_id', 'numeric(1000,0)', 'ggircs_swrs.facility column swrs_facility_id has type numeric');
select col_type_is('ggircs_swrs', 'facility', 'facility_name', 'character varying(1000)', 'ggircs_swrs.facility column facility_name has type varchar');
select col_type_is('ggircs_swrs', 'facility', 'relationship_type', 'character varying(1000)', 'ggircs_swrs.facility column relationship_type has type varchar');
select col_type_is('ggircs_swrs', 'facility', 'portability_indicator', 'character varying(1000)', 'ggircs_swrs.facility column portability_indicator has type varchar');
select col_type_is('ggircs_swrs', 'facility', 'status', 'character varying(1000)', 'ggircs_swrs.facility column status has type varchar');
select col_type_is('ggircs_swrs', 'facility', 'latitude', 'character varying(1000)', 'ggircs_swrs.facility column latitude has type varchar');
select col_type_is('ggircs_swrs', 'facility', 'longitude', 'character varying(1000)', 'ggircs_swrs.facility column longitude has type varchar');
select col_type_is('ggircs_swrs', 'facility', 'swrs_facility_history_id', 'bigint', 'ggircs_swrs.facility column swrs_facility_history_id has type bigint');

-- insert necessary data into table ghgr_import
insert into ggircs_swrs.ghgr_import (xml_file) values ($$
    <ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
      <RegistrationData>
        <Facility>
          <Details>
            <FacilityName>Stark Tower</FacilityName>
            <RelationshipType>complicated</RelationshipType>
            <PortabilityIndicator>P</PortabilityIndicator>
            <Status>Active</Status>
          </Details>
          <Address>
            <GeographicAddress>
              <Latitude>23.45125</Latitude>
              <Longitude>-90.59062</Longitude>
            </GeographicAddress>
          </Address>
        </Facility>
      </RegistrationData>
      <ReportDetails>
        <ReportID>800855555</ReportID>
        <PrepopReportID>5</PrepopReportID>
        <ReportType>R7</ReportType>
        <FacilityId>666</FacilityId>
        <OrganisationId>1337</OrganisationId>
        <ReportingPeriodDuration>1999</ReportingPeriodDuration>
        <ReportStatus>
          <Status>In Progress</Status>
          <Version>3</Version>
          <LastModifiedBy>Donny Donaldson McDonaldface</LastModifiedBy>
          <LastModifiedDate>2018-09-28T11:55:39.423</LastModifiedDate>
        </ReportStatus>
      </ReportDetails>
    </ReportData>

$$);

-- refresh necessary views with data
refresh materialized view ggircs_swrs.report with data;
refresh materialized view ggircs_swrs.facility with data;

-- test the columnns for ggircs_swrs.facility have been properly parsed from xml
select results_eq('select id from ggircs_swrs.facility', ARRAY[1::bigint], 'ggircs_swrs.facility parsed column id');
-- select results_eq('select report_id from ggircs_swrs.facility', ARRAY[1::bigint], 'ggircs_swrs.facility parsed column report_id');
select results_eq('select swrs_facility_id from ggircs_swrs.facility', ARRAY[666::numeric], 'ggircs_swrs.facility parsed column swrs_facility_id');
select results_eq('select facility_name from ggircs_swrs.facility', ARRAY['Stark Tower'::varchar], 'ggircs_swrs.facility parsed column facility_name');
select results_eq('select relationship_type from ggircs_swrs.facility', ARRAY['complicated'::varchar], 'ggircs_swrs.facility parsed column relationship_type');
select results_eq('select portability_indicator from ggircs_swrs.facility', ARRAY['P'::varchar], 'ggircs_swrs.facility parsed column portability_indicator');
select results_eq('select status from ggircs_swrs.facility', ARRAY['Active'::varchar], 'ggircs_swrs.facility parsed column status');
select results_eq('select latitude from ggircs_swrs.facility', ARRAY['23.45125'::varchar], 'ggircs_swrs.facility parsed column latitude');
select results_eq('select longitude from ggircs_swrs.facility', ARRAY['-90.59062'::varchar], 'ggircs_swrs.facility parsed column longitude');
select results_eq('select swrs_facility_history_id from ggircs_swrs.facility', ARRAY[1::bigint], 'ggircs_swrs.facility parsed column swrs_facility_history_id');

select finish();
rollback;
