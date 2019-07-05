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
                  <AlternativeMethodologyDescription/>
                </Fuel>
                <Fuel>
                  <FuelType>Residual Fuel Oil (#5 &amp; 6)</FuelType>
                  <FuelClassification>non-biomass</FuelClassification>
                  <FuelDescription/>
                  <FuelUnits>kilolitres</FuelUnits>
                  <AnnualFuelAmount>9441</AnnualFuelAmount>
                  <AnnualWeightedAverageCarbonContent>0.862</AnnualWeightedAverageCarbonContent>
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
    </Facility>
    <Contacts/>
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
                  <AlternativeMethodologyDescription/>
                </Fuel>
                <Fuel>
                  <FuelType>Residual Fuel Oil (#5 &amp; 6)</FuelType>
                  <FuelClassification>non-biomass</FuelClassification>
                  <FuelDescription/>
                  <FuelUnits>kilolitres</FuelUnits>
                  <AnnualFuelAmount>9441</AnnualFuelAmount>
                  <AnnualWeightedAverageCarbonContent>0.862</AnnualWeightedAverageCarbonContent>
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
refresh materialized view ggircs_swrs.measured_emission_factor with data;
refresh materialized view ggircs_swrs.final_report with data;

select ggircs_swrs.export_report_to_ggircs();
select ggircs_swrs.export_organisation_to_ggircs();
select ggircs_swrs.export_facility_to_ggircs();
select ggircs_swrs.export_activity_to_ggircs();
select ggircs_swrs.export_identifier_to_ggircs();
select ggircs_swrs.export_naics_to_ggircs();
select ggircs_swrs.export_unit_to_ggircs();
select ggircs_swrs.export_fuel_to_ggircs();
select ggircs_swrs.export_measured_emission_factor_to_ggircs();

-- Table ggircs.measured_emission_factor exists
select has_table('ggircs'::name, 'measured_emission_factor'::name);

-- Measured Emission Factor has pk
select has_pk('ggircs', 'measured_emission_factor', 'ggircs_measured_emission_factor has primary key');

-- Measured Emission Factor has fk
select has_fk('ggircs', 'measured_emission_factor', 'ggircs_measured_emission_factor has foreign key constraint(s)');

-- Measured Emission Factor has data
select isnt_empty('select * from ggircs.measured_emission_factor', 'there is data in ggircs.measured_emission_factor');

-- FKey tests
-- Measured Emission Factor -> Fuel
select set_eq(
    $$
    select distinct(fuel.ghgr_import_id) from ggircs.measured_emission_factor
    join ggircs.fuel
    on measured_emission_factor.fuel_id = fuel.id
    $$,

    'select distinct(ghgr_import_id) from ggircs.fuel',

    'Foreign key fuel_id in ggircs.measured_emission_factor references ggircs.fuel.id'
);

-- Data in ggircs_swrs.measured_emission_factor === data in ggircs.measured_emission_factor
select set_eq(
              $$
              select
                ghgr_import_id,
                activity_name,
                sub_activity_name,
                unit_name,
                sub_unit_name,
                measured_emission_factor_amount,
                measured_emission_factor_gas,
                measured_emission_factor_unit_type
              from ggircs_swrs.measured_emission_factor
              order by
                ghgr_import_id
              $$,

              $$
              select
                  ghgr_import_id,
                  activity_name,
                  sub_activity_name,
                  unit_name,
                  sub_unit_name,
                  measured_emission_factor_amount,
                  measured_emission_factor_gas,
                  measured_emission_factor_unit_type
                from ggircs.measured_emission_factor
                order by
                    ghgr_import_id
                 asc
              $$,

              'data in ggircs_swrs.measured_emission_factor === ggircs.measured_emission_factor');



select * from finish();
rollback;
