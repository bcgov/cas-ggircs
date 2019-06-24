set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select * from no_plan();

-- View should exist
select has_view(
    'ggircs', 'attributable_emissions_with_details',
    'ggircs.attributable_emission should be a view'
);

-- Columns are correct
select columns_are('ggircs'::name, 'attributable_emissions_with_details'::name, array[
    'emission_id'::name,
    'business_legal_name'::name,
    'facility_name'::name,
    'facility_type'::name,
    'process_name'::name,
    'sub_process_name'::name,
    'emission_type'::name,
    'gas_type'::name,
    'quantity'::name,
    'calculated_quantity'::name,
    'methodology'::name,
    'emission_category'::name,
    'reporting_period_duration'::name,
    'fuel_type'::name,
    'fuel_units'::name,
    'fuel_classification'::name,
    'fuel_description'::name,
    'annual_fuel_amount'::name,
    'annual_weighted_avg_carbon_content'::name,
    'annual_weighted_avg_hhv'::name,
    'annual_steam_generation'::name,
    'alternative_methodology_description'::name,
    'naics_classification'::name,
    'naics_code'::name,
    'unit_name'::name,
    'unit_id'::name,
    'ghgr_import_id'::name,
    'report_id'::name,
    'organisation_id'::name,
    'facility_id'::name,
    'swrs_report_id'::name,
    'swrs_organisation_id'::name,
    'swrs_facility_id'
]);

-- Column attributes are correct

select col_type_is('ggircs', 'attributable_emissions_with_details', 'emission_id', 'bigint', 'attributable_emissions.emission_id column should be type bigint');
select col_hasnt_default('ggircs', 'attributable_emissions_with_details', 'emission_id', 'attributable_emissions_with_details.emission_id column should not have a default value');

select col_type_is('ggircs', 'attributable_emissions_with_details', 'business_legal_name', 'character varying(1000)', 'attributable_emissions.business_legal_name column should be type varchar');
select col_hasnt_default('ggircs', 'attributable_emissions_with_details', 'business_legal_name', 'attributable_emissions_with_details.business_legal_name column should not have a default value');

select col_type_is('ggircs', 'attributable_emissions_with_details', 'facility_name', 'character varying(1000)', 'attributable_emissions.facility_name column should be type varchar');
select col_hasnt_default('ggircs', 'attributable_emissions_with_details', 'facility_name', 'attributable_emissions_with_details.facility_name column should not have a default value');

select col_type_is('ggircs', 'attributable_emissions_with_details', 'facility_type', 'character varying(1000)', 'attributable_emissions.facility_type column should be type varchar');
select col_hasnt_default('ggircs', 'attributable_emissions_with_details', 'facility_type', 'attributable_emissions_with_details.facility_type column should not have a default value');

select col_type_is('ggircs', 'attributable_emissions_with_details', 'process_name', 'character varying(1000)', 'attributable_emissions.process_name column should be type varchar');
select col_hasnt_default('ggircs', 'attributable_emissions_with_details', 'process_name', 'attributable_emissions_with_details.process_name column should not have a default value');

select col_type_is('ggircs', 'attributable_emissions_with_details', 'sub_process_name', 'character varying(1000)', 'attributable_emissions.sub_process_name column should be type varchar');
select col_hasnt_default('ggircs', 'attributable_emissions_with_details', 'sub_process_name', 'attributable_emissions_with_details.sub_process_name column should not have a default value');

select col_type_is('ggircs', 'attributable_emissions_with_details', 'emission_type', 'character varying(1000)', 'attributable_emissions.emission_type column should be type varchar');
select col_hasnt_default('ggircs', 'attributable_emissions_with_details', 'emission_type', 'attributable_emissions_with_details.emission_type column should not have a default value');

select col_type_is('ggircs', 'attributable_emissions_with_details', 'gas_type', 'character varying(1000)', 'attributable_emissions.gas_type column should be type varchar');
select col_hasnt_default('ggircs', 'attributable_emissions_with_details', 'gas_type', 'attributable_emissions_with_details.gas_type column should not have a default value');

select col_type_is('ggircs', 'attributable_emissions_with_details', 'quantity', 'numeric', 'attributable_emissions.quantity column should be type numeric');
select col_hasnt_default('ggircs', 'attributable_emissions_with_details', 'quantity', 'attributable_emission.quantity column should not have a default value');

select col_type_is('ggircs', 'attributable_emissions_with_details', 'calculated_quantity', 'numeric', 'attributable_emissions.calculated_quantity column should be type numeric');
select col_hasnt_default('ggircs', 'attributable_emissions_with_details', 'calculated_quantity', 'attributable_emission.calculated_quantity column should not have a default value');

select col_type_is('ggircs', 'attributable_emissions_with_details', 'methodology', 'character varying(1000)', 'attributable_emissions.methodology column should be type varchar');
select col_hasnt_default('ggircs', 'attributable_emissions_with_details', 'methodology', 'attributable_emission.methodology column should not have a default value');

