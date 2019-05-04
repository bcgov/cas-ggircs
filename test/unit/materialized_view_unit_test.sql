set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(18);

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
    'unit_name'::name,
    'unit_description'::name,
    'xml_hunk'::name
]);

--  select has_column(       'ggircs_swrs', 'unit', 'id', 'unit.id column should exist');
select col_type_is(      'ggircs_swrs', 'unit', 'id', 'bigint', 'unit.id column should be type bigint');

--  select has_column(       'ggircs_swrs', 'unit', 'ghgr_import_id', 'unit.ghgr_import_id column should exist');
select col_type_is(      'ggircs_swrs', 'unit', 'ghgr_import_id', 'integer', 'unit.ghgr_import_id column should be type integer');
select col_hasnt_default('ggircs_swrs', 'unit', 'ghgr_import_id', 'unit.ghgr_import_id column should not have a default value');

--  select has_column(       'ggircs_swrs', 'unit', 'activity_id', 'unit.activity_id column should exist');
select col_type_is(      'ggircs_swrs', 'unit', 'activity_id', 'bigint', 'unit.activity_id column should be type bigint');
select col_is_null(      'ggircs_swrs', 'unit', 'activity_id', 'unit.activity_id_name column should allow null');
select col_hasnt_default('ggircs_swrs', 'unit', 'activity_id', 'unit.activity_id column should not  have a default');

--  select has_column(       'ggircs_swrs', 'unit', 'unit_name', 'unit.unit_name column should exist');
select col_type_is(      'ggircs_swrs', 'unit', 'unit_name', 'character varying(1000)', 'unit.unit_name column should be type varchar');
select col_is_null(      'ggircs_swrs', 'unit', 'unit_name', 'unit.unit_name column should allow null');
select col_hasnt_default('ggircs_swrs', 'unit', 'unit_name', 'unit.unit_name column should not have a default value');

--  select has_column(       'ggircs_swrs', 'unit', 'unit_description', 'unit.unit_description column should exist');
select col_type_is(      'ggircs_swrs', 'unit', 'unit_description', 'character varying(1000)', 'unit.unit_description column should be type varchar');
select col_is_null(      'ggircs_swrs', 'unit', 'unit_description', 'unit.unit_description column should allow null');
select col_hasnt_default('ggircs_swrs', 'unit', 'unit_description', 'unit.unit_description column should not have a default value');

--  select has_column(       'ggircs_swrs', 'unit', 'unit_xml_hunk', 'unit.xml_hunk column should exist');
select col_type_is(      'ggircs_swrs', 'unit', 'xml_hunk', 'xml', 'unit.xml_hunk column should be type xml');
select col_is_null(      'ggircs_swrs', 'unit', 'xml_hunk', 'unit.xml_hunk column should allow null');
select col_hasnt_default('ggircs_swrs', 'unit', 'xml_hunk', 'unit.xml_hunk column should not have a default value');

-- TODO(wenzowski): ensure all descriptors are extracted
-- with x as (select id, xml_hunk from ggircs_swrs.unit)
-- select distinct tag.name
-- from x,
--      xmltable('/Unit/*' passing xml_hunk columns name text path 'name(.)') as tag
-- order by tag.name;

-- COGenUnit
-- Fuels
-- NonCOGenUnit
-- UnitDesc
-- UnitName


select * from finish();
rollback;
