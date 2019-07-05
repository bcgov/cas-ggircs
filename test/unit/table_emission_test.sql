set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select * from no_plan();

insert into ggircs_swrs.ghgr_import (xml_file) values ($$
<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <RegistrationData>
    <Organisation>
      <Details>
        <BusinessLegalName>Bart Simpson</BusinessLegalName>
        <EnglishTradeName>Bart Simpson</EnglishTradeName>
        <FrenchTradeName/>
        <CRABusinessNumber>12345</CRABusinessNumber>
        <DUNSNumber>0</DUNSNumber>
        <WebSite>www.nhl.com</WebSite>
      </Details>
    </Organisation>
    <Facility>
      <Details>
        <FacilityName>fname</FacilityName>
        <RelationshipType>Owned and Operated</RelationshipType>
        <PortabilityIndicator>N</PortabilityIndicator>
        <Status>Active</Status>
      </Details>
      <Identifiers>
        <IdentifierList>
          <Identifier>
            <IdentifierType>BCGHGID</IdentifierType>
            <IdentifierValue>RD_123456</IdentifierValue>
          </Identifier>
          <Identifier>
            <IdentifierType>GHGRP Identification Number</IdentifierType>
            <IdentifierValue>654321</IdentifierValue>
          </Identifier>
          <Identifier>
            <IdentifierType>National Emission Reduction Masterplan</IdentifierType>
            <IdentifierValue>1234</IdentifierValue>
          </Identifier>
          <Identifier>
            <IdentifierType>National Pollutant Release Inventory Identifier</IdentifierType>
            <IdentifierValue>0000</IdentifierValue>
          </Identifier>
        </IdentifierList>
        <NAICSCodeList>
          <NAICSCode>
            <NAICSClassification>Chemical Pulp Mills </NAICSClassification>
            <Code>721310</Code>
            <NaicsPriority>Primary</NaicsPriority>
          </NAICSCode>
        </NAICSCodeList>
        <Permits>
          <Permit>
            <IssuingAgency>British Columbia</IssuingAgency>
            <PermitNumber>0000</PermitNumber>
          </Permit>
        </Permits>
      </Identifiers>
    </Facility>
  </RegistrationData>
  <ReportDetails>
    <ReportID>1234</ReportID>
    <ReportType>R1</ReportType>
    <FacilityId>0000</FacilityId>
    <FacilityType>EIO</FacilityType>
    <OrganisationId>0000</OrganisationId>
    <ReportingPeriodDuration>2025</ReportingPeriodDuration>
    <ReportStatus>
      <Status>Submitted</Status>
      <SubmissionDate>2013-03-27T19:25:55.32</SubmissionDate>
      <LastModifiedBy>Buddy</LastModifiedBy>
    </ReportStatus>
  </ReportDetails>
  <OperationalWorkerReport/>
  <VerifyTombstone>
    <Organisation>
      <Details>
        <BusinessLegalName>Bart Simpson</BusinessLegalName>
        <EnglishTradeName>Bart Simpson</EnglishTradeName>
        <CRABusinessNumber>123456778</CRABusinessNumber>
        <DUNSNumber>00-000-0000</DUNSNumber>
      </Details>
    </Organisation>
    <Facility>
      <Details>
        <FacilityName>Bart Simpson</FacilityName>
        <Identifiers>
          <IdentifierList>
            <Identifier>
              <IdentifierType>NPRI</IdentifierType>
              <IdentifierValue>12345</IdentifierValue>
            </Identifier>
            <Identifier>
              <IdentifierType>BCGHGID</IdentifierType>
              <IdentifierValue>VT_12345</IdentifierValue>
            </Identifier>
          </IdentifierList>
          <NAICSCodeList>
            <NAICSCode>
              <Code>721310</Code>
            </NAICSCode>
          </NAICSCodeList>
        </Identifiers>
      </Details>
    </Facility>
    <ParentOrganisations/>
  </VerifyTombstone>
  <ActivityData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <ActivityPages>
      <Process ProcessName="ElectricityGeneration">
        <SubProcess SubprocessName="Emissions from fuel combustion for electricity generation" InformationRequirement="Required">
          <Units UnitType="Cogen Units">
            <Unit>
              <COGenUnit>
                <CogenUnitName>Boiler 16 - hog fuel</CogenUnitName>
                <NameplateCapacity>5.9</NameplateCapacity>
                <NetPower>30165</NetPower>
                <CycleType>Topping</CycleType>
                <ThermalOutputQuantity>886917960</ThermalOutputQuantity>
                <SupplementalFiringPurpose>Electr. Generation</SupplementalFiringPurpose>
              </COGenUnit>
              <Fuels>
                <Fuel>
                  <FuelType>Wood Waste</FuelType>
                  <FuelClassification>Biomass in Schedule C</FuelClassification>
                  <FuelDescription/>
                  <FuelUnits>bone dry tonnes</FuelUnits>
                  <AnnualFuelAmount>0</AnnualFuelAmount>
                  <AnnualSteamGeneration>290471000</AnnualSteamGeneration>
                  <MeasuredEmissionFactors>
                    <MeasuredEmissionFactor>
                      <MeasuredEmissionFactorGas>CO2</MeasuredEmissionFactorGas>
                      <MeasuredEmissionFactorAmount>50000</MeasuredEmissionFactorAmount>
                      <MeasuredEmissionFactorUnitType>g/GJ</MeasuredEmissionFactorUnitType>
                    </MeasuredEmissionFactor>
                    <MeasuredEmissionFactor>
                      <MeasuredEmissionFactorGas>CH4</MeasuredEmissionFactorGas>
                      <MeasuredEmissionFactorAmount>0.966</MeasuredEmissionFactorAmount>
                      <MeasuredEmissionFactorUnitType>g/GJ</MeasuredEmissionFactorUnitType>
                    </MeasuredEmissionFactor>
                  </MeasuredEmissionFactors>
                  <Emissions>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>168038.5773</Quantity>
                      <CalculatedQuantity>168038.5773</CalculatedQuantity>
                      <GasType>CO2bioC</GasType>
                      <Methodology>Methodology 3 (measured CC/Steam)</Methodology>
                    </Emission>
                  </Emissions>
                  <AlternativeMethodologyDescription/>
                </Fuel>
                <Fuel>
                  <FuelType>Residual Fuel Oil (#5 &amp; 6)</FuelType>
                  <FuelClassification>non-biomass</FuelClassification>
                  <FuelDescription/>
                  <FuelUnits>kilolitres</FuelUnits>
                  <AnnualFuelAmount>9441</AnnualFuelAmount>
                  <AnnualWeightedAverageCarbonContent>0.862</AnnualWeightedAverageCarbonContent>
                  <Emissions>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>29819.5973</Quantity>
                      <CalculatedQuantity>29819.5973</CalculatedQuantity>
                      <GasType>CO2nonbio</GasType>
                      <Methodology>Methodology 3 (measured CC/Steam)</Methodology>
                    </Emission>
                  </Emissions>
                  <AlternativeMethodologyDescription/>
                </Fuel>
              </Fuels>
            </Unit>
          </Units>
        </SubProcess>
      </Process>
      <Process>
        <SubProcess SubprocessName="Additional Reportable Information as per WCI.352(i)(1)-(12)" InformationRequirement="MandatoryAdditional">
          <Amount AmtDomain="PulpAndPaperBlackLiquor" AmtAction="Combusted" AmtPeriod="Annual">168389</Amount>
          <PercentSolidsByWeight>53</PercentSolidsByWeight>
          <PulpAndPaperCarbonates/>
        </SubProcess>
      </Process>
    </ActivityPages>
  </ActivityData>
</ReportData>
$$), ($$
<ReportData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <RegistrationData>
    <Organisation>
      <Details>
        <BusinessLegalName>Bart Simpson</BusinessLegalName>
        <EnglishTradeName>Bart Simpson</EnglishTradeName>
        <FrenchTradeName/>
        <CRABusinessNumber>12345</CRABusinessNumber>
        <DUNSNumber>0</DUNSNumber>
        <WebSite>www.nhl.com</WebSite>
      </Details>
    </Organisation>
    <Facility>
      <Details>
        <FacilityName>fname</FacilityName>
        <RelationshipType>Owned and Operated</RelationshipType>
        <PortabilityIndicator>N</PortabilityIndicator>
        <Status>Active</Status>
      </Details>
      <Identifiers>
        <IdentifierList>
          <Identifier>
            <IdentifierType>BCGHGID</IdentifierType>
            <IdentifierValue>RD_123456</IdentifierValue>
          </Identifier>
          <Identifier>
            <IdentifierType>GHGRP Identification Number</IdentifierType>
            <IdentifierValue>654321</IdentifierValue>
          </Identifier>
          <Identifier>
            <IdentifierType>National Emission Reduction Masterplan</IdentifierType>
            <IdentifierValue>1234</IdentifierValue>
          </Identifier>
          <Identifier>
            <IdentifierType>National Pollutant Release Inventory Identifier</IdentifierType>
            <IdentifierValue>0000</IdentifierValue>
          </Identifier>
        </IdentifierList>
        <NAICSCodeList>
          <NAICSCode>
            <NAICSClassification>Chemical Pulp Mills </NAICSClassification>
            <Code>321111</Code>
            <NaicsPriority>Primary</NaicsPriority>
          </NAICSCode>
        </NAICSCodeList>
        <Permits>
          <Permit>
            <IssuingAgency>British Columbia</IssuingAgency>
            <PermitNumber>0000</PermitNumber>
          </Permit>
        </Permits>
      </Identifiers>
    </Facility>
  </RegistrationData>
  <ReportDetails>
    <ReportID>1235</ReportID>
    <ReportType>R1</ReportType>
    <FacilityId>0001</FacilityId>
    <FacilityType>LF_a</FacilityType>
    <OrganisationId>0000</OrganisationId>
    <ReportingPeriodDuration>2020</ReportingPeriodDuration>
    <ReportStatus>
      <Status>Submitted</Status>
      <SubmissionDate>2013-03-28T19:25:55.32</SubmissionDate>
      <LastModifiedBy>Buddy</LastModifiedBy>
    </ReportStatus>
  </ReportDetails>
  <OperationalWorkerReport/>
  <VerifyTombstone>
    <Organisation>
      <Details>
        <BusinessLegalName>Bart Simpson</BusinessLegalName>
        <EnglishTradeName>Bart Simpson</EnglishTradeName>
        <CRABusinessNumber>123456778</CRABusinessNumber>
        <DUNSNumber>00-000-0000</DUNSNumber>
      </Details>
    </Organisation>
    <Facility>
      <Details>
        <FacilityName>Bart Simpson</FacilityName>
        <Identifiers>
          <IdentifierList>
            <Identifier>
              <IdentifierType>NPRI</IdentifierType>
              <IdentifierValue>12345</IdentifierValue>
            </Identifier>
            <Identifier>
              <IdentifierType>BCGHGID</IdentifierType>
              <IdentifierValue></IdentifierValue>
            </Identifier>
          </IdentifierList>
          <NAICSCodeList>
            <NAICSCode>
              <Code>321111</Code>
            </NAICSCode>
          </NAICSCodeList>
        </Identifiers>
      </Details>
    </Facility>
    <ParentOrganisations/>
  </VerifyTombstone>
  <ActivityData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <ActivityPages>
      <Process ProcessName="ElectricityGeneration">
        <SubProcess SubprocessName="Emissions from fuel combustion for electricity generation" InformationRequirement="Required">
          <Units UnitType="Cogen Units">
            <Unit>
              <COGenUnit>
                <CogenUnitName>Boiler 16 - hog fuel</CogenUnitName>
                <NameplateCapacity>5.9</NameplateCapacity>
                <NetPower>30165</NetPower>
                <CycleType>Topping</CycleType>
                <ThermalOutputQuantity>886917960</ThermalOutputQuantity>
                <SupplementalFiringPurpose>Electr. Generation</SupplementalFiringPurpose>
              </COGenUnit>
              <Fuels>
                <Fuel>
                  <FuelType>Wood Waste</FuelType>
                  <FuelClassification>Biomass in Schedule C</FuelClassification>
                  <FuelDescription/>
                  <FuelUnits>bone dry tonnes</FuelUnits>
                  <AnnualFuelAmount>0</AnnualFuelAmount>
                  <AnnualSteamGeneration>290471000</AnnualSteamGeneration>
                  <MeasuredEmissionFactors>
                    <MeasuredEmissionFactor>
                      <MeasuredEmissionFactorGas>CO2</MeasuredEmissionFactorGas>
                      <MeasuredEmissionFactorAmount>50000</MeasuredEmissionFactorAmount>
                      <MeasuredEmissionFactorUnitType>g/GJ</MeasuredEmissionFactorUnitType>
                    </MeasuredEmissionFactor>
                    <MeasuredEmissionFactor>
                      <MeasuredEmissionFactorGas>CH4</MeasuredEmissionFactorGas>
                      <MeasuredEmissionFactorAmount>0.966</MeasuredEmissionFactorAmount>
                      <MeasuredEmissionFactorUnitType>g/GJ</MeasuredEmissionFactorUnitType>
                    </MeasuredEmissionFactor>
                  </MeasuredEmissionFactors>
                  <Emissions>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>168038.5773</Quantity>
                      <CalculatedQuantity>168038.5773</CalculatedQuantity>
                      <GasType>CO2bioC</GasType>
                      <Methodology>Methodology 3 (measured CC/Steam)</Methodology>
                    </Emission>
                  </Emissions>
                  <AlternativeMethodologyDescription/>
                </Fuel>
                <Fuel>
                  <FuelType>Residual Fuel Oil (#5 &amp; 6)</FuelType>
                  <FuelClassification>non-biomass</FuelClassification>
                  <FuelDescription/>
                  <FuelUnits>kilolitres</FuelUnits>
                  <AnnualFuelAmount>9441</AnnualFuelAmount>
                  <AnnualWeightedAverageCarbonContent>0.862</AnnualWeightedAverageCarbonContent>
                  <Emissions>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>29819.5973</Quantity>
                      <CalculatedQuantity>29819.5973</CalculatedQuantity>
                      <GasType>CO2nonbio</GasType>
                      <Methodology>Methodology 3 (measured CC/Steam)</Methodology>
                    </Emission>
                  </Emissions>
                  <AlternativeMethodologyDescription/>
                </Fuel>
              </Fuels>
            </Unit>
          </Units>
        </SubProcess>
      </Process>
      <Process>
        <SubProcess SubprocessName="Additional Reportable Information as per WCI.352(i)(1)-(12)" InformationRequirement="MandatoryAdditional">
          <Amount AmtDomain="PulpAndPaperBlackLiquor" AmtAction="Combusted" AmtPeriod="Annual">168389</Amount>
          <PercentSolidsByWeight>53</PercentSolidsByWeight>
          <PulpAndPaperCarbonates/>
        </SubProcess>
      </Process>
    </ActivityPages>
  </ActivityData>
</ReportData>
$$);

refresh materialized view ggircs_swrs.report with data;
refresh materialized view ggircs_swrs.organisation with data;
refresh materialized view ggircs_swrs.facility with data;
refresh materialized view ggircs_swrs.activity with data;
refresh materialized view ggircs_swrs.identifier with data;
refresh materialized view ggircs_swrs.naics with data;
refresh materialized view ggircs_swrs.unit with data;
refresh materialized view ggircs_swrs.fuel with data;
refresh materialized view ggircs_swrs.emission with data;
refresh materialized view ggircs_swrs.final_report with data;

select ggircs_swrs.export_report_to_ggircs();
select ggircs_swrs.export_organisation_to_ggircs();
select ggircs_swrs.export_facility_to_ggircs();
select ggircs_swrs.export_activity_to_ggircs();
select ggircs_swrs.export_identifier_to_ggircs();
select ggircs_swrs.export_naics_to_ggircs();
select ggircs_swrs.export_unit_to_ggircs();
select ggircs_swrs.export_fuel_to_ggircs();
select ggircs_swrs.export_emission_to_ggircs();

-- Table ggircs.emission exists
select has_table('ggircs'::name, 'emission'::name);

-- Emission has pk
select has_pk('ggircs', 'emission', 'ggircs_emission has primary key');

-- Emission has fk
select has_fk('ggircs', 'emission', 'ggircs_emission has foreign key constraint(s)');

-- Emission has data
select isnt_empty('select * from ggircs.emission', 'there is data in ggircs.emission');

-- FKey tests
-- Emission -> Activity
select set_eq(
    $$
    select distinct(activity.ghgr_import_id) from ggircs.emission
    join ggircs.activity
    on emission.activity_id = activity.id
    $$,

    'select distinct(ghgr_import_id) from ggircs.activity',

    'Foreign key activity_id in ggircs.emission references ggircs.activity.id'
);

-- Emission -> Naics
select set_eq(
    $$select distinct(naics.naics_code) from ggircs.emission
      join ggircs.naics
      on
        emission.naics_id = naics.id
    $$,

    'select distinct(naics_code) from ggircs.naics',

    'Foreign key naics_id in ggircs.emission references ggircs.naics.id'
);

-- Emission -> Fuel
select results_eq(
    $$select distinct(fuel_type) from ggircs.emission
      join ggircs.fuel
      on
        emission.fuel_id = fuel.id
      order by fuel_type
    $$,

    'select distinct(fuel_type) from ggircs.fuel order by fuel_type',

    'Foreign key fuel_id in ggircs.emission references ggircs.fuel.id'
);

-- Emission -> Organisation
select set_eq(
    $$select organisation.id from ggircs.emission
      join ggircs.organisation
      on
        emission.organisation_id = organisation.id
    $$,

    'select id from ggircs.organisation',

    'Foreign key organisation_id in ggircs.emission references ggircs.organisation.id'
);

-- Emission -> Report
select set_eq(
    $$select report.ghgr_import_id from ggircs.emission
      join ggircs.report
      on
        emission.report_id = report.id
    $$,

    'select ghgr_import_id from ggircs.report',

    'Foreign key report_id in ggircs.emission references ggircs.report.id'
);

-- Emission -> Unit
select set_eq(
    $$select distinct(unit.unit_name) from ggircs.emission
      join ggircs.unit
      on
        emission.unit_id = unit.id
      order by unit_name
    $$,

    'select distinct(unit_name) from ggircs.unit order by unit_name',

    'Foreign key unit_id in ggircs.emission references ggircs.unit.id'
);

-- Data in ggircs_swrs.emission === data in ggircs.emission
select set_eq(
              $$
              select
                emission.ghgr_import_id,
                activity_name,
                sub_activity_name,
                unit_name,
                sub_unit_name,
                fuel_name,
                emission_type,
                gas_type,
                methodology,
                not_applicable,
                quantity,
                calculated_quantity,
                emission_category
              from ggircs_swrs.emission
              order by
                ghgr_import_id asc
              $$,

              $$
              select
                  ghgr_import_id,
                  activity_name,
                  sub_activity_name,
                  unit_name,
                  sub_unit_name,
                  fuel_name,
                  emission_type,
                  gas_type,
                  methodology,
                  not_applicable,
                  quantity,
                  calculated_quantity,
                  emission_category
                from ggircs.emission
              $$,

              'data in ggircs_swrs.emission === ggircs.emission');

select * from finish();
rollback;