select col_type_is('ggircs', 'attributable_emissions_with_details', 'emission_category', 'character varying(1000)', 'attributable_emissions.emission_category column should be type varchar');
select col_hasnt_default('ggircs', 'attributable_emissions_with_details', 'emission_category', 'attributable_emission.emission_category column should not have a default value');

select col_type_is('ggircs', 'attributable_emissions_with_details', 'reporting_period_duration', 'character varying(1000)', 'attributable_emissions.reporting_period_duration column should be type varchar');
select col_hasnt_default('ggircs', 'attributable_emissions_with_details', 'reporting_period_duration', 'attributable_emission.reporting_period_duration column should not have a default value');

select col_type_is('ggircs', 'attributable_emissions_with_details', 'fuel_type', 'character varying(1000)', 'attributable_emissions.fuel_type column should be type varchar');
select col_hasnt_default('ggircs', 'attributable_emissions_with_details', 'fuel_type', 'attributable_emission.fuel_type column should not have a default value');

select col_type_is('ggircs', 'attributable_emissions_with_details', 'fuel_units', 'character varying(1000)', 'attributable_emissions.fuel_units column should be type varchar');
select col_hasnt_default('ggircs', 'attributable_emissions_with_details', 'fuel_units', 'attributable_emission.fuel_units column should not have a default value');

select col_type_is('ggircs', 'attributable_emissions_with_details', 'fuel_classification', 'character varying(1000)', 'attributable_emissions.fuel_classification column should be type varchar');
select col_hasnt_default('ggircs', 'attributable_emissions_with_details', 'fuel_classification', 'attributable_emission.fuel_classification column should not have a default value');

select col_type_is('ggircs', 'attributable_emissions_with_details', 'fuel_description', 'character varying(1000)', 'attributable_emissions.fuel_description column should be type varchar');
select col_hasnt_default('ggircs', 'attributable_emissions_with_details', 'fuel_description', 'attributable_emission.fuel_description column should not have a default value');

select col_type_is('ggircs', 'attributable_emissions_with_details', 'annual_fuel_amount', 'numeric', 'attributable_emissions.annual_fuel_amount column should be type numeric');
select col_hasnt_default('ggircs', 'attributable_emissions_with_details', 'annual_fuel_amount', 'attributable_emission.annual_fuel_amount column should not have a default value');

select col_type_is('ggircs', 'attributable_emissions_with_details', 'annual_weighted_avg_carbon_content', 'numeric', 'attributable_emissions.annual_weighted_avg_carbon_content column should be type numeric');
select col_hasnt_default('ggircs', 'attributable_emissions_with_details', 'annual_weighted_avg_carbon_content', 'attributable_emission.annual_weighted_avg_carbon_content column should not have a default value');

select col_type_is('ggircs', 'attributable_emissions_with_details', 'annual_weighted_avg_hhv', 'numeric', 'attributable_emissions.annual_weighted_avg_hhv column should be type numeric');
select col_hasnt_default('ggircs', 'attributable_emissions_with_details', 'annual_weighted_avg_hhv', 'attributable_emission.annual_weighted_avg_hhv column should not have a default value');

select col_type_is('ggircs', 'attributable_emissions_with_details', 'annual_steam_generation', 'numeric', 'attributable_emissions.annual_steam_generation column should be type numeric');
select col_hasnt_default('ggircs', 'attributable_emissions_with_details', 'annual_steam_generation', 'attributable_emission.annual_steam_generation column should not have a default value');

select col_type_is('ggircs', 'attributable_emissions_with_details', 'alternative_methodology_description', 'character varying(10000)', 'attributable_emissions.alternative_methodology_description column should be type varchar');
select col_hasnt_default('ggircs', 'attributable_emissions_with_details', 'alternative_methodology_description', 'attributable_emission.alternative_methodology_description column should not have a default value');

select col_type_is('ggircs', 'attributable_emissions_with_details', 'naics_classification', 'character varying(1000)', 'attributable_emissions.naics_classification column should be type varchar');
select col_hasnt_default('ggircs', 'attributable_emissions_with_details', 'naics_classification', 'attributable_emission.naics_classification column should not have a default value');

select col_type_is('ggircs', 'attributable_emissions_with_details', 'naics_code', 'integer', 'attributable_emissions.naics_code column should be type integer');
select col_hasnt_default('ggircs', 'attributable_emissions_with_details', 'naics_code', 'attributable_emission.naics_code column should not have a default value');

select col_type_is('ggircs', 'attributable_emissions_with_details', 'unit_name', 'character varying(1000)', 'attributable_emissions.unit_name column should be type varchar');
select col_hasnt_default('ggircs', 'attributable_emissions_with_details', 'unit_name', 'attributable_emission.unit_name column should not have a default value');

