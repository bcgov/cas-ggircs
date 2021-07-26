set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;

select plan(9);

select has_materialized_view(
    'swrs_transform', 'r3_emission',
    'swrs_transform.r3_emission should be a materialized view'
);

select has_index(
    'swrs_transform', 'r3_emission', 'ggircs_r3_emission_primary_key',
    'swrs_transform.r3_emission should have a primary key'
);

select columns_are('swrs_transform'::name, 'r3_emission'::name, array[
    'id'::name,
    'eccc_xml_file_id'::name,
    'activity_name'::name,
    'emissions_idx'::name,
    'emission_idx'::name,
    'gas_type'::name,
    'quantity'::name,
    'calculated_quantity'::name,
    'cas_number'::name
]);

-- Insert data for fixture based testing
insert into swrs_extract.eccc_xml_file (xml_file) values ($$
<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <ReportDetails>
    <ReportType>R3</ReportType>
  </ReportDetails>
  <ActivityData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <TotalAttributableEmissions>
      <TotalGroups TotalGroupType="TotalAttribEmissions">
        <Totals>
          <Emissions EmissionsGasType="AttributableEmissions">
            <TotalRow>
              <Quantity>7437.645</Quantity>
              <CalculatedQuantity>7437.645</CalculatedQuantity>
              <CasNumber> 124-38-9</CasNumber>
              <GasName>CO2 nonbio</GasName>
            </TotalRow>
            <TotalRow>
              <Quantity>1.89</Quantity>
              <CalculatedQuantity>47.25</CalculatedQuantity>
              <CasNumber>74-82-8</CasNumber>
              <GasName>CH4</GasName>
            </TotalRow>
            <TotalRow>
              <Quantity>0.19</Quantity>
              <CalculatedQuantity>56.62</CalculatedQuantity>
              <CasNumber>10024-97-2</CasNumber>
              <GasName>N2O</GasName>
            </TotalRow>
            <GrandTotal>
              <Total>7541.515</Total>
            </GrandTotal>
          </Emissions>
        </Totals>
      </TotalGroups>
    </TotalAttributableEmissions>
  </ActivityData>
</ReportData>

$$);

insert into swrs_extract.eccc_xml_file (xml_file) values ($$
<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <ReportDetails>
    <ReportType>R1</ReportType>
  </ReportDetails>
  <ActivityData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <TotalAttributableEmissions>
      <TotalGroups TotalGroupType="TotalAttribEmissions">
        <Totals>
          <Emissions EmissionsGasType="AttributableEmissions">
            <TotalRow>
              <Quantity>9999</Quantity>
              <CalculatedQuantity>9999</CalculatedQuantity>
              <CasNumber>124-38-9</CasNumber>
              <GasName>do not parse</GasName>
            </TotalRow>
          </Emissions>
        </Totals>
      </TotalGroups>
    </TotalAttributableEmissions>
  </ActivityData>
</ReportData>

$$);


-- refresh necessary views with data
refresh materialized view swrs_transform.r3_emission with data;

select is(
  (select count(*) from swrs_transform.r3_emission),
  3::bigint,
  'swrs_transform.r3_emission has 3 rows'
);

-- Extract gas_type
select results_eq(
  $$ select gas_type from swrs_transform.r3_emission where emission_idx=0 $$,
   $$ values('CO2nonbio'::varchar(1000)) $$,
  'swrs_transform.r3_emission.gas_type is extracted'
);

-- Extract gas_type
select results_eq(
  $$ select quantity from swrs_transform.r3_emission where emission_idx=1 $$,
   $$ values(1.89::numeric) $$,
  'swrs_transform.r3_emission.quantity is extracted'
);

-- Extract gas_type
select results_eq(
  $$ select calculated_quantity from swrs_transform.r3_emission where emission_idx=2 $$,
   $$ values(56.62::numeric) $$,
  'swrs_transform.r3_emission.calculated_quantity is extracted'
);

-- Extract gas_type
select results_eq(
  $$ select cas_number from swrs_transform.r3_emission where emission_idx=0 $$,
   $$ values('124-38-9'::varchar(1000)) $$,
  'swrs_transform.r3_emission.cas_number is extracted'
);

select is_empty(
  $$ select * from swrs_transform.r3_emission where gas_type = 'donotparse' $$,
  'swrs_transform.r3_emission only parses data from R3 reports'
);

select * from finish();
rollback;
