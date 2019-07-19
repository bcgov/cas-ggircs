set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select * from no_plan();

-- View should exist
select has_view(
    'ggircs', 'attributable_emissions_with_details',
    'ggircs_swrs_load.attributable_emission should be a view'
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
insert into ggircs_swrs_extract.ghgr_import (xml_file) values ($$
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
refresh materialized view ggircs_swrs_transform.report with data;
refresh materialized view ggircs_swrs_transform.final_report with data;
refresh materialized view ggircs_swrs_transform.organisation with data;
refresh materialized view ggircs_swrs_transform.facility with data;
refresh materialized view ggircs_swrs_transform.activity with data;
refresh materialized view ggircs_swrs_transform.naics with data;
refresh materialized view ggircs_swrs_transform.fuel with data;
refresh materialized view ggircs_swrs_transform.unit with data;
refresh materialized view ggircs_swrs_transform.emission with data;

-- Populate necessary ggircs tables
select ggircs_swrs_transform.load_report();
select ggircs_swrs_transform.load_organisation();
select ggircs_swrs_transform.load_facility();
select ggircs_swrs_transform.load_activity();
select ggircs_swrs_transform.load_unit();
select ggircs_swrs_transform.load_naics();
select ggircs_swrs_transform.load_fuel();
select ggircs_swrs_transform.load_emission();

-- Test fk relations
-- Report
select set_eq(
    $$ select report.id from ggircs_swrs_load.attributable_emissions_with_details as ae
       join ggircs_swrs_load.report on ae.report_id = report.id
    $$,
    'select id from ggircs_swrs_load.report',
    'fk report_id references report'
);

select set_eq(
    $$ select organisation.id from ggircs_swrs_load.attributable_emissions_with_details as ae
       join ggircs_swrs_load.organisation on ae.organisation_id = organisation.id
    $$,
    'select id from ggircs_swrs_load.organisation',
    'fk organisation_id references organisation'
);

-- Facility
select set_eq(
    $$ select facility.id from ggircs_swrs_load.attributable_emissions_with_details as ae
       join ggircs_swrs_load.facility on ae.facility_id = facility.id
    $$,
    'select id from ggircs_swrs_load.facility',
    'fk facility_id references facility'
);

-- Unit
select set_eq(
    $$ select unit.id from ggircs_swrs_load.attributable_emissions_with_details as ae
       join ggircs_swrs_load.unit on ae.unit_id = unit.id
    $$,
    'select id from ggircs_swrs_load.unit',
    'fk unit_id references unit'
);

-- Attributable Emissions with details has correct information
select set_eq(
   'select * from ggircs_swrs_load.attributable_emissions_with_details',
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
        e.facility_id,
        rp.swrs_report_id,
        o.swrs_organisation_id,
        fc.swrs_facility_id
      from ggircs_swrs_load.emission as e
        join ggircs_swrs_load.fuel as f on e.fuel_id = f.id
        join ggircs_swrs_load.naics as n on e.naics_id = n.id
        join ggircs_swrs_load.facility as fc on e.facility_id = fc.id
        join ggircs_swrs_load.report as rp on e.report_id = rp.id
        join ggircs_swrs_load.activity as ac on e.activity_id = ac.id
        join ggircs_swrs_load.organisation as o on e.organisation_id = o.id
        join ggircs_swrs_load.unit as u on e.unit_id = u.id

        $$,
    'ggircs_swrs_load.attributable_emissions_with_details has correct information'

);

select * from finish();
rollback;
