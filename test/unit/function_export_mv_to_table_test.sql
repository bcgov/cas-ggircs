set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select plan(79);

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
            <Code>123456</Code>
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
    <FacilityType>EIO</FacilityType>
    <OrganisationId>0000</OrganisationId>
    <ReportingPeriodDuration>2012</ReportingPeriodDuration>
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
              <Code>123456</Code>
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
                  <FuelType>Wood Waste</FuelType>
                  <FuelClassification>Biomass in Schedule C</FuelClassification>
                  <FuelDescription/>
                  <FuelUnits>bone dry tonnes</FuelUnits>
                  <AnnualFuelAmount>0</AnnualFuelAmount>
                  <AnnualSteamGeneration>290471000</AnnualSteamGeneration>
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
            <Code>123456</Code>
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
    <ReportID>1235</ReportID>
    <ReportType>R1</ReportType>
    <FacilityId>0001</FacilityId>
    <FacilityType>ABC</FacilityType>
    <OrganisationId>0000</OrganisationId>
    <ReportingPeriodDuration>2012</ReportingPeriodDuration>
    <ReportStatus>
      <Status>Submitted</Status>
      <SubmissionDate>2013-03-28T19:25:55.32</SubmissionDate>
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
              <IdentifierValue></IdentifierValue>
            </Identifier>
          </IdentifierList>
          <NAICSCodeList>
            <NAICSCode>
              <Code>123456</Code>
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
                  <FuelType>Wood Waste</FuelType>
                  <FuelClassification>Biomass in Schedule C</FuelClassification>
                  <FuelDescription/>
                  <FuelUnits>bone dry tonnes</FuelUnits>
                  <AnnualFuelAmount>0</AnnualFuelAmount>
                  <AnnualSteamGeneration>290471000</AnnualSteamGeneration>
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

-- Refresh all materialized views
select ggircs_swrs.refresh_materialized_views(true);

-- Function has populated materialized views
select isnt_empty('select * from ggircs_swrs.report', 'refresh_materialized_views(true) has populated matviews');

-- Run table export function
select ggircs_swrs.export_mv_to_table();

-- Refresh all materialized views (run again so materialized views are populated for data equality tests below)
select ggircs_swrs.refresh_materialized_views(true);

-- Function export_mv_to_table exists
select has_function( 'ggircs_swrs', 'export_mv_to_table', 'Schema ggircs_swrs has function export_mv_to_table()' );

