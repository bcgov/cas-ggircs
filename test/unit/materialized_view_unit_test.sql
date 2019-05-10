set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(57);

select has_materialized_view(
    'ggircs_swrs', 'unit',
    'ggircs_swrs.activity should be a materialized view'
);

select has_index(
    'ggircs_swrs', 'unit', 'ggircs_unit_primary_key',
    'ggircs_swrs.activity should have a primary key'
);

select columns_are('ggircs_swrs'::name, 'unit'::name, array[
    'ghgr_import_id'::name,
    'activity_name'::name,
    'process_idx'::name,
    'sub_process_idx'::name,
    'units_idx'::name,
    'unit_idx'::name,
    'unit_name'::name,
    'unit_description'::name,
    'cogen_cycle_type'::name,
    'cogen_nameplate_capacity'::name,
    'cogen_net_power'::name,
    'cogen_steam_heat_acq_name'::name,
    'cogen_steam_heat_acq_quantity'::name,
    'cogen_supplemental_firing_purpose'::name,
    'cogen_thermal_output_quantity'::name,
    'cogen_unit_name'::name,
    'non_cogen_nameplate_capacity'::name,
    'non_cogen_net_power'::name,
    'non_cogen_unit_name'::name
]);

--  select has_column(       'ggircs_swrs', 'unit', 'ghgr_import_id', 'unit.ghgr_import_id column should exist');
select col_type_is(      'ggircs_swrs', 'unit', 'ghgr_import_id', 'integer', 'unit.ghgr_import_id column should be type integer');
select col_hasnt_default('ggircs_swrs', 'unit', 'ghgr_import_id', 'unit.ghgr_import_id column should not have a default value');

--  select has_column(       'ggircs_swrs', 'unit', 'activity_name', 'unit.activity_name column should exist');
select col_type_is(      'ggircs_swrs', 'unit', 'activity_name', 'character varying(1000)', 'unit.activity_name column should be type varchar');
--  select col_is_null(      'ggircs_swrs', 'unit', 'activity_name', 'unit.activity_name column should allow null');
select col_hasnt_default('ggircs_swrs', 'unit', 'activity_name', 'unit.activity_name column should not have a default');

--  select has_column(       'ggircs_swrs', 'unit', 'process_idx', 'unit.process_idx column should exist');
select col_type_is(      'ggircs_swrs', 'unit', 'process_idx', 'integer', 'unit.process_idx column should be type integer');
--  select col_is_null(      'ggircs_swrs', 'unit', 'process_idx', 'unit.process_idx column should allow null');
select col_hasnt_default('ggircs_swrs', 'unit', 'process_idx', 'unit.process_idx column should not  have a default');

--  select has_column(       'ggircs_swrs', 'unit', 'sub_process_idx', 'unit.sub_process_idx column should exist');
select col_type_is(      'ggircs_swrs', 'unit', 'sub_process_idx', 'integer', 'unit.sub_process_idx column should be type integer');
--  select col_is_null(      'ggircs_swrs', 'unit', 'sub_process_idx', 'unit.sub_process_idx column should allow null');
select col_hasnt_default('ggircs_swrs', 'unit', 'sub_process_idx', 'unit.sub_process_idx column should not have a default');

--  select has_column(       'ggircs_swrs', 'unit', 'units_idx', 'unit.units_idx column should exist');
select col_type_is(      'ggircs_swrs', 'unit', 'units_idx', 'integer', 'unit.units_idx column should be type integer');
--  select col_is_null(      'ggircs_swrs', 'unit', 'units_idx', 'unit.units_idx column should allow null');
select col_hasnt_default('ggircs_swrs', 'unit', 'units_idx', 'unit.units_idx column should not have a default');

--  select has_column(       'ggircs_swrs', 'unit', 'unit_idx', 'unit.unit_idx column should exist');
select col_type_is(      'ggircs_swrs', 'unit', 'unit_idx', 'integer', 'unit.unit_idx column should be type integer');
--  select col_is_null(      'ggircs_swrs', 'unit', 'unit_idx', 'unit.unit_idx column should allow null');
select col_hasnt_default('ggircs_swrs', 'unit', 'unit_idx', 'unit.unit_idx column should not have a default');

--  select has_column(       'ggircs_swrs', 'unit', 'unit_name', 'unit.unit_name column should exist');
select col_type_is(      'ggircs_swrs', 'unit', 'unit_name', 'character varying(1000)', 'unit.unit_name column should be type varchar');
select col_is_null(      'ggircs_swrs', 'unit', 'unit_name', 'unit.unit_name column should allow null');
select col_hasnt_default('ggircs_swrs', 'unit', 'unit_name', 'unit.unit_name column should not have a default value');

--  select has_column(       'ggircs_swrs', 'unit', 'unit_description', 'unit.unit_description column should exist');
select col_type_is(      'ggircs_swrs', 'unit', 'unit_description', 'character varying(1000)', 'unit.unit_description column should be type varchar');
select col_is_null(      'ggircs_swrs', 'unit', 'unit_description', 'unit.unit_description column should allow null');
select col_hasnt_default('ggircs_swrs', 'unit', 'unit_description', 'unit.unit_description column should not have a default value');

