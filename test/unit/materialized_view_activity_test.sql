set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(28);

select has_materialized_view(
    'ggircs_swrs', 'activity',
    'ggircs_swrs.activity should be a materialized view'
);

select has_index(
    'ggircs_swrs', 'activity', 'ggircs_activity_primary_key',
    'ggircs_swrs.activity should have a primary key'
);

select columns_are('ggircs_swrs'::name, 'activity'::name, array[
    'ghgr_import_id'::name,
    'process_idx'::name,
    'sub_process_idx'::name,
    'activity_name'::name,
    'process_name'::name,
    'sub_process_name'::name,
    'information_requirement'::name
]);

--  select has_column(       'ggircs_swrs', 'activity', 'ghgr_import_id', 'activity.ghgr_import_id column should exist');
select col_type_is(      'ggircs_swrs', 'activity', 'ghgr_import_id', 'integer', 'activity.ghgr_import_id column should be type integer');
select col_hasnt_default('ggircs_swrs', 'activity', 'ghgr_import_id', 'activity.ghgr_import_id column should not have a default value');

--  select has_column(       'ggircs_swrs', 'activity', 'process_idx', 'activity.process_idx column should exist');
select col_type_is(      'ggircs_swrs', 'activity', 'process_idx', 'integer', 'activity.process_idx column should be type integer');
--  select col_is_null(      'ggircs_swrs', 'activity', 'process_idx', 'activity.process_idx column should allow null');
select col_hasnt_default('ggircs_swrs', 'activity', 'process_idx', 'activity.process_idx column should not have a default');

--  select has_column(       'ggircs_swrs', 'activity', 'sub_process_idx', 'activity.sub_process_idx column should exist');
select col_type_is(      'ggircs_swrs', 'activity', 'sub_process_idx', 'integer', 'activity.sub_process_idx column should be type integer');
--  select col_is_null(      'ggircs_swrs', 'activity', 'sub_process_idx', 'activity.sub_process_idx column should allow null');
select col_hasnt_default('ggircs_swrs', 'activity', 'sub_process_idx', 'activity.sub_process_idx column should not have a default');

--  select has_column(       'ggircs_swrs', 'activity', 'activity_name', 'activity.activity_name column should exist');
select col_type_is(      'ggircs_swrs', 'activity', 'activity_name', 'character varying(1000)', 'activity.activity_name column should be type text');
--  select col_is_null(      'ggircs_swrs', 'activity', 'activity_name', 'activity.activity_name column should allow null');
select col_hasnt_default('ggircs_swrs', 'activity', 'activity_name', 'activity.activity_name column should not have a default');

--  select has_column(       'ggircs_swrs', 'activity', 'process_name', 'activity.process_name column should exist');
select col_type_is(      'ggircs_swrs', 'activity', 'process_name', 'character varying(1000)', 'activity.process_name column should be type text');
select col_is_null(      'ggircs_swrs', 'activity', 'process_name', 'activity.process_name column should allow null');
select col_hasnt_default('ggircs_swrs', 'activity', 'process_name', 'activity.process_name column should not  have a default');

--  select has_column(       'ggircs_swrs', 'activity', 'sub_process_name', 'activity.sub_process_name column should exist');
select col_type_is(      'ggircs_swrs', 'activity', 'sub_process_name', 'character varying(1000)', 'activity.sub_process_name column should be type text');
select col_is_null(      'ggircs_swrs', 'activity', 'sub_process_name', 'activity.sub_process_name column should allow null');
select col_hasnt_default('ggircs_swrs', 'activity', 'sub_process_name', 'activity.sub_process_name column should not have a default value');

--  select has_column(       'ggircs_swrs', 'activity', 'information_requirement', 'activity.information_requirement column should exist');
select col_type_is(      'ggircs_swrs', 'activity', 'information_requirement', 'character varying(1000)', 'activity.information_requirement column should be type text');
select col_is_null(      'ggircs_swrs', 'activity', 'information_requirement', 'activity.information_requirement column should allow null');
select col_hasnt_default('ggircs_swrs', 'activity', 'information_requirement', 'activity.information_requirement column should not have a default value');

-- Insert data for fixture based testing
insert into ggircs_swrs.ghgr_import (xml_file) values ($$
<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
 <ActivityData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
   <ActivityPages>
     <Process ProcessName="GeneralStationaryCombustion">
       <SubProcess SubprocessName="(a) general stationary combustion, useful energy" InformationRequirement="Required" />
     </Process>
   </ActivityPages>
 </ActivityData>
</ReportData>
$$);

-- refresh necessary views with data
refresh materialized view ggircs_swrs.activity with data;

--  Test ghgr_import_id fk relation
select results_eq(
   $$
   select ghgr_import.id from ggircs_swrs.activity
   join ggircs_swrs.ghgr_import
   on
   activity.ghgr_import_id =  ghgr_import.id
   $$,

   'select id from ggircs_swrs.ghgr_import',

   'Foreign key ghgr_import_id ggircs_swrs_activity reference ggircs_swrs.ghgr_import'
   );

-- test the columns for matview facility have been properly parsed from xml
select results_eq(
  'select ghgr_import_id from ggircs_swrs.activity',
  'select id from ggircs_swrs.ghgr_import',
  'ggircs_swrs.activity.ghgr_import_id relates to ggircs_swrs.ghgr_import.id'
);
select results_eq(
  'select process_idx from ggircs_swrs.activity',
  ARRAY[0::integer],
  'ggircs_swrs.activity.process_idx is extracted'
);
select results_eq(
  'select sub_process_idx from ggircs_swrs.activity',
  ARRAY[0::integer],
  'ggircs_swrs.activity.sub_process_idx is extracted'
);
select results_eq(
  'select activity_name from ggircs_swrs.activity',
  ARRAY['ActivityPages'::varchar(1000)],
  'ggircs_swrs.activity.activity_name is extracted'
);
select results_eq(
  'select process_name from ggircs_swrs.activity',
  ARRAY['GeneralStationaryCombustion'::varchar(1000)],
  'ggircs_swrs.activity.process_name is extracted'
);
select results_eq(
  'select sub_process_name from ggircs_swrs.activity',
  ARRAY['(a) general stationary combustion, useful energy'::varchar(1000)],
  'ggircs_swrs.activity.sub_process_name is extracted'
);
select results_eq(
  'select information_requirement from ggircs_swrs.activity',
  ARRAY['Required'::varchar(1000)],
  'ggircs_swrs.activity.information_requirement is extracted'
);


select * from finish();
rollback;
