set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(27);

select has_materialized_view(
    'ggircs_swrs', 'unit',
    'ggircs_swrs.activity should be a materialized view'
);

select has_index(
    'ggircs_swrs', 'unit', 'ggircs_unit_primary_key',
    'ggircs_swrs.activity should have a primary key'
);

select columns_are('ggircs_swrs'::name, 'unit'::name, array[
    'id'::name,
    'ghgr_import_id'::name,
    'activity_id'::name,
    'activity'::name,
    'sub_activity'::name,
    'activity_xml_hunk'::name,
    'unit_name'::name,
    'unit_description'::name,
    'unit_xml_hunk'::name
]);

--  select has_column(       'ggircs_swrs', 'unit', 'id', 'unit.id column should exist');
select col_type_is(      'ggircs_swrs', 'unit', 'id', 'bigint', 'unit.id column should be type bigint');

--  select has_column(       'ggircs_swrs', 'unit', 'ghgr_import_id', 'unit.ghgr_import_id column should exist');
select col_type_is(      'ggircs_swrs', 'unit', 'ghgr_import_id', 'integer', 'unit.ghgr_import_id column should be type integer');
select col_hasnt_default('ggircs_swrs', 'unit', 'ghgr_import_id', 'unit.ghgr_import_id column should not have a default value');

--  select has_column(       'ggircs_swrs', 'unit', 'process_name', 'unit.activity_id column should exist');
select col_type_is(      'ggircs_swrs', 'unit', 'activity_id', 'bigint', 'unit.process_name column should be type bigint');
select col_is_null(      'ggircs_swrs', 'unit', 'activity_id', 'unit.activity_id_name column should allow null');
select col_hasnt_default('ggircs_swrs', 'unit', 'activity_id', 'unit.activity_id column should not  have a default');

--  select has_column(       'ggircs_swrs', 'unit', 'activity', 'unit.activity column should exist');
select col_type_is(      'ggircs_swrs', 'unit', 'activity', 'character varying(1000)', 'unit.activity column should be type varchar');
select col_is_null(      'ggircs_swrs', 'unit', 'activity', 'unit.activity column should allow null');
select col_hasnt_default('ggircs_swrs', 'unit', 'activity', 'unit.subprocess_name column should not have a default value');

--  select has_column(       'ggircs_swrs', 'unit', 'sub_activity', 'unit.sub_activity column should exist');
select col_type_is(      'ggircs_swrs', 'unit', 'sub_activity', 'character varying(1000)', 'unit.sub_activity column should be type varchar');
select col_is_null(      'ggircs_swrs', 'unit', 'sub_activity', 'unit.sub_activity column should allow null');
select col_hasnt_default('ggircs_swrs', 'unit', 'sub_activity', 'unit.sub_activity column should not have a default value');

--  select has_column(       'ggircs_swrs', 'unit', 'activity_xml_hunk', 'unit.xml_hunk column should exist');
select col_type_is(      'ggircs_swrs', 'unit', 'activity_xml_hunk', 'xml', 'unit.activity_xml_hunk column should be type xml');
select col_is_null(      'ggircs_swrs', 'unit', 'activity_xml_hunk', 'unit.activity_xml_hunk column should allow null');
select col_hasnt_default('ggircs_swrs', 'unit', 'activity_xml_hunk', 'unit.activity_xml_hunk column should not have a default value');

--  select has_column(       'ggircs_swrs', 'unit', 'unit_name', 'unit.unit_name column should exist');
select col_type_is(      'ggircs_swrs', 'unit', 'unit_name', 'character varying(1000)', 'unit.unit_name column should be type varchar');
select col_is_null(      'ggircs_swrs', 'unit', 'unit_name', 'unit.unit_name column should allow null');
select col_hasnt_default('ggircs_swrs', 'unit', 'unit_name', 'unit.unit_name column should not have a default value');

--  select has_column(       'ggircs_swrs', 'unit', 'unit_description', 'unit.unit_description column should exist');
select col_type_is(      'ggircs_swrs', 'unit', 'unit_description', 'character varying(1000)', 'unit.unit_description column should be type varchar');
select col_is_null(      'ggircs_swrs', 'unit', 'unit_description', 'unit.unit_description column should allow null');
select col_hasnt_default('ggircs_swrs', 'unit', 'unit_description', 'unit.unit_description column should not have a default value');

--  select has_column(       'ggircs_swrs', 'unit', 'unit_xml_hunk', 'unit.xml_hunk column should exist');
select col_type_is(      'ggircs_swrs', 'unit', 'unit_xml_hunk', 'xml', 'unit.unit_xml_hunk column should be type xml');
select col_is_null(      'ggircs_swrs', 'unit', 'unit_xml_hunk', 'unit.unit_xml_hunk column should allow null');
select col_hasnt_default('ggircs_swrs', 'unit', 'unit_xml_hunk', 'unit.unit_xml_hunk column should not have a default value');

select * from finish();
rollback;