select col_type_is('ggircs', 'attributable_emissions_with_details', 'unit_id', 'integer', 'attributable_emissions.unit_id column should be type integer');
select col_hasnt_default('ggircs', 'attributable_emissions_with_details', 'unit_id', 'attributable_emission.unit_id column should not have a default value');

select col_type_is('ggircs', 'attributable_emissions_with_details', 'ghgr_import_id', 'integer', 'attributable_emissions.ghgr_import_id column should be type integer');
select col_hasnt_default('ggircs', 'attributable_emissions_with_details', 'ghgr_import_id', 'attributable_emission.ghgr_import_id column should not have a default value');

select col_type_is('ggircs', 'attributable_emissions_with_details', 'report_id', 'integer', 'attributable_emissions.report_id column should be type integer');
select col_hasnt_default('ggircs', 'attributable_emissions_with_details', 'report_id', 'attributable_emission.report_id column should not have a default value');

select col_type_is('ggircs', 'attributable_emissions_with_details', 'organisation_id', 'integer', 'attributable_emission.organisation_id column should be type integer');
select col_hasnt_default('ggircs', 'attributable_emissions_with_details', 'organisation_id', 'attributable_emission.organisation_id column should not have a default value');

select col_type_is('ggircs', 'attributable_emissions_with_details', 'facility_id', 'integer', 'attributable_emission.facility_id column should be type integer');
select col_hasnt_default('ggircs', 'attributable_emissions_with_details', 'facility_id', 'attributable_emission.facility_id column should not have a default value');

select col_type_is('ggircs', 'attributable_emissions_with_details', 'swrs_report_id', 'integer', 'attributable_emission.swrs_report_id column should be type integer');
select col_hasnt_default('ggircs', 'attributable_emissions_with_details', 'swrs_report_id', 'attributable_emission.swrs_report_id column should not have a default value');

select col_type_is('ggircs', 'attributable_emissions_with_details', 'swrs_organisation_id', 'integer', 'attributable_emissions.swrs_organisation_id column should be type integer');
select col_hasnt_default('ggircs', 'attributable_emissions_with_details', 'swrs_organisation_id', 'attributable_emission.swrs_organisation_id column should not have a default value');

select col_type_is('ggircs', 'attributable_emissions_with_details', 'swrs_facility_id', 'integer', 'attributable_emissions.swrs_facility_id column should be type integer');
select col_hasnt_default('ggircs', 'attributable_emissions_with_details', 'swrs_facility_id', 'attributable_emission.swrs_facility_id column should not have a default value');

