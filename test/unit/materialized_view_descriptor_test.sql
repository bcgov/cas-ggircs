set client_min_messages to warning;
create extension if not exists pgtap;
reset client_min_messages;


begin;
select plan(41);

select has_materialized_view(
    'ggircs_swrs', 'descriptor',
    'ggircs_swrs.descriptor should be a materialized view'
);

select has_index(
    'ggircs_swrs', 'descriptor', 'ggircs_descriptor_primary_key',
    'ggircs_swrs.descriptor should have a primary key'
);


select columns_are('ggircs_swrs'::name, 'descriptor'::name, array[
    'ghgr_import_id'::name,
    'context'::name,
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



select col_type_is(      'ggircs_swrs', 'descriptor', 'ghgr_import_id', 'integer', 'descriptor.ghgr_import_id column should be type integer');
select col_hasnt_default('ggircs_swrs', 'descriptor', 'ghgr_import_id', 'descriptor.ghgr_import_id column should not have a default value');

select col_type_is(      'ggircs_swrs', 'descriptor', 'context', 'character varying(1000)', 'descriptor.context column should be type text');
select col_hasnt_default('ggircs_swrs', 'descriptor', 'context', 'descriptor.context column should not have a default');

--  select col_is_null(      'ggircs_swrs', 'descriptor', 'process_idx', 'descriptor.process_idx column should allow null');
select col_type_is(      'ggircs_swrs', 'descriptor', 'process_idx', 'integer', 'descriptor.process_idx column should be type integer');
select col_hasnt_default('ggircs_swrs', 'descriptor', 'process_idx', 'descriptor.process_idx column should not have a default');

--  select col_is_null(      'ggircs_swrs', 'descriptor', 'sub_process_idx', 'descriptor.sub_process_idx column should allow null');
select col_type_is(      'ggircs_swrs', 'descriptor', 'sub_process_idx', 'integer', 'descriptor.sub_process_idx column should be type integer');
select col_hasnt_default('ggircs_swrs', 'descriptor', 'sub_process_idx', 'descriptor.sub_process_idx column should not have a default');

--  select col_is_null(      'ggircs_swrs', 'descriptor', 'grandparent_idx', 'descriptor.grandparent_idx column should allow null');
select col_type_is(      'ggircs_swrs', 'descriptor', 'grandparent_idx', 'integer', 'descriptor.grandparent_idx column should be type integer');
select col_hasnt_default('ggircs_swrs', 'descriptor', 'grandparent_idx', 'descriptor.grandparent_idx column should not have a default');

-- select col_is_null(      'ggircs_swrs', 'descriptor', 'parent_idx', 'descriptor.parent_idx column should allow null');
select col_type_is(      'ggircs_swrs', 'descriptor', 'parent_idx', 'integer', 'descriptor.parent_idx column should be type integer');
select col_hasnt_default('ggircs_swrs', 'descriptor', 'parent_idx', 'descriptor.parent_idx column should not have a default');

select col_type_is(      'ggircs_swrs', 'descriptor', 'class_idx', 'integer', 'descriptor.class_idx column should be type integer');
select col_hasnt_default('ggircs_swrs', 'descriptor', 'class_idx', 'descriptor.class_idx column should not have a default');

select col_type_is(      'ggircs_swrs', 'descriptor', 'grandparent', 'character varying(1000)', 'descriptor.grandparent column should be type text');
select col_hasnt_default('ggircs_swrs', 'descriptor', 'grandparent', 'descriptor.grandparent column should not have a default');

select col_type_is(      'ggircs_swrs', 'descriptor', 'parent', 'character varying(1000)', 'descriptor.parent column should be type text');
select col_hasnt_default('ggircs_swrs', 'descriptor', 'parent', 'descriptor.parent column should not have a default');

select col_type_is(      'ggircs_swrs', 'descriptor', 'class', 'character varying(1000)', 'descriptor.class column should be type text');
select col_hasnt_default('ggircs_swrs', 'descriptor', 'class', 'descriptor.class column should not have a default');

select col_type_is(      'ggircs_swrs', 'descriptor', 'attribute', 'character varying(1000)', 'descriptor.attribute column should be type text');
select col_hasnt_default('ggircs_swrs', 'descriptor', 'attribute', 'descriptor.attribute column should not have a default');

select col_type_is(      'ggircs_swrs', 'descriptor', 'attr_value', 'character varying(1000)', 'descriptor.attr_value column should be type text');
select col_hasnt_default('ggircs_swrs', 'descriptor', 'attr_value', 'descriptor.attr_value column should not have a default');

select col_type_is(      'ggircs_swrs', 'descriptor', 'node_value', 'character varying(1000)', 'descriptor.node_value column should be type text');
select col_hasnt_default('ggircs_swrs', 'descriptor', 'node_value', 'descriptor.node_value column should not have a default');


-- Insert data for fixture based testing

insert into ggircs_swrs.ghgr_import (xml_file) values ($$
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

refresh materialized view ggircs_swrs.descriptor with data;

-- test the columns for matview descriptors have been properly parsed from xml
select results_eq(
  $$ select ghgr_import_id from ggircs_swrs.descriptor where class='Amount' $$,
  'select id from ggircs_swrs.ghgr_import',
  'ggircs_swrs.descriptor.ghgr_import_id relates to ggircs_swrs.ghgr_import.id'
);

-- test that root level descriptors being extracted
select results_eq(
  $$select node_value from ggircs_swrs.descriptor where class='NumberOfTimesMissingDataProcedures' $$,
  Array['40'::varchar],
  'ggircs_swrs.descriptor.node_value is extracted where class is NumberOfTimesMissingDataProcedures'
);

-- test that medium level descriptors being extracted
select results_eq(
  $$select node_value from ggircs_swrs.descriptor where class='LimeTypeName' $$,
  Array['Quicklime'::varchar],
  'ggircs_swrs.descriptor.node_value is extracted where class is LimeTypeName'
);

-- test that medium level descriptors have the right parent
select results_eq(
  $$select parent from ggircs_swrs.descriptor where class='LimeTypeName' $$,
  Array['LimeMonthlyDetails'::varchar],
  'ggircs_swrs.descriptor.parent is extracted where class is LimeTypeName'
);

-- test that mutiple contexts are being created based on child of ReportData (e.g. ActivityPages, ProcessFlowDiagram etc.)
select results_eq(
  $$select context from ggircs_swrs.descriptor where class='UploadedFileName' $$,
  Array['ProcessFlowDiagram'::varchar],
  'ggircs_swrs.descriptor.context is extracted where class is UploadedFileName'
);

-- test that values in the ProcessFlowDiagram context is extracted
select results_eq(
  $$select node_value from ggircs_swrs.descriptor where class='UploadedFileName' $$,
  Array['all_our_base.pdf'::varchar],
  'ggircs_swrs.descriptor.node_value is extracted where class is UploadedFileName'
);

-- test that process_idx is being generated properly when multiple preciding siblings
select results_eq(
  $$select process_idx from ggircs_swrs.descriptor where class='UploadedFileName' $$,
  Array[1::integer],
  'ggircs_swrs.descriptor.process_idx is extracted where class is UploadedFileName'
);

-- test that sub_process_idx is being generated properly when multiple preciding siblings
select results_eq(
  $$select sub_process_idx from ggircs_swrs.descriptor where class='UploadedFileName' $$,
  Array[1::integer],
  'ggircs_swrs.descriptor.sub_process_idx is extracted where class is UploadedFileName'
);

-- test that parent_idx is being generated properly when multiple preciding siblings
select results_eq(
  $$select parent_idx from ggircs_swrs.descriptor where class='LimeTypeName' $$,
  Array[0::integer],
  'ggircs_swrs.descriptor.process_idx is extracted where class is LimeTypeName'
);

-- test that grandparent_idx is being generated properly when multiple preciding siblings
select results_eq(
  $$select grandparent_idx from ggircs_swrs.descriptor where class='LimeTypeName' $$,
  Array[1::integer],
  'ggircs_swrs.descriptor.process_idx is extracted where class is LimeTypeName'
);

-- test that sub_process_idx is being generated properly when multiple preciding siblings
select results_eq(
  $$select sub_process_idx from ggircs_swrs.descriptor where class='UploadedFileName' $$,
  Array[1::integer],
  'ggircs_swrs.descriptor.sub_process_idx is extracted where class is UploadedFileName'
);

-- test that multi-attribute concatenation is working
select results_eq(
  $$select node_value from ggircs_swrs.descriptor where attr_value like '%Lime Produced Monthly%' $$,
  Array['2918.22'::varchar],
  'ggircs_swrs.descriptor.sub_process_idx is extracted where class is Lime Produced Monthly'
);

select * from finish();
rollback;

