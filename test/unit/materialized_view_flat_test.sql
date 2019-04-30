set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(19);

-- Test matview report exists in schema ggircs_swrs
select has_materialized_view('ggircs_swrs', 'flat', 'Materialized view flat exists');

-- Test column names in matview report exist and are correct
select has_column('ggircs_swrs', 'flat', 'swrs_report_id', 'Matview flat has column: swrs_report_id');
select has_column('ggircs_swrs', 'flat', 'element_id', 'Matview flat has column: element_id');
select has_column('ggircs_swrs', 'flat', 'class', 'Matview flat has column: class');
select has_column('ggircs_swrs', 'flat', 'attr', 'Matview flat has column: attr');
select has_column('ggircs_swrs', 'flat', 'value', 'Matview flat has column: value');

-- Test index names in matview report exist and are correct
select has_index('ggircs_swrs', 'flat', 'ggircs_flat_primary_key', 'Matview flat has index: ggircs_flat_primary_key');
select has_index('ggircs_swrs', 'flat', 'ggircs_flat_report', 'Matview flat has index: ggircs_flat_report');

-- Test unique indicies are defined unique
select index_is_unique('ggircs_swrs', 'flat', 'ggircs_flat_primary_key', 'Matview report index ggircs_flat_primary_key is unique');

-- Test columns in matview report have correct types
select col_type_is('ggircs_swrs', 'flat', 'swrs_report_id', 'numeric(1000,0)', 'Matview flat column swrs_report_id has type numeric');
select col_type_is('ggircs_swrs', 'flat', 'element_id', 'bigint', 'Matview flat column element_id has type bigint');
select col_type_is('ggircs_swrs', 'flat', 'class', 'character varying(1000)', 'Matview flat column class has type varchar');
select col_type_is('ggircs_swrs', 'flat', 'attr', 'character varying(1000)', 'Matview flat column attr has type varchar');
select col_type_is('ggircs_swrs', 'flat', 'value', 'character varying(1000)', 'Matview flat column value has type varchar');


-- insert necessary data into table ghgr_import
insert into ggircs_swrs.ghgr_import (imported_at, xml_file) values ('2018-09-29T11:55:39.423', $$
    <ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
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

-- test the columnns for matview facility have been properly parsed from xml
select results_eq('select swrs_report_id from ggircs_swrs.flat', ARRAY[800855555::numeric], 'Matview flat parsed column swrs_report_id');
select results_eq('select element_id from ggircs_swrs.flat', ARRAY[1::bigint], 'Matview flat parsed column element_id');
select results_eq('select class from ggircs_swrs.flat', ARRAY[''::varchar], 'Matview flat parsed column class');
select results_eq('select attr from ggircs_swrs.flat', ARRAY[''::varchar], 'Matview flat parsed column attr');
select results_eq('select value from ggircs_swrs.flat', ARRAY[''::varchar], 'Matview flat parsed column value');

select finish();
rollback;