-- XML fixture for testing
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
      <Address>
        <PhysicalAddress>
          <StreetNumber>300</StreetNumber>
          <StreetNumberSuffix/>
          <StreetName>A Drive</StreetName>
          <StreetType>Drive</StreetType>
          <StreetDirection>North</StreetDirection>
          <Municipality>Funky Town</Municipality>
          <ProvTerrState>British Columbia</ProvTerrState>
          <PostalCodeZipCode>H0H0H0</PostalCodeZipCode>
          <Country>Canada</Country>
        </PhysicalAddress>
        <MailingAddress>
          <DeliveryMode>Post Office Box</DeliveryMode>
          <POBoxNumber>1</POBoxNumber>
          <StreetNumber>300</StreetNumber>
          <StreetNumberSuffix/>
          <StreetName>A Drive</StreetName>
          <StreetType>Drive</StreetType>
          <Municipality>Funky Town</Municipality>
          <ProvTerrState>British Columbia</ProvTerrState>
          <PostalCodeZipCode>H0H0H0</PostalCodeZipCode>
          <Country>Canada</Country>
          <AdditionalInformation/>
        </MailingAddress>
      </Address>
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
      <Address>
        <PhysicalAddress>
          <StreetNumber>123</StreetNumber>
          <StreetName>A Drive</StreetName>
          <StreetType>Drive</StreetType>
          <Municipality>Funky Town</Municipality>
          <ProvTerrState>British Columbia</ProvTerrState>
          <PostalCodeZipCode>H0H0H0</PostalCodeZipCode>
          <Country>Canada</Country>
        </PhysicalAddress>
        <MailingAddress>
          <DeliveryMode>Post Office Box</DeliveryMode>
          <POBoxNumber>000</POBoxNumber>
          <StreetNumber>300</StreetNumber>
          <StreetName>A Drive</StreetName>
          <StreetType>Drive</StreetType>
          <Municipality>Funky Town</Municipality>
          <ProvTerrState>British Columbia</ProvTerrState>
          <PostalCodeZipCode>H0H0H0</PostalCodeZipCode>
          <Country>Canada</Country>
          <AdditionalInformation/>
        </MailingAddress>
        <GeographicAddress>
          <Latitude>1.23000</Latitude>
          <Longitude>1.26000</Longitude>
          <UTMZone>1</UTMZone>
          <UTMNorthing>1</UTMNorthing>
          <UTMEasting>1</UTMEasting>
        </GeographicAddress>
      </Address>
    </Facility>
    <Contacts/>
    <ParentOrganisations>
      <ParentOrganisation>
        <Details>
          <BusinessLegalName>ABC</BusinessLegalName>
          <CRABusinessNumber>123456789</CRABusinessNumber>
          <PercentageOwned>0</PercentageOwned>
        </Details>
        <Address>
          <PhysicalAddress>
            <UnitNumber/>
            <StreetNumber>0</StreetNumber>
            <StreetNumberSuffix/>
            <StreetName/>
            <Municipality/>
            <PostalCodeZipCode/>
            <AdditionalInformation/>
            <LandSurveyDescription/>
            <NationalTopographicalDescription/>
          </PhysicalAddress>
          <MailingAddress>
            <UnitNumber>1</UnitNumber>
            <StreetNumber>2700</StreetNumber>
            <StreetNumberSuffix/>
            <StreetName>00th</StreetName>
            <StreetType>Avenue</StreetType>
            <Municipality>Vancouver</Municipality>
            <ProvTerrState>British Columbia</ProvTerrState>
            <PostalCodeZipCode>H0H0H0</PostalCodeZipCode>
            <Country>Canada</Country>
            <AdditionalInformation/>
          </MailingAddress>
        </Address>
      </ParentOrganisation>
    </ParentOrganisations>
  </RegistrationData>
  <ReportDetails>
    <ReportID>1234</ReportID>
    <ReportType>R1</ReportType>
    <FacilityId>0000</FacilityId>
    <FacilityType>ABC</FacilityType>
    <OrganisationId>0000</OrganisationId>
    <ReportingPeriodDuration>2025</ReportingPeriodDuration>
    <ReportStatus>
      <Status>Submitted</Status>
      <SubmissionDate>2013-03-27T19:25:55.32</SubmissionDate>
      <LastModifiedBy>Buddy</LastModifiedBy>
    </ReportStatus>
    <ActivityOrSource>
      <ActivityList>
        <Activity>
          <ActivityName>GeneralStationaryCombustion</ActivityName>
          <TableNumber>1</TableNumber>
        </Activity>
        <Activity>
          <ActivityName>MobileCombustion</ActivityName>
          <TableNumber>1</TableNumber>
        </Activity>
        <Activity>
          <ActivityName>ElectricityGeneration</ActivityName>
          <TableNumber>1</TableNumber>
        </Activity>
        <Activity>
          <ActivityName>PulpAndPaperProduction</ActivityName>
          <TableNumber>1</TableNumber>
        </Activity>
      </ActivityList>
    </ActivityOrSource>
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
      <Address>
        <MailingAddress>
          <POBoxNumber>0000</POBoxNumber>
          <StreetNumber>00</StreetNumber>
          <StreetName>A Drive</StreetName>
          <StreetType>Drive</StreetType>
          <Municipality>Funky Town</Municipality>
          <ProvTerrState>British Columbia</ProvTerrState>
          <PostalCodeZipCode>H0H0H0</PostalCodeZipCode>
          <Country>Canada</Country>
        </MailingAddress>
      </Address>
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
      <Address>
        <PhysicalAddress>
          <StreetNumber>1</StreetNumber>
          <StreetName>A Drive</StreetName>
          <StreetType>Drive</StreetType>
          <Municipality>Funky Town</Municipality>
          <ProvTerrState>British Columbia</ProvTerrState>
          <PostalCodeZipCode>H0H0H0</PostalCodeZipCode>
          <Country>Canada</Country>
        </PhysicalAddress>
        <GeographicalAddress>
          <Latitude>1.23000</Latitude>
          <Longitude>1.26000</Longitude>
        </GeographicalAddress>
      </Address>
    </Facility>
    <Contacts>
      <Contact>
        <Details>
          <ContactType>Operator Contact</ContactType>
          <GivenName>Buddy</GivenName>
          <TelephoneNumber>1234</TelephoneNumber>
          <ExtensionNumber>1</ExtensionNumber>
          <EmailAddress>abc@abc.ca</EmailAddress>
          <Position>Environmental Manager</Position>
        </Details>
        <Address>
          <MailingAddress>
            <POBoxNumber>00</POBoxNumber>
            <Municipality>Funky Town</Municipality>
            <ProvTerrState>British Columbia</ProvTerrState>
            <PostalCodeZipCode>H0H0H0</PostalCodeZipCode>
            <Country>Canada</Country>
          </MailingAddress>
        </Address>
      </Contact>
      <Contact>
        <Details>
          <ContactType>Operator Representative</ContactType>
          <GivenName>Buddy</GivenName>
          <TelephoneNumber>0000</TelephoneNumber>
          <ExtensionNumber>1</ExtensionNumber>
          <EmailAddress>abc@abc.ca</EmailAddress>
          <Position>Environmental Manager</Position>
        </Details>
        <Address>
          <MailingAddress>
            <POBoxNumber>00</POBoxNumber>
            <Municipality>Funky Town</Municipality>
            <ProvTerrState>British Columbia</ProvTerrState>
            <PostalCodeZipCode>H0H0H0</PostalCodeZipCode>
            <Country>Canada</Country>
          </MailingAddress>
        </Address>
      </Contact>
    </Contacts>
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

