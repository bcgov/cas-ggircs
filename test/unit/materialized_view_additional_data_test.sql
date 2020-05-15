set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;


begin;
select plan(42);

select has_materialized_view(
    'swrs_transform', 'additional_data',
    'swrs_transform.additional_data should be a materialized view'
);

select has_index(
    'swrs_transform', 'additional_data', 'ggircs_additional_data_primary_key',
    'swrs_transform.additional_data should have a primary key'
);


select columns_are('swrs_transform'::name, 'additional_data'::name, array[
    'id'::name,
    'eccc_xml_file_id'::name,
    'activity_name'::name,
    'process_idx'::name,
    'sub_process_idx'::name,
    'grandparent_idx'::name,
    'parent_idx'::name,
    'class_idx'::name,
    'grandparent'::name,
    'parent'::name,
    'class'::name,
    'attribute'::name,
    'attr_value'::name,
    'node_value'::name
]);



select col_type_is(      'swrs_transform', 'additional_data', 'eccc_xml_file_id', 'integer', 'additional_data.eccc_xml_file_id column should be type integer');
select col_hasnt_default('swrs_transform', 'additional_data', 'eccc_xml_file_id', 'additional_data.eccc_xml_file_id column should not have a default value');

select col_type_is(      'swrs_transform', 'additional_data', 'activity_name', 'character varying(1000)', 'additional_data.activity_name column should be type text');
select col_hasnt_default('swrs_transform', 'additional_data', 'activity_name', 'additional_data.activity_name column should not have a default');

--  select col_is_null(      'swrs_transform', 'additional_data', 'process_idx', 'additional_data.process_idx column should allow null');
select col_type_is(      'swrs_transform', 'additional_data', 'process_idx', 'integer', 'additional_data.process_idx column should be type integer');
select col_hasnt_default('swrs_transform', 'additional_data', 'process_idx', 'additional_data.process_idx column should not have a default');

--  select col_is_null(      'swrs_transform', 'additional_data', 'sub_process_idx', 'additional_data.sub_process_idx column should allow null');
select col_type_is(      'swrs_transform', 'additional_data', 'sub_process_idx', 'integer', 'additional_data.sub_process_idx column should be type integer');
select col_hasnt_default('swrs_transform', 'additional_data', 'sub_process_idx', 'additional_data.sub_process_idx column should not have a default');

--  select col_is_null(      'swrs_transform', 'additional_data', 'grandparent_idx', 'additional_data.grandparent_idx column should allow null');
select col_type_is(      'swrs_transform', 'additional_data', 'grandparent_idx', 'integer', 'additional_data.grandparent_idx column should be type integer');
select col_hasnt_default('swrs_transform', 'additional_data', 'grandparent_idx', 'additional_data.grandparent_idx column should not have a default');

-- select col_is_null(      'swrs_transform', 'additional_data', 'parent_idx', 'additional_data.parent_idx column should allow null');
select col_type_is(      'swrs_transform', 'additional_data', 'parent_idx', 'integer', 'additional_data.parent_idx column should be type integer');
select col_hasnt_default('swrs_transform', 'additional_data', 'parent_idx', 'additional_data.parent_idx column should not have a default');

select col_type_is(      'swrs_transform', 'additional_data', 'class_idx', 'integer', 'additional_data.class_idx column should be type integer');
select col_hasnt_default('swrs_transform', 'additional_data', 'class_idx', 'additional_data.class_idx column should not have a default');

select col_type_is(      'swrs_transform', 'additional_data', 'grandparent', 'character varying(1000)', 'additional_data.grandparent column should be type text');
select col_hasnt_default('swrs_transform', 'additional_data', 'grandparent', 'additional_data.grandparent column should not have a default');

select col_type_is(      'swrs_transform', 'additional_data', 'parent', 'character varying(1000)', 'additional_data.parent column should be type text');
select col_hasnt_default('swrs_transform', 'additional_data', 'parent', 'additional_data.parent column should not have a default');

select col_type_is(      'swrs_transform', 'additional_data', 'class', 'character varying(1000)', 'additional_data.class column should be type text');
select col_hasnt_default('swrs_transform', 'additional_data', 'class', 'additional_data.class column should not have a default');

select col_type_is(      'swrs_transform', 'additional_data', 'attribute', 'character varying(1000)', 'additional_data.attribute column should be type text');
select col_hasnt_default('swrs_transform', 'additional_data', 'attribute', 'additional_data.attribute column should not have a default');

select col_type_is(      'swrs_transform', 'additional_data', 'attr_value', 'character varying(10000)', 'additional_data.attr_value column should be type text');
select col_hasnt_default('swrs_transform', 'additional_data', 'attr_value', 'additional_data.attr_value column should not have a default');

select col_type_is(      'swrs_transform', 'additional_data', 'node_value', 'character varying(10000)', 'additional_data.node_value column should be type text');
select col_hasnt_default('swrs_transform', 'additional_data', 'node_value', 'additional_data.node_value column should not have a default');


-- Insert data for fixture based testing

