set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(28);

select has_materialized_view(
    'swrs_transform', 'activity',
    'swrs_transform.activity should be a materialized view'
);

select has_index(
    'swrs_transform', 'activity', 'ggircs_activity_primary_key',
    'swrs_transform.activity should have a primary key'
);

select columns_are('swrs_transform'::name, 'activity'::name, array[
    'id'::name,
    'eccc_xml_file_id'::name,
    'process_idx'::name,
    'sub_process_idx'::name,
    'activity_name'::name,
    'process_name'::name,
    'sub_process_name'::name,
    'information_requirement'::name
]);

--  select has_column(       'swrs_transform', 'activity', 'eccc_xml_file_id', 'activity.eccc_xml_file_id column should exist');
select col_type_is(      'swrs_transform', 'activity', 'eccc_xml_file_id', 'integer', 'activity.eccc_xml_file_id column should be type integer');
select col_hasnt_default('swrs_transform', 'activity', 'eccc_xml_file_id', 'activity.eccc_xml_file_id column should not have a default value');

--  select has_column(       'swrs_transform', 'activity', 'process_idx', 'activity.process_idx column should exist');
select col_type_is(      'swrs_transform', 'activity', 'process_idx', 'integer', 'activity.process_idx column should be type integer');
--  select col_is_null(      'swrs_transform', 'activity', 'process_idx', 'activity.process_idx column should allow null');
select col_hasnt_default('swrs_transform', 'activity', 'process_idx', 'activity.process_idx column should not have a default');

--  select has_column(       'swrs_transform', 'activity', 'sub_process_idx', 'activity.sub_process_idx column should exist');
select col_type_is(      'swrs_transform', 'activity', 'sub_process_idx', 'integer', 'activity.sub_process_idx column should be type integer');
--  select col_is_null(      'swrs_transform', 'activity', 'sub_process_idx', 'activity.sub_process_idx column should allow null');
select col_hasnt_default('swrs_transform', 'activity', 'sub_process_idx', 'activity.sub_process_idx column should not have a default');

--  select has_column(       'swrs_transform', 'activity', 'activity_name', 'activity.activity_name column should exist');
select col_type_is(      'swrs_transform', 'activity', 'activity_name', 'character varying(1000)', 'activity.activity_name column should be type text');
--  select col_is_null(      'swrs_transform', 'activity', 'activity_name', 'activity.activity_name column should allow null');
select col_hasnt_default('swrs_transform', 'activity', 'activity_name', 'activity.activity_name column should not have a default');

--  select has_column(       'swrs_transform', 'activity', 'process_name', 'activity.process_name column should exist');
select col_type_is(      'swrs_transform', 'activity', 'process_name', 'character varying(1000)', 'activity.process_name column should be type text');
select col_is_null(      'swrs_transform', 'activity', 'process_name', 'activity.process_name column should allow null');
select col_hasnt_default('swrs_transform', 'activity', 'process_name', 'activity.process_name column should not  have a default');

--  select has_column(       'swrs_transform', 'activity', 'sub_process_name', 'activity.sub_process_name column should exist');
select col_type_is(      'swrs_transform', 'activity', 'sub_process_name', 'character varying(1000)', 'activity.sub_process_name column should be type text');
select col_is_null(      'swrs_transform', 'activity', 'sub_process_name', 'activity.sub_process_name column should allow null');
select col_hasnt_default('swrs_transform', 'activity', 'sub_process_name', 'activity.sub_process_name column should not have a default value');

--  select has_column(       'swrs_transform', 'activity', 'information_requirement', 'activity.information_requirement column should exist');
select col_type_is(      'swrs_transform', 'activity', 'information_requirement', 'character varying(1000)', 'activity.information_requirement column should be type text');
select col_is_null(      'swrs_transform', 'activity', 'information_requirement', 'activity.information_requirement column should allow null');
select col_hasnt_default('swrs_transform', 'activity', 'information_requirement', 'activity.information_requirement column should not have a default value');

-- Insert data for fixture based testing
insert into swrs_extract.eccc_xml_file (xml_file) values ($$
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
refresh materialized view swrs_transform.activity with data;

--  Test eccc_xml_file_id fk relation
select results_eq(
   $$
   select eccc_xml_file.id from swrs_transform.activity
   join swrs_extract.eccc_xml_file
   on
   activity.eccc_xml_file_id =  eccc_xml_file.id
   $$,

   'select id from swrs_extract.eccc_xml_file',

   'Foreign key eccc_xml_file_id ggircs_swrs_activity reference swrs_extract.eccc_xml_file'
   );

-- test the columns for matview facility have been properly parsed from xml
select results_eq(
  'select eccc_xml_file_id from swrs_transform.activity',
  'select id from swrs_extract.eccc_xml_file',
  'swrs_transform.activity.eccc_xml_file_id relates to swrs_extract.eccc_xml_file.id'
);
select results_eq(
  'select process_idx from swrs_transform.activity',
  ARRAY[0::integer],
  'swrs_transform.activity.process_idx is extracted'
);
select results_eq(
  'select sub_process_idx from swrs_transform.activity',
  ARRAY[0::integer],
  'swrs_transform.activity.sub_process_idx is extracted'
);
select results_eq(
  'select activity_name from swrs_transform.activity',
  ARRAY['ActivityPages'::varchar(1000)],
  'swrs_transform.activity.activity_name is extracted'
);
select results_eq(
  'select process_name from swrs_transform.activity',
  ARRAY['GeneralStationaryCombustion'::varchar(1000)],
  'swrs_transform.activity.process_name is extracted'
);
select results_eq(
  'select sub_process_name from swrs_transform.activity',
  ARRAY['(a) general stationary combustion, useful energy'::varchar(1000)],
  'swrs_transform.activity.sub_process_name is extracted'
);
select results_eq(
  'select information_requirement from swrs_transform.activity',
  ARRAY['Required'::varchar(1000)],
  'swrs_transform.activity.information_requirement is extracted'
);


select * from finish();
rollback;