-- Refresh necessary materialized views
refresh materialized view ggircs_swrs.report with data;
refresh materialized view ggircs_swrs.final_report with data;
refresh materialized view ggircs_swrs.organisation with data;
refresh materialized view ggircs_swrs.facility with data;
refresh materialized view ggircs_swrs.activity with data;
refresh materialized view ggircs_swrs.naics with data;
refresh materialized view ggircs_swrs.fuel with data;
refresh materialized view ggircs_swrs.unit with data;
refresh materialized view ggircs_swrs.emission with data;

-- Populate necessary ggircs tables

-- REPORT
    insert into ggircs.report (id, ghgr_import_id, imported_at, swrs_report_id, prepop_report_id, report_type, swrs_facility_id, swrs_organisation_id,
                               reporting_period_duration, status, version, submission_date, last_modified_by, last_modified_date, update_comment)

    select id, ghgr_import_id, imported_at, swrs_report_id, prepop_report_id, report_type, swrs_facility_id, swrs_organisation_id,
           reporting_period_duration, status, version, submission_date, last_modified_by, last_modified_date, update_comment

    from ggircs_swrs.report;

-- ORGANISATION
    insert into ggircs.organisation (id, ghgr_import_id, report_id, swrs_organisation_id, business_legal_name, english_trade_name, french_trade_name, cra_business_number, duns, website)

    select _organisation.id, _organisation.ghgr_import_id, _report.id, _organisation.swrs_organisation_id, _organisation.business_legal_name,
           _organisation.english_trade_name, _organisation.french_trade_name, _organisation.cra_business_number, _organisation.duns, _organisation.website

    from ggircs_swrs.organisation as _organisation

    inner join ggircs_swrs.final_report as _final_report on _organisation.ghgr_import_id = _final_report.ghgr_import_id
    --FK Organisation -> Report
    left join ggircs_swrs.report as _report
      on _organisation.ghgr_import_id = _report.ghgr_import_id;

    -- SINGLE FACILITY
    with _final_lfo_facility as (
        -- facility.id will as the parent facility FK.
        -- swrs_organisation_id and reporting_period_duration are the join constraints
        select _facility.id, _organisation.swrs_organisation_id, _report.reporting_period_duration
        from ggircs_swrs.facility as _facility
        inner join ggircs_swrs.final_report as _final_report
            on _facility.ghgr_import_id = _final_report.ghgr_import_id
            and _facility.facility_type = 'LFO'
        left join ggircs_swrs.organisation as _organisation
            on _facility.ghgr_import_id = _organisation.ghgr_import_id
        left join ggircs_swrs.report as _report
            on _facility.ghgr_import_id = _report.ghgr_import_id

    )
    insert into ggircs.single_facility (id, ghgr_import_id, organisation_id, report_id, swrs_facility_id, lfo_facility_id, facility_name, facility_type, relationship_type, portability_indicator, status, latitude, longitude)

    select _facility.id, _facility.ghgr_import_id, _organisation.id, _report.id, _facility.swrs_facility_id, _final_lfo_facility.id, _facility.facility_name, _facility.facility_type,
           _facility.relationship_type, _facility.portability_indicator, _facility.status, _facility.latitude, _facility.longitude

    from ggircs_swrs.facility as _facility
    inner join ggircs_swrs.final_report as _final_report on _facility.ghgr_import_id = _final_report.ghgr_import_id
        and (_facility.facility_type != 'LFO' or _facility.facility_type is null)
    -- FK Facility -> Organisation
    left join ggircs_swrs.organisation as _organisation
        on _facility.ghgr_import_id = _organisation.ghgr_import_id
    -- FK Facility -> Report
    left join ggircs_swrs.report as _report
        on _facility.ghgr_import_id = _report.ghgr_import_id
    -- FK Single Facility -> LFO Facility
    left join _final_lfo_facility
        on _organisation.swrs_organisation_id = _final_lfo_facility.swrs_organisation_id
        and _report.reporting_period_duration = _final_lfo_facility.reporting_period_duration
        and (_facility.facility_type = 'IF_a' or _facility.facility_type = 'IF_b' or _facility.facility_type = 'L_c');

    -- LFO FACILITY
    insert into ggircs.lfo_facility (id, ghgr_import_id, organisation_id, report_id, swrs_facility_id, facility_name, facility_type, relationship_type, portability_indicator, status, latitude, longitude)

    select _facility.id, _facility.ghgr_import_id, _organisation.id, _report.id, _facility.swrs_facility_id, _facility.facility_name, _facility.facility_type,
           _facility.relationship_type, _facility.portability_indicator, _facility.status, _facility.latitude, _facility.longitude

    from ggircs_swrs.facility as _facility
   inner join ggircs_swrs.final_report as _final_report
        on _facility.ghgr_import_id = _final_report.ghgr_import_id
        and _facility.facility_type = 'LFO'
    -- FK Facility -> Organisation
    left join ggircs_swrs.organisation as _organisation
        on _facility.ghgr_import_id = _organisation.ghgr_import_id
    -- FK Facility -> Report
    left join ggircs_swrs.report as _report
        on _facility.ghgr_import_id = _report.ghgr_import_id;

