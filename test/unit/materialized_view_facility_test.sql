set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(25);

-- Test matview report exists in schema ggircs_swrs
select has_materialized_view('ggircs_swrs', 'facility', 'Materialized view facility exists');

-- Test column names in matview report exist and are correct
select has_column('ggircs_swrs', 'facility', 'id', 'Matview facility has column: id');
select has_column('ggircs_swrs', 'facility', 'report_id', 'Matview facility has column: report_id');
select has_column('ggircs_swrs', 'facility', 'swrs_facility_id', 'Matview facility has column: swrs_facility_id');
select has_column('ggircs_swrs', 'facility', 'facility_name', 'Matview facility has column: facility_name');
select has_column('ggircs_swrs', 'facility', 'facility_type', 'Matview facility has column: facility_type');
select has_column('ggircs_swrs', 'facility', 'relationship_type', 'Matview facility has column: relationship_type');
select has_column('ggircs_swrs', 'facility', 'portability_indicator', 'Matview facility has column: portability_indicator');
select has_column('ggircs_swrs', 'facility', 'status', 'Matview facility has column: status');
select has_column('ggircs_swrs', 'facility', 'latitude', 'Matview facility has column: latitude');
select has_column('ggircs_swrs', 'facility', 'longitude', 'Matview facility has column: longitude');
select has_column('ggircs_swrs', 'facility', 'swrs_facility_history_id', 'Matview facility has column: swrs_facility_history_id');

-- Test index names in matview report exist and are correct
select has_index('ggircs_swrs', 'facility', 'ggircs_facility_primary_key', 'Matview facility has index: ggircs_facility_primary_key');
select has_index('ggircs_swrs', 'facility', 'ggircs_swrs_facility_history', 'Matview facility has index: ggircs_swrs_facility_history');

-- Test unique indicies are defined unique
select index_is_unique('ggircs_swrs', 'facility', 'ggircs_facility_primary_key', 'Matview report index ggircs_facility_primary_key is unique');

-- Test columns in matview report have correct types
select col_type_is('ggircs_swrs', 'facility', 'id', 'bigint', 'Matview facility column id has type bigint');
select col_type_is('ggircs_swrs', 'facility', 'report_id', 'bigint', 'Matview facility column report_id has type bigint');
select col_type_is('ggircs_swrs', 'facility', 'swrs_facility_id', 'numeric(1000,0)', 'Matview facility column swrs_facility_id has type numeric');
select col_type_is('ggircs_swrs', 'facility', 'facility_name', 'character varying(1000)', 'Matview facility column facility_name has type varchar');
select col_type_is('ggircs_swrs', 'facility', 'relationship_type', 'character varying(1000)', 'Matview facility column relationship_type has type varchar');
select col_type_is('ggircs_swrs', 'facility', 'portability_indicator', 'character varying(1000)', 'Matview facility column portability_indicator has type varchar');
select col_type_is('ggircs_swrs', 'facility', 'status', 'character varying(1000)', 'Matview facility column status has type varchar');
select col_type_is('ggircs_swrs', 'facility', 'latitude', 'character varying(1000)', 'Matview facility column latitude has type varchar');
select col_type_is('ggircs_swrs', 'facility', 'longitude', 'character varying(1000)', 'Matview facility column longitude has type varchar');
select col_type_is('ggircs_swrs', 'facility', 'swrs_facility_history_id', 'bigint', 'Matview facility column swrs_facility_history_id has type bigint');

select finish();
rollback;