-- All tables created by the function exist in schema ggircs
select tables_are('ggircs'::name, ARRAY[
    'report'::name,
    'organisation'::name,
    'facility'::name,
    'activity'::name,
    'unit'::name,
    'identifier'::name,
    'naics'::name,
    'emission'::name,
    'attributable_emission'::name,
    'final_report'::name,
    'fuel'::name,
    'permit'::name,
    'parent_organisation'::name,
    'contact'::name,
    'address'::name,
    'descriptor'::name
    ],
    $$Schema ggircs has tables [
                             report, organisation, facility, activity,
                             unit, identifier, naics. emission, attributable_emission, final_report,
                             fuel, permit, parent_organisation, contact, address
                             descriptor $$
);

-- Test all tables have primary key
select has_pk('ggircs', 'report', 'ggircs_report has primary key');
select has_pk('ggircs', 'organisation', 'ggircs_organisation has primary key');
select has_pk('ggircs', 'facility', 'ggircs.facility has primary key');
select has_pk('ggircs', 'activity', 'ggircs_activity has primary key');
select has_pk('ggircs', 'unit', 'ggircs_unit has primary key');
select has_pk('ggircs', 'identifier', 'ggircs_identifier has primary key');
select has_pk('ggircs', 'naics', 'ggircs_naics has primary key');
select has_pk('ggircs', 'emission', 'ggircs_emission has primary key');
select has_pk('ggircs', 'final_report', 'ggircs_final_report has primary key');
select has_pk('ggircs', 'fuel', 'ggircs_fuel has primary key');
select has_pk('ggircs', 'permit', 'ggircs_permit has primary key');
select has_pk('ggircs', 'parent_organisation', 'ggircs_parent_organisation has primary key');
select has_pk('ggircs', 'contact', 'ggircs_contact has primary key');
select has_pk('ggircs', 'address', 'ggircs_address has primary key');
select has_pk('ggircs', 'descriptor', 'ggircs_descriptor has primary key');

-- Test tables have foreign key constraints (No FK constraints: report, final_report, parent_organisation)
-- select has_fk('ggircs', 'report', 'ggircs_report has foreign key constraint(s)');
select has_fk('ggircs', 'organisation', 'ggircs_organisation has foreign key constraint(s)');
select has_fk('ggircs', 'facility', 'ggircs_facility has foreign key constraint(s)');
select has_fk('ggircs', 'activity', 'ggircs_activity has foreign key constraint(s)');
select has_fk('ggircs', 'unit', 'ggircs_unit has foreign key constraint(s)');
select has_fk('ggircs', 'identifier', 'ggircs_identifier has foreign key constraint(s)');
select has_fk('ggircs', 'naics', 'ggircs_naics has foreign key constraint(s)');
select has_fk('ggircs', 'emission', 'ggircs.emission has foreign key constraint(s)');
-- select has_fk('ggircs', 'final_report', 'ggircs_final_report has foreign key constraint(s)');
select has_fk('ggircs', 'fuel', 'ggircs_fuel has foreign key constraint(s)');
select has_fk('ggircs', 'permit', 'ggircs_permit has foreign key constraint(s)');
-- select has_fk('ggircs', 'parent_organisation', 'ggircs_parent_organisation has foreign key constraint(s)');
select has_fk('ggircs', 'contact', 'ggircs_contact has foreign key constraint(s)');
select has_fk('ggircs', 'address', 'ggircs_address has foreign key constraint(s)');
select has_fk('ggircs', 'descriptor', 'ggircs_descriptor has foreign key constraint(s)');

-- All tables in schema ggircs have data
select isnt_empty('select * from ggircs.report', 'there is data in ggircs.report');
select isnt_empty('select * from ggircs.organisation', 'there is data in ggircs.organisation');
select isnt_empty('select * from ggircs.facility', 'facility has data');
select isnt_empty('select * from ggircs.activity', 'there is data in ggircs.activity');
select isnt_empty('select * from ggircs.unit', 'there is data in ggircs.unit');
select isnt_empty('select * from ggircs.identifier', 'there is data in ggircs.identifier');
select isnt_empty('select * from ggircs.naics', 'there is data in ggircs.naics');
select isnt_empty('select * from ggircs.emission', 'there is data in ggircs.emission');
select isnt_empty('select * from ggircs.attributable_emission', 'attributable_emission has data');
select isnt_empty('select * from ggircs.final_report', 'there is data in ggircs.final_report');
select isnt_empty('select * from ggircs.fuel', 'there is data in ggircs.fuel');
select isnt_empty('select * from ggircs.permit', 'there is data in ggircs.permit');
select isnt_empty('select * from ggircs.parent_organisation', 'there is data in ggircs.parent_organisation');
select isnt_empty('select * from ggircs.contact', 'there is data in ggircs.contact');
select isnt_empty('select * from ggircs.address', 'there is data in ggircs.address');
select isnt_empty('select * from ggircs.descriptor', 'there is data in ggircs.descriptor');

-- No CO2bioC in attributable_emission
select is_empty($$select * from ggircs.attributable_emission where gas_type='CO2bioC'$$, 'CO2bioC emissions are not in attributable_emission');

-- Test validity of FK relations
-- Emission -> Fuel
select results_eq(
    $$select distinct(fuel.ghgr_import_id) from ggircs.emission
      join ggircs.fuel
      on
        emission.fuel_id = fuel.id
    $$,

    'select distinct(ghgr_import_id) from ggircs.fuel',

    'Foreign key fuel_id in ggircs.emission references ggircs.fuel.id'
);

-- Fuel -> Unit
select results_eq(
    $$select distinct(fuel.ghgr_import_id) from ggircs.fuel
      join ggircs.unit
      on
        fuel.unit_id = unit.id
    $$,

    'select distinct(ghgr_import_id) from ggircs.unit',

    'Foreign key unit_id in ggircs.fuel references ggircs.unit.id'
);

-- Unit -> Activity
select results_eq(
    $$select distinct(activity.ghgr_import_id) from ggircs.unit
      join ggircs.activity
      on
        unit.activity_id = activity.id
    $$,

    'select distinct(ghgr_import_id) from ggircs.activity',

    'Foreign key unit_id in ggircs.unit references ggircs.activity.id'
);

-- Descriptor -> Activity
select results_eq(
    $$select distinct(activity.ghgr_import_id) from ggircs.descriptor
      join ggircs.activity
      on
        descriptor.activity_id = activity.id
    $$,

    'select distinct(ghgr_import_id) from ggircs.activity',

    'Foreign key activity_id in ggircs.descriptor references ggircs.activity.id'
);

-- Activity -> Report
select results_eq(
    $$select distinct(report.ghgr_import_id) from ggircs.activity
      join ggircs.report
      on
        activity.report_id = report.id
        order by report.ghgr_import_id asc
    $$,

    'select distinct(ghgr_import_id) from ggircs.report order by ghgr_import_id asc',

    'Foreign key report_id in ggircs.activity references ggircs.report.id'
);

-- Address -> Organisation
select results_eq(
    $$select distinct(organisation.ghgr_import_id) from ggircs.address
      join ggircs.organisation
      on
        address.organisation_id = organisation.id
    $$,

    'select ghgr_import_id from ggircs.organisation',

    'Foreign key organisation_id in ggircs.address references ggircs.organisation.id'
);

-- Address -> Parent Organisation
select results_eq(
    $$select distinct(parent_organisation.ghgr_import_id) from ggircs.address
      join ggircs.parent_organisation
      on
        address.parent_organisation_id = parent_organisation.id
    $$,

    'select ghgr_import_id from ggircs.parent_organisation',

    'Foreign key parent_organisation_id in ggircs.address references ggircs.parent_organisation.id'
);

-- Contact -> Address
select results_eq(
    $$select distinct(address.ghgr_import_id) from ggircs.contact
      join ggircs.address
      on
        contact.address_id = address.id
    $$,

    'select distinct(ghgr_import_id) from ggircs.address',

    'Foreign key address_id in ggircs.contact references ggircs.address.id'
);

-- Organisation -> Parent Organisation
select results_eq(
    $$select distinct(parent_organisation.ghgr_import_id) from ggircs.organisation
      join ggircs.parent_organisation
      on
        organisation.parent_organisation_id = parent_organisation.id
    $$,

    'select ghgr_import_id from ggircs.parent_organisation',

    'Foreign key parent_organisation_id in ggircs.organisation references ggircs.parent_organisation.id'
);

-- Attributable Emission -> Fuel
select results_eq(
    $$select fuel.fuel_type from ggircs.attributable_emission
      join ggircs.fuel
      on
        attributable_emission.fuel_id = fuel.id
        order by fuel.ghgr_import_id
    $$,

    'select fuel_type from ggircs.fuel where ghgr_import_id=2 and fuel_idx = 1',

    'Foreign key fuel_id in ggircs.attributable_emission references ggircs.fuel.id'
);

-- Activity -> Facility
select results_eq(
    $$select distinct(facility.ghgr_import_id) from ggircs.activity
      join ggircs.facility
      on
        activity.facility_id = facility.id
        order by ghgr_import_id
    $$,

    'select ghgr_import_id from ggircs.facility order by ghgr_import_id',

    'Foreign key facility_id in ggircs.activity references ggircs.facility.id'
);

-- Facility -> Report
select results_eq(
    $$select report.swrs_facility_id from ggircs.facility
      join ggircs.report
      on
        facility.report_id = report.id
        order by report.ghgr_import_id
    $$,

    'select swrs_facility_id from ggircs.report order by ghgr_import_id',

    'Foreign key report_id in ggircs.facility references ggircs.report.id'
);

-- Address -> Facility
select results_eq(
    $$select distinct(facility.ghgr_import_id) from ggircs.address
      join ggircs.facility
      on
        address.facility_id = facility.id
        order by ghgr_import_id
    $$,
-- --
    'select ghgr_import_id from ggircs.facility order by ghgr_import_id',
-- --
    'Foreign key facility_id in ggircs.address references ggircs.facility.id'
);

-- Contact -> Facility
select results_eq(
    $$select distinct(facility.ghgr_import_id) from ggircs.contact
      join ggircs.facility
      on
        contact.facility_id = facility.id
        order by ghgr_import_id
    $$,

    'select ghgr_import_id from ggircs.facility order by ghgr_import_id',

    'Foreign key facility_id in ggircs.contact references ggircs.facility.id'
);

-- Identifier -> Facility
select results_eq(
    $$select distinct(facility.ghgr_import_id) from ggircs.identifier
      join ggircs.facility
      on
        identifier.facility_id = facility.id
        order by ghgr_import_id
    $$,

    'select ghgr_import_id from ggircs.facility order by ghgr_import_id',

    'Foreign key facility_id in ggircs.identifier references ggircs.facility.id'
);

-- NAICS -> Facility
select results_eq(
    $$select distinct(facility.ghgr_import_id) from ggircs.naics
      join ggircs.facility
      on
        naics.facility_id = facility.id
        order by ghgr_import_id
    $$,

    'select ghgr_import_id from ggircs.facility order by ghgr_import_id',

    'Foreign key facility_id in ggircs.naics references ggircs.facility.id'
);

-- Permit -> Facility
select results_eq(
    $$select facility.ghgr_import_id from ggircs.permit
      join ggircs.facility
      on
        permit.facility_id = facility.id
        order by ghgr_import_id
    $$,

    'select ghgr_import_id from ggircs.facility order by ghgr_import_id',

    'Foreign key facility_id in ggircs.permit references ggircs.facility.id'
);

/** Test data transferred from ggircs_swrs to ggircs properly **/
-- Data in ggircs_swrs.report === data in ggircs_report
select results_eq($$select
                      ghgr_import_id,
                      source_xml::text,
                      imported_at,
                      swrs_report_id,
                      prepop_report_id,
                      report_type,
                      swrs_facility_id,
                      swrs_organisation_id,
                      reporting_period_duration,
                      status,
                      version,
                      submission_date,
                      last_modified_by,
                      last_modified_date,
                      update_comment,
                      swrs_report_history_id
                  from ggircs_swrs.report

                  order by ghgr_import_id
                  $$,

                 $$select
                      ghgr_import_id,
                      source_xml::text,
                      imported_at,
                      swrs_report_id,
                      prepop_report_id,
                      report_type,
                      swrs_facility_id,
                      swrs_organisation_id,
                      reporting_period_duration,
                      status,
                      version,
                      submission_date,
                      last_modified_by,
                      last_modified_date,
                      update_comment,
                      swrs_report_history_id
                  from ggircs.report

                  order by ghgr_import_id
                  $$,

    'data in ggircs_swrs.report === ggircs.report');

-- Data in ggircs_swrs.organisation === data in ggircs.organisation
select results_eq($$select
                      ghgr_import_id,
                      swrs_organisation_id,
                      business_legal_name,
                      english_trade_name,
                      french_trade_name,
                      cra_business_number,
                      duns,
                      website
                  from ggircs_swrs.organisation
                  order by ghgr_import_id
                  $$,

                 $$select
                      ghgr_import_id,
                      swrs_organisation_id,
                      business_legal_name,
                      english_trade_name,
                      french_trade_name,
                      cra_business_number,
                      duns,
                      website
                  from ggircs.organisation
                  order by ghgr_import_id
                  $$,

    'data in ggircs_swrs.organisation === ggircs.organisation');

select * from ggircs_swrs.organisation;

-- Data in ggircs_swrs.activity === data in ggircs.activity
select results_eq($$select
                      ghgr_import_id,
                      process_idx,
                      sub_process_idx,
                      activity_name,
                      process_name,
                      sub_process_name,
                      information_requirement
                  from ggircs_swrs.activity
                  order by ghgr_import_id, process_idx, sub_process_idx, activity_name asc
                  $$,

                 $$select
                      ghgr_import_id,
                      process_idx,
                      sub_process_idx,
                      activity_name,
                      process_name,
                      sub_process_name,
                      information_requirement
                  from ggircs.activity
                  order by ghgr_import_id, process_idx, sub_process_idx, activity_name asc
                  $$,

    'data in ggircs_swrs.activity === ggircs.activity');

-- Data in ggircs_swrs.unit === data in ggircs.unit
select results_eq(
              $$select
                  ghgr_import_id,
                  activity_name,
                  process_idx,
                  sub_process_idx,
                  units_idx,
                  unit_idx,
                  unit_name,
                  unit_description,
                  cogen_unit_name,
                  cogen_cycle_type,
                  cogen_nameplate_capacity,
                  cogen_net_power,
                  cogen_steam_heat_acq_quantity,
                  cogen_steam_heat_acq_name,
                  cogen_supplemental_firing_purpose,
                  cogen_thermal_output_quantity,
                  non_cogen_nameplate_capacity,
                  non_cogen_net_power,
                  non_cogen_unit_name

                from ggircs_swrs.unit
                order by
                    ghgr_import_id,
                    activity_name,
                    process_idx,
                    sub_process_idx,
                    units_idx,
                    unit_idx
                 asc
              $$,

              $$select
                  ghgr_import_id,
                  activity_name,
                  process_idx,
                  sub_process_idx,
                  units_idx,
                  unit_idx,
                  unit_name,
                  unit_description,
                  cogen_unit_name,
                  cogen_cycle_type,
                  cogen_nameplate_capacity,
                  cogen_net_power,
                  cogen_steam_heat_acq_quantity,
                  cogen_steam_heat_acq_name,
                  cogen_supplemental_firing_purpose,
                  cogen_thermal_output_quantity,
                  non_cogen_nameplate_capacity,
                  non_cogen_net_power,
                  non_cogen_unit_name

                from ggircs.unit
                order by
                    ghgr_import_id,
                    activity_name,
                    process_idx,
                    sub_process_idx,
                    units_idx,
                    unit_idx
                 asc
              $$,

              'data in ggircs_swrs.unit === ggircs.unit');

-- Data in ggircs_swrs.identifier === data in ggircs.identifier
select results_eq(
              $$select
                  ghgr_import_id,
                  swrs_facility_id,
                  path_context,
                  identifier_idx,
                  identifier_type,
                  identifier_value
                from ggircs_swrs.identifier
                order by
                    ghgr_import_id,
                    swrs_facility_id,
                    path_context,
                    identifier_idx
                 asc
              $$,

              $$select
                  ghgr_import_id,
                  swrs_facility_id,
                  path_context,
                  identifier_idx,
                  identifier_type,
                  identifier_value
                from ggircs.identifier
                order by
                    ghgr_import_id,
                    swrs_facility_id,
                    path_context,
                    identifier_idx
                 asc
              $$,

              'data in ggircs_swrs.identifier === ggircs.identifier');

-- Data in ggircs_swrs.naics === data in ggircs.naics
select results_eq(
              $$select
                  ghgr_import_id,
                  swrs_facility_id,
                  path_context,
                  naics_code_idx,
                  naics_classification,
                  naics_code,
                  naics_priority
                from ggircs_swrs.naics
                order by
                    ghgr_import_id,
                    swrs_facility_id,
                    path_context,
                    naics_code_idx
                 asc
              $$,

              $$select
                  ghgr_import_id,
                  swrs_facility_id,
                  path_context,
                  naics_code_idx,
                  naics_classification,
                  naics_code,
                  naics_priority
                from ggircs.naics
                order by
                    ghgr_import_id,
                    swrs_facility_id,
                    path_context,
                    naics_code_idx
                 asc
              $$,

              'data in ggircs_swrs.naics === ggircs.naics');

-- Data in ggircs_swrs.emission === data in ggircs.emission
select results_eq(
              $$select
                emission.ghgr_import_id,
                activity_name,
                sub_activity_name,
                unit_name,
                sub_unit_name,
                process_idx,
                sub_process_idx,
                units_idx,
                unit_idx,
                substances_idx,
                substance_idx,
                fuel_idx,
                fuel_name,
                emissions_idx,
                emission_idx,
                emission_type,
                gas_type,
                methodology,
                not_applicable,
                quantity,
                calculated_quantity,
                emission_category
              from ggircs_swrs.emission
              order by
                ghgr_import_id,
                process_idx,
                sub_process_idx,
                units_idx,
                unit_idx,
                substances_idx,
                substance_idx,
                fuel_idx,
                emissions_idx,
                emission_idx asc
              $$,

              $$select
                  ghgr_import_id,
                  activity_name,
                  sub_activity_name,
                  unit_name,
                  sub_unit_name,
                  process_idx,
                  sub_process_idx,
                  units_idx,
                  unit_idx,
                  substances_idx,
                  substance_idx,
                  fuel_idx,
                  fuel_name,
                  emissions_idx,
                  emission_idx,
                  emission_type,
                  gas_type,
                  methodology,
                  not_applicable,
                  quantity,
                  calculated_quantity,
                  emission_category
                from ggircs.emission
                order by
                    ghgr_import_id,
                    process_idx,
                    sub_process_idx,
                    units_idx,
                    unit_idx,
                    substances_idx,
                    substance_idx,
                    fuel_idx,
                    emissions_idx,
                    emission_idx
                 asc
              $$,

              'data in ggircs_swrs.emission === ggircs.emission');

select results_eq(
    'select ghgr_import_id, swrs_report_id from ggircs_swrs.final_report order by ghgr_import_id asc',
    'select ghgr_import_id, swrs_report_id from ggircs.final_report order by ghgr_import_id asc',
    'data in ggircs_swrs.emission === ggircs.emission'
);

-- Data in ggircs_swrs.fuel === data in ggircs.fuel
select results_eq(
              $$select
                  ghgr_import_id,
                  activity_name,
                  sub_activity_name,
                  unit_name,
                  sub_unit_name,
                  process_idx,
                  sub_process_idx,
                  units_idx,
                  unit_idx,
                  substances_idx,
                  substance_idx,
                  fuel_idx,
                  fuel_type,
                  fuel_classification,
                  fuel_description,
                  fuel_units,
                  annual_fuel_amount,
                  annual_weighted_avg_carbon_content,
                  annual_weighted_avg_hhv,
                  annual_steam_generation,
                  alternative_methodology_description,
                  other_flare_details,
                  q1,
                  q2,
                  q3,
                  q4,
                  wastewater_processing_factors::text,
                  measured_conversion_factors::text
                from ggircs_swrs.fuel
                order by
                    process_idx,
                    sub_process_idx,
                    units_idx,
                    unit_idx,
                    substances_idx,
                    substance_idx,
                    fuel_idx
                 asc
              $$,

              $$select
                  ghgr_import_id,
                  activity_name,
                  sub_activity_name,
                  unit_name,
                  sub_unit_name,
                  process_idx,
                  sub_process_idx,
                  units_idx,
                  unit_idx,
                  substances_idx,
                  substance_idx,
                  fuel_idx,
                  fuel_type,
                  fuel_classification,
                  fuel_description,
                  fuel_units,
                  annual_fuel_amount,
                  annual_weighted_avg_carbon_content,
                  annual_weighted_avg_hhv,
                  annual_steam_generation,
                  alternative_methodology_description,
                  other_flare_details,
                  q1,
                  q2,
                  q3,
                  q4,
                  wastewater_processing_factors::text,
                  measured_conversion_factors::text
                from ggircs.fuel
                order by
                    process_idx,
                    sub_process_idx,
                    units_idx,
                    unit_idx,
                    substances_idx,
                    substance_idx,
                    fuel_idx
                 asc
              $$,

              'data in ggircs_swrs.fuel === ggircs.fuel');

-- Data in ggircs_swrs.permit === data in ggircs.permit
select results_eq(
              $$select
                  ghgr_import_id,
                  path_context,
                  permit_idx,
                  issuing_agency,
                  issuing_dept_agency_program,
                  permit_number
                from ggircs_swrs.permit
                order by
                  ghgr_import_id,
                  path_context
                 asc
              $$,

              $$select
                  ghgr_import_id,
                  path_context,
                  permit_idx,
                  issuing_agency,
                  issuing_dept_agency_program,
                  permit_number
                from ggircs.permit
                order by
                  ghgr_import_id,
                  path_context
                 asc
              $$,

              'data in ggircs_swrs.permit === ggircs.permit');

-- Data in ggircs_swrs.parent_organisation === data in ggircs.parent_organisation
select results_eq(
              $$select
                  ghgr_import_id,
                  path_context,
                  parent_organisation_idx,
                  percentage_owned,
                  french_trade_name,
                  english_trade_name,
                  duns,
                  business_legal_name,
                  website
                from ggircs_swrs.parent_organisation
                order by
                  ghgr_import_id,
                  path_context,
                  parent_organisation_idx
                 asc
              $$,

              $$select
                  ghgr_import_id,
                  path_context,
                  parent_organisation_idx,
                  percentage_owned,
                  french_trade_name,
                  english_trade_name,
                  duns,
                  business_legal_name,
                  website
                from ggircs.parent_organisation
                order by
                  ghgr_import_id,
                  path_context,
                  parent_organisation_idx
                 asc
              $$,

              'data in ggircs_swrs.parent_organisation === ggircs.parent_organisation');

-- Data in ggircs_swrs.contact === data in ggircs.contact
select results_eq(
              $$select
                  ghgr_import_id,
                  path_context,
                  contact_idx,
                  contact_type,
                  given_name,
                  family_name,
                  initials,
                  telephone_number,
                  extension_number,
                  fax_number,
                  email_address,
                  position,
                  language_correspondence
                from ggircs_swrs.contact
                order by
                  ghgr_import_id,
                  path_context,
                  contact_idx
                 asc
              $$,

              $$select
                  ghgr_import_id,
                  path_context,
                  contact_idx,
                  contact_type,
                  given_name,
                  family_name,
                  initials,
                  telephone_number,
                  extension_number,
                  fax_number,
                  email_address,
                  position,
                  language_correspondence
                from ggircs.contact
                order by
                  ghgr_import_id,
                  path_context,
                  contact_idx
                 asc
              $$,

              'data in ggircs_swrs.contact === ggircs.contact');

-- Data in ggircs_swrs.address === data in ggircs.address
select results_eq(
              $$select
                  ghgr_import_id,
                  swrs_facility_id,
                  swrs_organisation_id,
                  path_context,
                  type,
                  contact_idx,
                  parent_organisation_idx,
                  physical_address_municipality,
                  physical_address_unit_number,
                  physical_address_street_number,
                  physical_address_street_number_suffix,
                  physical_address_street_name,
                  physical_address_street_type,
                  physical_address_street_direction,
                  physical_address_prov_terr_state,
                  physical_address_postal_code_zip_code,
                  physical_address_country,
                  physical_address_national_topographical_description,
                  physical_address_additional_information,
                  physical_address_land_survey_description,
                  mailing_address_delivery_mode,
                  mailing_address_po_box_number,
                  mailing_address_unit_number,
                  mailing_address_rural_route_number,
                  mailing_address_street_number,
                  mailing_address_street_number_suffix,
                  mailing_address_street_name,
                  mailing_address_street_type,
                  mailing_address_street_direction,
                  mailing_address_municipality,
                  mailing_address_prov_terr_state,
                  mailing_address_postal_code_zip_code,
                  mailing_address_country,
                  mailing_address_additional_information,
                  geographic_address_latitude,
                  geographic_address_longitude
                from ggircs_swrs.address
                order by
                  ghgr_import_id,
                  swrs_facility_id,
                  swrs_organisation_id,
                  type,
                  path_context,
                  contact_idx,
                  parent_organisation_idx
                 asc
              $$,

              $$select
                  ghgr_import_id,
                  swrs_facility_id,
                  swrs_organisation_id,
                  path_context,
                  type,
                  contact_idx,
                  parent_organisation_idx,
                  physical_address_municipality,
                  physical_address_unit_number,
                  physical_address_street_number,
                  physical_address_street_number_suffix,
                  physical_address_street_name,
                  physical_address_street_type,
                  physical_address_street_direction,
                  physical_address_prov_terr_state,
                  physical_address_postal_code_zip_code,
                  physical_address_country,
                  physical_address_national_topographical_description,
                  physical_address_additional_information,
                  physical_address_land_survey_description,
                  mailing_address_delivery_mode,
                  mailing_address_po_box_number,
                  mailing_address_unit_number,
                  mailing_address_rural_route_number,
                  mailing_address_street_number,
                  mailing_address_street_number_suffix,
                  mailing_address_street_name,
                  mailing_address_street_type,
                  mailing_address_street_direction,
                  mailing_address_municipality,
                  mailing_address_prov_terr_state,
                  mailing_address_postal_code_zip_code,
                  mailing_address_country,
                  mailing_address_additional_information,
                  geographic_address_latitude,
                  geographic_address_longitude
                from ggircs.address
                order by
                  ghgr_import_id,
                  swrs_facility_id,
                  swrs_organisation_id,
                  type,
                  path_context,
                  contact_idx,
                  parent_organisation_idx
                 asc
              $$,

              'data in ggircs_swrs.address === ggircs.address');

-- Data in ggircs_swrs.descriptor === data in ggircs.descriptor
select results_eq(
              $$select
                    ghgr_import_id,
                    process_idx,
                    sub_process_idx,
                    grandparent_idx,
                    parent_idx,
                    class_idx,
                    grandparent,
                    parent,
                    class,
                    attribute,
                    attr_value,
                    node_value
                from ggircs_swrs.descriptor
                order by
                  ghgr_import_id,
                  process_idx,
                  sub_process_idx,
                  grandparent_idx,
                  parent_idx,
                  class_idx,
                  grandparent,
                  parent,
                  class,
                  node_value
                 asc
              $$,

              $$select
                    ghgr_import_id,
                    process_idx,
                    sub_process_idx,
                    grandparent_idx,
                    parent_idx,
                    class_idx,
                    grandparent,
                    parent,
                    class,
                    attribute,
                    attr_value,
                    node_value
                from ggircs.descriptor
                order by
                  ghgr_import_id,
                  process_idx,
                  sub_process_idx,
                  grandparent_idx,
                  parent_idx,
                  class_idx,
                  grandparent,
                  parent,
                  class,
                  node_value
                 asc
              $$,

              'data in ggircs_swrs.descriptor === ggircs.descriptor');

  select ggircs_swrs.refresh_materialized_views(false);

  -- Refresh function has cleared materialized views
  select is_empty('select * from ggircs_swrs.report where false', 'refresh_materialized_views(false) has cleared materialized views');

select * from finish();
rollback;