-- ACTIVITY
    insert into ggircs.activity (id, ghgr_import_id, single_facility_id, lfo_facility_id, report_id, activity_name, process_name, sub_process_name, information_requirement)

    select _activity.id, _activity.ghgr_import_id, _single_facility.id, _lfo_facility.id, _report.id, _activity.activity_name, _activity.process_name, _activity.sub_process_name, _activity.information_requirement

    from ggircs_swrs.activity as _activity

    inner join ggircs_swrs.final_report as _final_report on _activity.ghgr_import_id = _final_report.ghgr_import_id
    -- FK Activity -> Single Facility
    left join ggircs_swrs.facility as _single_facility
      on _activity.ghgr_import_id = _single_facility.ghgr_import_id
      and (_single_facility.facility_type != 'LFO' or _single_facility.facility_type is null)
    -- FK Activity -> LFO Facility
    left join ggircs_swrs.facility as _lfo_facility
      on _activity.ghgr_import_id = _lfo_facility.ghgr_import_id
      and _lfo_facility.facility_type = 'LFO'
    -- FK Activity -> Report
    left join ggircs_swrs.report as _report
      on _activity.ghgr_import_id = _report.ghgr_import_id;

    -- UNIT
    insert into ggircs.unit (id, ghgr_import_id, activity_id, activity_name, unit_name, unit_description, cogen_unit_name, cogen_cycle_type, cogen_nameplate_capacity,
                             cogen_net_power, cogen_steam_heat_acq_quantity, cogen_steam_heat_acq_name, cogen_supplemental_firing_purpose, cogen_thermal_output_quantity,
                             non_cogen_nameplate_capacity, non_cogen_net_power, non_cogen_unit_name)

    select _unit.id, _unit.ghgr_import_id, _activity.id, _unit.activity_name, _unit.unit_name, _unit.unit_description, _unit.cogen_unit_name, _unit.cogen_cycle_type,
           _unit.cogen_nameplate_capacity, _unit.cogen_net_power, _unit.cogen_steam_heat_acq_quantity, _unit.cogen_steam_heat_acq_name, _unit.cogen_supplemental_firing_purpose,
           _unit.cogen_thermal_output_quantity, _unit.non_cogen_nameplate_capacity, _unit.non_cogen_net_power, _unit.non_cogen_unit_name

    from ggircs_swrs.unit as _unit

    inner join ggircs_swrs.final_report as _final_report on _unit.ghgr_import_id = _final_report.ghgr_import_id
    -- FK Unit -> Activity
    left join ggircs_swrs.activity as _activity
      on _unit.ghgr_import_id = _activity.ghgr_import_id
      and _unit.process_idx = _activity.process_idx
      and _unit.sub_process_idx = _activity.sub_process_idx
      and _unit.activity_name = _activity.activity_name;

-- NAICS
insert into ggircs.naics(id, ghgr_import_id, single_facility_id, lfo_facility_id, registration_data_single_facility_id, registration_data_lfo_facility_id, naics_mapping_id, report_id, swrs_facility_id, path_context, naics_classification, naics_code, naics_priority)

    select _naics.id, _naics.ghgr_import_id, _single_facility.id, _lfo_facility.id,
        (select _single_facility.id where _naics.path_context = 'RegistrationData'),
        (select _lfo_facility.id where _naics.path_context = 'RegistrationData'),
        _naics_mapping.id, _report.id, _naics.swrs_facility_id,
        _naics.path_context, _naics.naics_classification, _naics.naics_code, _naics.naics_priority

    from ggircs_swrs.naics as _naics
    inner join ggircs_swrs.final_report as _final_report on _naics.ghgr_import_id = _final_report.ghgr_import_id
    -- FK Naics -> Single Facility
    left join ggircs_swrs.facility as _single_facility
      on _naics.ghgr_import_id = _single_facility.ghgr_import_id
      and (_single_facility.facility_type != 'LFO' or _single_facility.facility_type is null)
    -- FK Naics -> LFO Facility
    left join ggircs_swrs.facility as _lfo_facility
      on _naics.ghgr_import_id = _lfo_facility.ghgr_import_id
      and _lfo_facility.facility_type = 'LFO'
    -- FK Naics -> Report
    left join ggircs_swrs.report as _report
      on _naics.ghgr_import_id = _report.ghgr_import_id
    -- FK Naics -> Naics Mapping
    left join ggircs_swrs.naics_mapping as _naics_mapping
      on _naics.naics_code = _naics_mapping.naics_code;


