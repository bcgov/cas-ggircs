set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(1);

-- Test matview report exists in schema ggircs_swrs
select has_materialized_view('ggircs_swrs', 'facility', 'Materialized view facility exists');

-- Test column names in matview report exist and are correct
-- select has_column('ggircs_swrs', 'organisation', 'id', 'Matview organisation has column: id');

-- Test index names in matview report exist and are correct
-- select has_index('ggircs_swrs', 'organisation', 'ggircs_organisation_primary_key', 'Matview organisation has index: ggircs_organisation_primary_key');

-- Test unique indicies are defined unique
-- select index_is_unique('ggircs_swrs', 'organisation', 'ggircs_organisation_primary_key', 'Matview report index ggircs_organisation_primary_key is unique');

-- Test columns in matview report have correct types
-- select col_type_is('ggircs_swrs', 'organisation', 'id', 'bigint', 'Matview organisation column id has type bigint');

select finish();
rollback;