insert into swrs_extract.eccc_xml_file (xml_file) values ($$
<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <ActivityData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <ActivityPages>
      <Process xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ProcessName="LimeManufacturing">
          <SubProcess SubprocessName="Mandatory additional reportable information" InformationRequirement="MandatoryAdditional">
            <MonthlyDetailByLimeType>
              <LimeMonthlyDetails></LimeMonthlyDetails>
              <LimeMonthlyDetails>
                <LimeTypeName>Quicklime</LimeTypeName>
                <LimeMonthlyDetail>
                  <LimeTypeMonths>
                    <Amount AmtDomain="Lime" AmtAction="Produced" AmtPeriod="Monthly">2918.22</Amount>
                  </LimeTypeMonths>
                </LimeMonthlyDetail>
              </LimeMonthlyDetails>
            </MonthlyDetailByLimeType>
            <NumberOfTimesMissingDataProcedures>40</NumberOfTimesMissingDataProcedures>
          </SubProcess>
      </Process>
    </ActivityPages>
    <ProcessFlowDiagram>
      <Process></Process>
      <Process ProcessName="ProcessFlowDiagram">
        <SubProcess></SubProcess>
        <SubProcess SubprocessName="A Process Flow Diagram is required for SFO and LFO (Parent) reports" InformationRequirement="Required">
          <FileDetails>
            <File>42</File>
            <UploadedFileName>all_our_base.pdf</UploadedFileName>
          </FileDetails>
        </SubProcess>
      </Process>
    </ProcessFlowDiagram>
  </ActivityData>
</ReportData>
$$);

refresh materialized view swrs_transform.additional_data with data;

--  Test eccc_xml_file_id fk relation
select results_eq(
    $$
    select eccc_xml_file.id from swrs_transform.additional_data
    join swrs_extract.eccc_xml_file
    on
    additional_data.eccc_xml_file_id =  eccc_xml_file.id
    and class='Amount'
    $$,

    'select id from swrs_extract.eccc_xml_file',

    'Foreign key eccc_xml_file_id ggircs_swrs_additional_data reference swrs_extract.eccc_xml_file'
);

-- test the columns for matview additional_datas have been properly parsed from xml
select results_eq(
  $$ select eccc_xml_file_id from swrs_transform.additional_data where class='Amount' $$,
  'select id from swrs_extract.eccc_xml_file',
  'swrs_transform.additional_data.eccc_xml_file_id relates to swrs_extract.eccc_xml_file.id'
);

-- test that root level additional_datas being extracted
select results_eq(
  $$ select node_value from swrs_transform.additional_data where class='NumberOfTimesMissingDataProcedures' $$,
  Array['40'::varchar],
  'swrs_transform.additional_data.node_value is extracted where class is NumberOfTimesMissingDataProcedures'
);

-- test that medium level additional_datas being extracted
select results_eq(
  $$ select node_value from swrs_transform.additional_data where class='LimeTypeName' $$,
  Array['Quicklime'::varchar],
  'swrs_transform.additional_data.node_value is extracted where class is LimeTypeName'
);

-- test that medium level additional_datas have the right parent
select results_eq(
  $$ select parent from swrs_transform.additional_data where class='LimeTypeName' $$,
  Array['LimeMonthlyDetails'::varchar],
  'swrs_transform.additional_data.parent is extracted where class is LimeTypeName'
);

-- test that mutiple activity_names are being created based on child of ReportData (e.g. ActivityPages, ProcessFlowDiagram etc.)
select results_eq(
  $$ select activity_name from swrs_transform.additional_data where class='UploadedFileName' $$,
  Array['ProcessFlowDiagram'::varchar],
  'swrs_transform.additional_data.activity_name is extracted where class is UploadedFileName'
);

-- test that values in the ProcessFlowDiagram activity_name is extracted
select results_eq(
  $$ select node_value from swrs_transform.additional_data where class='UploadedFileName' $$,
  Array['all_our_base.pdf'::varchar],
  'swrs_transform.additional_data.node_value is extracted where class is UploadedFileName'
);

-- test that process_idx is being generated properly when multiple preciding siblings
select results_eq(
  $$ select process_idx from swrs_transform.additional_data where class='UploadedFileName' $$,
  Array[1::integer],
  'swrs_transform.additional_data.process_idx is extracted where class is UploadedFileName'
);

-- test that sub_process_idx is being generated properly when multiple preciding siblings
select results_eq(
  $$ select sub_process_idx from swrs_transform.additional_data where class='UploadedFileName' $$,
  Array[1::integer],
  'swrs_transform.additional_data.sub_process_idx is extracted where class is UploadedFileName'
);

-- test that parent_idx is being generated properly when multiple preciding siblings
select results_eq(
  $$ select parent_idx from swrs_transform.additional_data where class='LimeTypeName' $$,
  Array[0::integer],
  'swrs_transform.additional_data.process_idx is extracted where class is LimeTypeName'
);

-- test that grandparent_idx is being generated properly when multiple preciding siblings
select results_eq(
  $$ select grandparent_idx from swrs_transform.additional_data where class='LimeTypeName' $$,
  Array[1::integer],
  'swrs_transform.additional_data.process_idx is extracted where class is LimeTypeName'
);

-- test that sub_process_idx is being generated properly when multiple preciding siblings
select results_eq(
  $$ select sub_process_idx from swrs_transform.additional_data where class='UploadedFileName' $$,
  Array[1::integer],
  'swrs_transform.additional_data.sub_process_idx is extracted where class is UploadedFileName'
);

-- test that multi-attribute concatenation is working
select results_eq(
  $$ select node_value from swrs_transform.additional_data where attr_value like '%Lime Produced Monthly%' $$,
  Array['2918.22'::varchar],
  'swrs_transform.additional_data.sub_process_idx is extracted where class is Lime Produced Monthly'
);

select * from finish();
rollback;