-- FUEL
    insert into ggircs.fuel(id, ghgr_import_id, report_id,
                            activity_name, sub_activity_name, unit_name, sub_unit_name, fuel_type, fuel_classification, fuel_description,
                            fuel_units, annual_fuel_amount, annual_weighted_avg_carbon_content, annual_weighted_avg_hhv, annual_steam_generation, alternative_methodology_description,
                            other_flare_details, q1, q2, q3, q4)

    select _fuel.id, _fuel.ghgr_import_id, _report.id,
           _fuel.activity_name, _fuel.sub_activity_name, _fuel.unit_name, _fuel.sub_unit_name, _fuel.fuel_type, _fuel.fuel_classification, _fuel.fuel_description,
           _fuel.fuel_units, _fuel.annual_fuel_amount, _fuel.annual_weighted_avg_carbon_content, _fuel.annual_weighted_avg_hhv, _fuel.annual_steam_generation,
           _fuel.alternative_methodology_description, _fuel.other_flare_details, _fuel.q1, _fuel.q2, _fuel.q3, _fuel.q4

    from ggircs_swrs.fuel
    left join ggircs_swrs.fuel as _fuel on _fuel.id = fuel.id
    -- FK Fuel -> Report
    left join ggircs_swrs.report as _report
    on _fuel.ghgr_import_id = _report.ghgr_import_id;

 insert into ggircs.emission (id, ghgr_import_id, activity_id, single_facility_id, lfo_facility_id, fuel_id, naics_id, organisation_id, report_id, unit_id, activity_name, sub_activity_name,
                                 unit_name, sub_unit_name, fuel_name, emission_type,
                                 gas_type, methodology, not_applicable, quantity, calculated_quantity, emission_category)

    select _emission.id, _emission.ghgr_import_id, _activity.id, _single_facility.id, _lfo_facility.id, _fuel.id, _naics.id, _organisation.id, _report.id, _unit.id,
           _emission.activity_name, _emission.sub_activity_name, _emission.unit_name, _emission.sub_unit_name, _emission.fuel_name, _emission.emission_type,
           _emission.gas_type, _emission.methodology, _emission.not_applicable, _emission.quantity, _emission.calculated_quantity, _emission.emission_category

    from ggircs_swrs.emission as _emission
    -- join ggircs_swrs.emission to use _idx columns in FK creations
    inner join ggircs_swrs.final_report as _final_report on _emission.ghgr_import_id = _final_report.ghgr_import_id
    -- FK Emission -> Activity
    left join ggircs_swrs.activity as _activity
      on _emission.ghgr_import_id = _activity.ghgr_import_id
      and _emission.process_idx = _activity.process_idx
      and _emission.sub_process_idx = _activity.sub_process_idx
      and _emission.activity_name = _activity.activity_name
    -- FK Emission -> Single Facility
    left join ggircs_swrs.facility as _single_facility
        on _emission.ghgr_import_id = _single_facility.ghgr_import_id
        and (_single_facility.facility_type != 'LFO' or _single_facility.facility_type is null)
    -- FK Emission -> LFO Facility
    left join ggircs_swrs.facility as _lfo_facility
        on _emission.ghgr_import_id = _lfo_facility.ghgr_import_id
        and _lfo_facility.facility_type = 'LFO'
    -- FK Emission -> Fuel
    left join ggircs_swrs.fuel as _fuel
      on _emission.ghgr_import_id = _fuel.ghgr_import_id
      and _emission.process_idx = _fuel.process_idx
      and _emission.sub_process_idx = _fuel.sub_process_idx
      and _emission.activity_name = _fuel.activity_name
      and _emission.sub_activity_name = _fuel.sub_activity_name
      and _emission.unit_name = _fuel.unit_name
      and _emission.sub_unit_name = _fuel.sub_unit_name
      and _emission.substance_idx = _fuel.substance_idx
      and _emission.substances_idx = _fuel.substances_idx
      and _emission.sub_unit_name = _fuel.sub_unit_name
      and _emission.units_idx = _fuel.units_idx
      and _emission.unit_idx = _fuel.unit_idx
      and _emission.fuel_idx = _fuel.fuel_idx
    -- FK Emission -> Naics
        -- This long join gets id for the NAICS code from RegistrationData if the code exists and is unique (1 Primary per report)
        -- If there are 2 primary NAICS codes defined in RegistrationData the id for the code is derived from VerifyTombstone
    left outer join ggircs_swrs.naics as _naics
      on  _emission.ghgr_import_id = _naics.ghgr_import_id
      and ((_naics.path_context = 'RegistrationData'
      and (_naics.naics_priority = 'Primary'
            or _naics.naics_priority = '100.00'
            or _naics.naics_priority = '100')
      and (select count(ghgr_import_id)
           from ggircs_swrs.naics as __naics
           where ghgr_import_id = _emission.ghgr_import_id
           and __naics.path_context = 'RegistrationData'
           and (__naics.naics_priority = 'Primary'
            or __naics.naics_priority = '100.00'
            or __naics.naics_priority = '100')) < 2)
       or (_naics.path_context='VerifyTombstone'
           and _naics.naics_code is not null
           and (select count(ghgr_import_id)
           from ggircs_swrs.naics as __naics
           where ghgr_import_id = _emission.ghgr_import_id
           and __naics.path_context = 'RegistrationData'
           and (__naics.naics_priority = 'Primary'
            or __naics.naics_priority = '100.00'
            or __naics.naics_priority = '100')) > 1))

    -- FK Emission -> Organisation
    left join ggircs_swrs.organisation as _organisation
      on _emission.ghgr_import_id = _organisation.ghgr_import_id
    -- FK Emisison -> Report
    left join ggircs_swrs.report as _report
      on _emission.ghgr_import_id = _report.ghgr_import_id
    -- FK Emission -> Unit
    left join ggircs_swrs.unit as _unit
      on _emission.ghgr_import_id = _unit.ghgr_import_id
      and _emission.process_idx = _unit.process_idx
      and _emission.sub_process_idx = _unit.sub_process_idx
      and _emission.activity_name = _unit.activity_name
      and _emission.units_idx = _unit.units_idx
      and _emission.unit_idx = _unit.unit_idx;

