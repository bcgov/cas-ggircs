set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(20);

-- Test matview report exists in schema ggircs_swrs
select has_materialized_view('ggircs_swrs', 'identifier', 'Materialized view facility exists');

-- Test column names in matview report exist and are correct
select has_column('ggircs_swrs', 'identifier', 'id', 'ggircs_swrs.identifier has column: id');
select has_column('ggircs_swrs', 'identifier', 'report_id', 'ggircs_swrs.identifier has column: report_id');
select has_column('ggircs_swrs', 'identifier', 'swrs_report_id', 'ggircs_swrs.identifier has column: swrs_report_id');
select has_column('ggircs_swrs', 'identifier', 'facility_id', 'ggircs_swrs.identifier has column: facility_id');
select has_column('ggircs_swrs', 'identifier', 'swrs_facility_id', 'ggircs_swrs.identifier has column: swrs_facility_id');
select has_column('ggircs_swrs', 'identifier', 'identifier_type', 'ggircs_swrs.identifier has column: identifier_type');
select has_column('ggircs_swrs', 'identifier', 'identifier_value', 'ggircs_swrs.identifier has column: identifier_value');
select has_column('ggircs_swrs', 'identifier', 'swrs_identifier_history_id', 'ggircs_swrs.identifier has column: swrs_identifier_history_id');

-- Test index names in matview report exist and are correct
select has_index('ggircs_swrs', 'identifier', 'ggircs_identifier_primary_key', 'ggircs_swrs.identifier has index: ggircs_identifier_primary_key');
select has_index('ggircs_swrs', 'identifier', 'ggircs_swrs_identifier_history', 'ggircs_swrs.identifier has index: ggircs_swrs_identifier_history');

-- Test unique indicies are defined unique
select index_is_unique('ggircs_swrs', 'facility', 'ggircs_facility_primary_key', 'Matview report index ggircs_facility_primary_key is unique');

-- Test columns in matview report have correct types
select col_type_is('ggircs_swrs', 'identifier', 'id', 'bigint', 'ggircs_swrs.identifier column id has type bigint');
select col_type_is('ggircs_swrs', 'identifier', 'report_id', 'bigint', 'ggircs_swrs.identifier column report_id has type bigint');
select col_type_is('ggircs_swrs', 'identifier', 'swrs_report_id', 'numeric(1000,0)', 'ggircs_swrs.identifier column swrs_report_id has type numeric');
select col_type_is('ggircs_swrs', 'identifier', 'facility_id', 'bigint', 'ggircs_swrs.identifier column facility_id has type bigint');
select col_type_is('ggircs_swrs', 'identifier', 'swrs_facility_id', 'numeric(1000,0)', 'ggircs_swrs.identifier column swrs_facility_id has type numeric');
select col_type_is('ggircs_swrs', 'identifier', 'identifier_type', 'character varying(1000)', 'ggircs_swrs.identifier column identifier_type has type varchar');
select col_type_is('ggircs_swrs', 'identifier', 'identifier_value', 'character varying(1000)', 'ggircs_swrs.identifier column identifier_value has type varchar');
select col_type_is('ggircs_swrs', 'identifier', 'swrs_identifier_history_id', 'bigint', 'ggircs_swrs.identifier column swrs_identifier_history_id has type bigint');


-- insert necessary data into table ghgr_import
insert into ggircs_swrs.ghgr_import (xml_file) values ($$
    <ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
      <RegistrationData>
        <Facility>
          <Identifiers>
            <IdentifierList>
              <Identifier>
                <IdentifierType>GHGRP Identification Number</IdentifierType>
                <IdentifierValue>G11741</IdentifierValue>
              </Identifier>
            </IdentifierList>
          </Identifiers>
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
refresh materialized view ggircs_swrs.identifier with data;

-- test the columnns for ggircs_swrs.identifier have been properly parsed from xml
-- select results_eq('select id from ggircs_swrs.facility', ARRAY[1::bigint], 'ggircs_swrs.identifier parsed column id');

select finish();
rollback;