--  select has_column(       'ggircs_swrs', 'unit', 'cogen_cycle_type', 'unit.cogen_cycle_type column should exist');
select col_type_is(      'ggircs_swrs', 'unit', 'cogen_cycle_type', 'character varying(1000)', 'unit.cogen_cycle_type column should be type varchar');
select col_is_null(      'ggircs_swrs', 'unit', 'cogen_cycle_type', 'unit.cogen_cycle_type column should allow null');
select col_hasnt_default('ggircs_swrs', 'unit', 'cogen_cycle_type', 'unit.cogen_cycle_type column should not have a default value');

--  select has_column(       'ggircs_swrs', 'unit', 'cogen_nameplate_capacity', 'unit.cogen_nameplate_capacity column should exist');
select col_type_is(      'ggircs_swrs', 'unit', 'cogen_nameplate_capacity', 'character varying(1000)', 'unit.cogen_nameplate_capacity column should be type varchar');
select col_is_null(      'ggircs_swrs', 'unit', 'cogen_nameplate_capacity', 'unit.cogen_nameplate_capacity column should allow null');
select col_hasnt_default('ggircs_swrs', 'unit', 'cogen_nameplate_capacity', 'unit.cogen_nameplate_capacity column should not have a default value');

--  select has_column(       'ggircs_swrs', 'unit', 'cogen_net_power', 'unit.cogen_net_power column should exist');
select col_type_is(      'ggircs_swrs', 'unit', 'cogen_net_power', 'character varying(1000)', 'unit.cogen_net_power column should be type varchar');
select col_is_null(      'ggircs_swrs', 'unit', 'cogen_net_power', 'unit.cogen_net_power column should allow null');
select col_hasnt_default('ggircs_swrs', 'unit', 'cogen_net_power', 'unit.cogen_net_power column should not have a default value');

--  select has_column(       'ggircs_swrs', 'unit', 'cogen_steam_heat_acq_name', 'unit.cogen_steam_heat_acq_name column should exist');
select col_type_is(      'ggircs_swrs', 'unit', 'cogen_steam_heat_acq_name', 'character varying(1000)', 'unit.cogen_steam_heat_acq_name column should be type varchar');
select col_is_null(      'ggircs_swrs', 'unit', 'cogen_steam_heat_acq_name', 'unit.cogen_steam_heat_acq_name column should allow null');
select col_hasnt_default('ggircs_swrs', 'unit', 'cogen_steam_heat_acq_name', 'unit.cogen_steam_heat_acq_name column should not have a default value');

--  select has_column(       'ggircs_swrs', 'unit', 'cogen_steam_heat_acq_quantity', 'unit.cogen_steam_heat_acq_quantity column should exist');
select col_type_is(      'ggircs_swrs', 'unit', 'cogen_steam_heat_acq_quantity', 'character varying(1000)', 'unit.cogen_steam_heat_acq_quantity column should be type varchar');
select col_is_null(      'ggircs_swrs', 'unit', 'cogen_steam_heat_acq_quantity', 'unit.cogen_steam_heat_acq_quantity column should allow null');
select col_hasnt_default('ggircs_swrs', 'unit', 'cogen_steam_heat_acq_quantity', 'unit.cogen_steam_heat_acq_quantity column should not have a default value');

--  select has_column(       'ggircs_swrs', 'unit', 'cogen_supplemental_firing_purpose', 'unit.cogen_supplemental_firing_purpose column should exist');
select col_type_is(      'ggircs_swrs', 'unit', 'cogen_supplemental_firing_purpose', 'character varying(1000)', 'unit.cogen_supplemental_firing_purpose column should be type varchar');
select col_is_null(      'ggircs_swrs', 'unit', 'cogen_supplemental_firing_purpose', 'unit.cogen_supplemental_firing_purpose column should allow null');
select col_hasnt_default('ggircs_swrs', 'unit', 'cogen_supplemental_firing_purpose', 'unit.cogen_supplemental_firing_purpose column should not have a default value');

--  select has_column(       'ggircs_swrs', 'unit', 'cogen_thermal_output_quantity', 'unit.cogen_thermal_output_quantity column should exist');
select col_type_is(      'ggircs_swrs', 'unit', 'cogen_thermal_output_quantity', 'character varying(1000)', 'unit.cogen_thermal_output_quantity column should be type varchar');
select col_is_null(      'ggircs_swrs', 'unit', 'cogen_thermal_output_quantity', 'unit.cogen_thermal_output_quantity column should allow null');
select col_hasnt_default('ggircs_swrs', 'unit', 'cogen_thermal_output_quantity', 'unit.cogen_thermal_output_quantity column should not have a default value');

--  select has_column(       'ggircs_swrs', 'unit', 'cogen_unit_name', 'unit.cogen_unit_name column should exist');
select col_type_is(      'ggircs_swrs', 'unit', 'cogen_unit_name', 'character varying(1000)', 'unit.cogen_unit_name column should be type varchar');
select col_is_null(      'ggircs_swrs', 'unit', 'cogen_unit_name', 'unit.cogen_unit_name column should allow null');
select col_hasnt_default('ggircs_swrs', 'unit', 'cogen_unit_name', 'unit.cogen_unit_name column should not have a default value');