-- Test fk relations
-- Report
select set_eq(
    $$ select report.id from ggircs.attributable_emissions_with_details as ae
       join ggircs.report on ae.report_id = report.id
    $$,
    'select id from ggircs.report',
    'fk report_id references report'
);

select set_eq(
    $$ select organisation.id from ggircs.attributable_emissions_with_details as ae
       join ggircs.organisation on ae.organisation_id = organisation.id
    $$,
    'select id from ggircs.organisation',
    'fk organisation_id references organisation'
);

-- Single Facility
select set_eq(
    $$ select single_facility.id from ggircs.attributable_emissions_with_details as ae
       join ggircs.single_facility on ae.facility_id = single_facility.id
    $$,
    'select id from ggircs.single_facility',
    'fk single_facility_id references single_facility'
);

-- Unit
select set_eq(
    $$ select unit.id from ggircs.attributable_emissions_with_details as ae
       join ggircs.unit on ae.unit_id = unit.id
    $$,
    'select id from ggircs.unit',
    'fk unit_id references unit'
);

-- Attributable Emissions with details has correct information
select set_eq(
   'select * from ggircs.attributable_emissions_with_details',
    $$ select
        e.id,
        o.business_legal_name,
        fc.facility_name,
        fc.facility_type,
        ac.process_name,
        ac.sub_process_name,
        e.emission_type,
        e.gas_type,
        e.quantity,
        e.calculated_quantity,
        e.methodology,
        regexp_replace(
         regexp_replace(
          e.emission_category, 'BC_ScheduleB_', ''), 'Emissions', ''
         )::varchar(1000) as emission_category,
        rp.reporting_period_duration,
        f.fuel_type,
        f.fuel_units,
        f.fuel_classification,
        f.fuel_description,
        f.annual_fuel_amount,
        f.annual_weighted_avg_carbon_content,
        f.annual_weighted_avg_hhv,
        f.annual_steam_generation,
        f.alternative_methodology_description,
        n.naics_classification,
        n.naics_code,
        u.unit_name,
        u.id as unit_id,
        e.ghgr_import_id,
        e.report_id,
        e.organisation_id,
        e.single_facility_id,
        rp.swrs_report_id,
        o.swrs_organisation_id,
        fc.swrs_facility_id
      from ggircs.emission as e
        join ggircs.fuel as f on e.fuel_id = f.id
        join ggircs.naics as n on e.naics_id = n.id
        join ggircs.single_facility as fc on e.single_facility_id = fc.id
        join ggircs.report as rp on e.report_id = rp.id
        join ggircs.activity as ac on e.activity_id = ac.id
        join ggircs.organisation as o on e.organisation_id = o.id
        join ggircs.unit as u on e.unit_id = u.id

        $$,
    'ggircs.attributable_emissions_with_details has correct information'

);
select * from ggircs.attributable_emissions_with_details;

select * from finish();
rollback;
