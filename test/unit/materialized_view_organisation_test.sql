set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(26);

-- Test matview report exists in schema ggircs_swrs
select has_materialized_view('ggircs_swrs', 'organisation', 'Materialized view report exists');

-- -- Test column names in matview report exist and are correct
select has_column('ggircs_swrs', 'organisation', 'id', 'Matview organisation has column: id');
select has_column('ggircs_swrs', 'organisation', 'report_id', 'Matview organisation has column: report_id');
select has_column('ggircs_swrs', 'organisation', 'swrs_organisation_id', 'Matview organisation has column: swrs_organisation_id');
select has_column('ggircs_swrs', 'organisation', 'business_legal_name', 'Matview organisation has column: business_legal_name');
select has_column('ggircs_swrs', 'organisation', 'english_trade_name', 'Matview organisation has column: english_trade_name');
select has_column('ggircs_swrs', 'organisation', 'french_trade_name', 'Matview organisation has column: french_trade_name');
select has_column('ggircs_swrs', 'organisation', 'cra_business_number', 'Matview organisation has column: cra_business_number');
select has_column('ggircs_swrs', 'organisation', 'duns', 'Matview organisation has column: duns');
select has_column('ggircs_swrs', 'organisation', 'website', 'Matview organisation has column: website');
select has_column('ggircs_swrs', 'organisation', 'swrs_organisation_history_id', 'Matview organisation has column: swrs_organisation_history_id');
--
-- -- Test index names in matview report exist and are correct
select has_index('ggircs_swrs', 'organisation', 'ggircs_organisation_primary_key', 'Matview organisation has index: ggircs_organisation_primary_key');
select has_index('ggircs_swrs', 'organisation', 'ggircs_swrs_organisation_history', 'Matview organisation has index: ggircs_swrs_organisation_history');
--
-- -- Test unique indicies are defined unique
select index_is_unique('ggircs_swrs', 'organisation', 'ggircs_organisation_primary_key', 'Matview report index ggircs_organisation_primary_key is unique');
--
-- -- Test columns in matview report have correct types
select col_type_is('ggircs_swrs', 'organisation', 'id', 'bigint', 'Matview organisation column id has type bigint');
select col_type_is('ggircs_swrs', 'organisation', 'report_id', 'bigint', 'Matview organisation column report_id has type bigint');
select col_type_is('ggircs_swrs', 'organisation', 'swrs_organisation_id', 'numeric(1000,0)', 'Matview organisation column id has type numeric(1000,0)');
select col_type_is('ggircs_swrs', 'organisation', 'business_legal_name', 'character varying(1000)', 'Matview organisation column business_legal_name has type varchar');
select col_type_is('ggircs_swrs', 'organisation', 'english_trade_name', 'character varying(1000)', 'Matview organisation column english_trade_name has type varchar');
select col_type_is('ggircs_swrs', 'organisation', 'french_trade_name', 'character varying(1000)', 'Matview organisation column french_trade_name has type varchar');
select col_type_is('ggircs_swrs', 'organisation', 'cra_business_number', 'character varying(1000)', 'Matview organisation column cra_business_number has type varchar');
select col_type_is('ggircs_swrs', 'organisation', 'duns', 'character varying(1000)', 'Matview organisation column duns has type varchar');
select col_type_is('ggircs_swrs', 'organisation', 'website', 'character varying(1000)', 'Matview organisation column website has type varchar');
select col_type_is('ggircs_swrs', 'organisation', 'swrs_organisation_history_id', 'bigint', 'Matview organisation column swrs_organisation_history_id has type bigint');

insert into ggircs_swrs.ghgr_import (xml_file) values ($$
    <ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
      <RegistrationData>
        <Organisation>
          <Details>
            <BusinessLegalName>Ren and Stimpy's House</BusinessLegalName>
            <EnglishTradeName/>
            <FrenchTradeName/>
            <CRABusinessNumber>123456789</CRABusinessNumber>
            <DUNSNumber>0</DUNSNumber>
            <WebSite>www.hockeyisgood.com</WebSite>
          </Details>
        </Organisation>
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

refresh materialized view ggircs_swrs.report with data;
refresh materialized view ggircs_swrs.organisation with data;

select results_eq('select id from ggircs_swrs.organisation', ARRAY[1::bigint], 'Matview organisation parsed column id');
select results_eq('select report_id from ggircs_swrs.organisation', ARRAY[1::bigint], 'Matview organisation parsed column report_id');

select finish();
rollback;