--  select has_column(       'ggircs_swrs', 'unit', 'non_cogen_nameplate_capacity', 'unit.non_cogen_nameplate_capacity column should exist');
select col_type_is(      'ggircs_swrs', 'unit', 'non_cogen_nameplate_capacity', 'character varying(1000)', 'unit.non_cogen_nameplate_capacity column should be type varchar');
select col_is_null(      'ggircs_swrs', 'unit', 'non_cogen_nameplate_capacity', 'unit.non_cogen_nameplate_capacity column should allow null');
select col_hasnt_default('ggircs_swrs', 'unit', 'non_cogen_nameplate_capacity', 'unit.non_cogen_nameplate_capacity column should not have a default value');

--  select has_column(       'ggircs_swrs', 'unit', 'non_cogen_net_power', 'unit.non_cogen_net_power column should exist');
select col_type_is(      'ggircs_swrs', 'unit', 'non_cogen_net_power', 'character varying(1000)', 'unit.non_cogen_net_power column should be type varchar');
select col_is_null(      'ggircs_swrs', 'unit', 'non_cogen_net_power', 'unit.non_cogen_net_power column should allow null');
select col_hasnt_default('ggircs_swrs', 'unit', 'non_cogen_net_power', 'unit.non_cogen_net_power column should not have a default value');

--  select has_column(       'ggircs_swrs', 'unit', 'non_cogen_unit_name', 'unit.non_cogen_unit_name column should exist');
select col_type_is(      'ggircs_swrs', 'unit', 'non_cogen_unit_name', 'character varying(1000)', 'unit.non_cogen_unit_name column should be type varchar');
select col_is_null(      'ggircs_swrs', 'unit', 'non_cogen_unit_name', 'unit.non_cogen_unit_name column should allow null');
select col_hasnt_default('ggircs_swrs', 'unit', 'non_cogen_unit_name', 'unit.non_cogen_unit_name column should not have a default value');

-- Insert data for fixture based testing
insert into ggircs_swrs.ghgr_import (xml_file) values ($$
<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <ActivityData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <ActivityPages>
      <Process ProcessName="GeneralStationaryCombustion">
        <SubProcess SubprocessName="(a) general stationary combustion, useful energy" InformationRequirement="Required">
          <Units>
            <Unit>
              <UnitName>Burner</UnitName>
              <UnitDesc>Supply heat to bed dryer</UnitDesc>
            </Unit>
          </Units>
        </SubProcess>
        <SubProcess>
          <Units>
            <Unit>
              <UnitName>Red Herring</UnitName>
            </Unit>
          </Units>
        </SubProcess>
      </Process>
    </ActivityPages>
  </ActivityData>
</ReportData>
$$);

-- refresh necessary views with data
refresh materialized view ggircs_swrs.unit with data;
refresh materialized view ggircs_swrs.activity with data;

-- test the columns for matview facility have been properly parsed from xml
select results_eq(
  'select distinct ghgr_import_id from ggircs_swrs.unit',
  'select id from ggircs_swrs.ghgr_import',
  'ggircs_swrs.activity.ghgr_import_id relates to ggircs_swrs.ghgr_import.id'
);

-- test the foreign keys in unit return a value when joined on activity
select results_eq(
    'select activity.ghgr_import_id from ggircs_swrs.unit ' ||
    'join ggircs_swrs.activity ' ||
    'on (' ||
    'unit.ghgr_import_id =  activity.ghgr_import_id ' ||
    'and unit.process_idx = activity.process_idx ' ||
    'and unit.sub_process_idx = activity.sub_process_idx ' ||
    'and unit.activity_name = activity.activity_name)',

    'select ghgr_import_id from ggircs_swrs.activity',

    'Foreign keys ghgr_import_id, process_idx, sub_process_idx and activity_name in ggircs_swrs_unit reference ggircs_swrs.activity'
);

select results_eq(
  'select distinct activity_name from ggircs_swrs.unit',
  ARRAY['ActivityPages'::varchar],
  'ggircs_swrs.activity.activity_name is extracted'
);
-- TODO(wenzowski): continue testing remaining columns
--     'process_idx'::name,
--     'sub_process_idx'::name,
--     'unit_id'::name,
--     'unit_type'::name,
--     'unit_name'::name,
--     'unit_description'::name,
--     'cogen_cycle_type'::name,
--     'cogen_nameplate_capacity'::name,
--     'cogen_net_power'::name,
--     'cogen_steam_heat_acq_name'::name,
--     'cogen_steam_heat_acq_quantity'::name,
--     'cogen_supplemental_firing_purpose'::name,
--     'cogen_thermal_output_quantity'::name,
--     'cogen_unit_name'::name,
--     'non_cogen_nameplate_capacity'::name,
--     'non_cogen_net_power'::name,
--     'non_cogen_unit_name'::name

select * from finish();
rollback;
