set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;

select plan(6);

select has_materialized_view(
    'swrs_transform', 'eio_emission',
    'swrs_transform.eio_emission should be a materialized view'
);

select has_index(
    'swrs_transform', 'eio_emission', 'ggircs_eio_emission_primary_key',
    'swrs_transform.eio_emission should have a primary key'
);

select columns_are('swrs_transform'::name, 'emission'::name, array[
    'id'::name,
    'eccc_xml_file_id'::name,
    'activity_name'::name,
    'sub_activity_name'::name,
    'unit_name'::name,
    'sub_unit_name'::name,
    'process_idx'::name,
    'sub_process_idx'::name,
    'units_idx'::name,
    'unit_idx'::name,
    'substances_idx'::name,
    'substance_idx'::name,
    'fuel_idx'::name,
    'fuel_name'::name,
    'emissions_idx'::name,
    'emission_idx'::name,
    'emission_type'::name,
    'gas_type'::name,
    'methodology'::name,
    'not_applicable'::name,
    'quantity'::name,
    'calculated_quantity'::name,
    'emission_category'::name
]);

-- Insert data for fixture based testing
insert into swrs_extract.eccc_xml_file (xml_file) values ($$
<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <ReportDetails>
    <ReportType>eio</ReportType>
  </ReportDetails>
  <ActivityData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <ActivityPages>
      <Process ProcessName="ElectricityImportOperation">
        <SubProcess SubprocessName="Electricity Import: Emissions from unspecified sources" InformationRequirement="Optional">
          <Units>
            <Unit>
              <Fuels>
                <Fuel>
                  <EIOEmissions>
                    <EIOEmission>
                      <NotApplicable>false</NotApplicable>
                      <EIOElectricityAmount>12345</EIOElectricityAmount>
                      <EIOEmissionAmount>99999</EIOEmissionAmount>
                    </EIOEmission>
                  </EIOEmissions>
                </Fuel>
              </Fuels>
            </Unit>
          </Units>
        </SubProcess>
        <SubProcess SubprocessName="Electricity Export: Emissions from specified sources" InformationRequirement="Optional">
          <Units>
            <Unit>
              <Fuels>
                <Fuel>
                  <EIOEmissions>
                    <EIOEmission>
                      <NotApplicable>true</NotApplicable>
                      <EIOElectricityAmount>54321</EIOElectricityAmount>
                      <EIOEmissionAmount>88888</EIOEmissionAmount>
                    </EIOEmission>
                  </EIOEmissions>
                </Fuel>
              </Fuels>
            </Unit>
          </Units>
        </SubProcess>
      </Process>
    </ActivityPages>
  </ActivityData>
</ReportData>
$$);


-- refresh necessary views with data
refresh materialized view swrs_transform.eio_emission with data;

select * from swrs_transform.eio_emission;

select is(
  (select count(*) from swrs_transform.eio_emission),
  2::bigint,
  'swrs_transform.eio_emission has 2 rows'
);

-- ElectricityAmount
select results_eq(
  $$ select quantity from swrs_transform.eio_emission where emission_idx=0 $$,
  $$
    values(99999::numeric), (88888::numeric)
  $$,
  'swrs_transform.eio_emission.quantity is extracted'
);

-- Quantity
select results_eq(
  $$ select electricity_amount from swrs_transform.eio_emission where emission_idx=0 $$,
  $$
  values (12345::numeric), (54321::numeric)
  $$,
  'swrs_transform.eio_emission.quantity is extracted'
);

select * from finish();
rollback;
