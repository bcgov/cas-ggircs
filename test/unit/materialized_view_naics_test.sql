set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(25);

-- Test matview report exists in schema ggircs_swrs
select has_materialized_view('ggircs_swrs', 'naics', 'ggircs_swrs.naics exists');
--
-- -- Test column names in matview report exist and are correct
select has_column('ggircs_swrs', 'naics', 'id', 'ggircs_swrs.naics_ has column: id');
select has_column('ggircs_swrs', 'naics', 'facility_id', 'ggircs_swrs.naics_ has column: facility_id');
select has_column('ggircs_swrs', 'naics', 'swrs_facility_id', 'ggircs_swrs.naics_ has column: swrs_facility_id');
select has_column('ggircs_swrs', 'naics', 'naics_classification', 'ggircs_swrs.naics_ has column: naics_classification');
select has_column('ggircs_swrs', 'naics', 'naics_code', 'ggircs_swrs.naics_ has column: naics_code');
select has_column('ggircs_swrs', 'naics', 'naics_priority', 'ggircs_swrs.naics_ has column: naics_priority');
select has_column('ggircs_swrs', 'naics', 'swrs_naics_history_id', 'ggircs_swrs.naics_ has column: swrs_naics_history_id');

--
-- -- Test index names in matview report exist and are correct
select has_index('ggircs_swrs', 'naics', 'ggircs_naics_primary_key', 'ggircs_swrs.naics has index: ggircs_naics_primary_key');
select has_index('ggircs_swrs', 'naics', 'ggircs_swrs_naics_history', 'ggircs_swrs.naics has index: ggircs_swrs_naics_history');
--
-- -- Test unique indicies are defined unique
select index_is_unique('ggircs_swrs', 'naics', 'ggircs_naics_primary_key', 'ggircs_swrs.naics index ggircs_facility_primary_key is unique');
--
-- -- Test columns in matview report have correct types
select col_type_is('ggircs_swrs', 'naics', 'id', 'bigint', 'ggircs_swrs.naics.id has type bigint');
select col_type_is('ggircs_swrs', 'naics', 'facility_id', 'bigint', 'ggircs_swrs.naics.facility_id has type bigint');
select col_type_is('ggircs_swrs', 'naics', 'swrs_facility_id', 'numeric(1000,0)', 'ggircs_swrs.naics.swrs_facility_id has type numeric');
select col_type_is('ggircs_swrs', 'naics', 'naics_classification', 'character varying(1000)', 'ggircs_swrs.naics.naics_classification has type varchar');
select col_type_is('ggircs_swrs', 'naics', 'naics_code', 'character varying(1000)', 'ggircs_swrs.naics.naics_code has type varchar');
select col_type_is('ggircs_swrs', 'naics', 'naics_priority', 'character varying(1000)', 'ggircs_swrs.naics.naics_priority has type varchar');
select col_type_is('ggircs_swrs', 'naics', 'swrs_naics_history_id', 'bigint', 'ggircs_swrs.naics.swrs_naics_history_id has type bigint');

--
-- insert necessary data into table ghgr_import
insert into ggircs_swrs.ghgr_import (xml_file) values ($$
    <ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
      <RegistrationData>
        <Facility>
         <Identifiers>
           <NAICSCodeList>
              <NAICSCode>
                <NAICSClassification>Conventional Oil and Gas Extraction</NAICSClassification>
                <Code>123456</Code>
                <NaicsPriority>Primary</NaicsPriority>
              </NAICSCode>
            </NAICSCodeList>
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
refresh materialized view ggircs_swrs.naics with data;

-- test that the columns in ggircs_swrs.naics have been properly parsed from xml
select results_eq('select id from ggircs_swrs.naics', ARRAY[1::bigint], 'ggircs_swrs.naics parsed column id');
select results_eq('select facility_id from ggircs_swrs.naics', ARRAY[1::bigint], 'ggircs_swrs.naics parsed column facility_id');
select results_eq('select swrs_facility_id from ggircs_swrs.naics', ARRAY[666::numeric], 'ggircs_swrs.naics parsed column swrs_facility_id');
select results_eq('select naics_classification from ggircs_swrs.naics', ARRAY['Conventional Oil and Gas Extraction'::varchar], 'ggircs_swrs.naics parsed column naics_classification');
select results_eq('select naics_code from ggircs_swrs.naics', ARRAY[123456::varchar], 'ggircs_swrs.naics parsed column naics_code');
select results_eq('select naics_priority from ggircs_swrs.naics', ARRAY['Primary'::varchar], 'ggircs_swrs.naics parsed column naics_priority');
select results_eq('select swrs_naics_history_id from ggircs_swrs.naics', ARRAY[1::bigint], 'ggircs_swrs.naics parsed column swrs_naics_history_id');

select finish();
rollback;
