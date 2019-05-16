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
        <BusinessLegalName>Spectra Energy Midstream Corporation</BusinessLegalName>
        <EnglishTradeName>Spectra Energy Midstream Corp</EnglishTradeName>
        <FrenchTradeName/>
        <CRABusinessNumber>891167728</CRABusinessNumber>
        <DUNSNumber>201172186</DUNSNumber>
        <WebSite>www.spectraenergy.com</WebSite>
      </Details>
      <Address>
        <PhysicalAddress>
          <UnitNumber>2200</UnitNumber>
          <StreetNumber>425</StreetNumber>
          <StreetName>1st Street West</StreetName>
          <StreetType>Street</StreetType>
          <StreetDirection>West</StreetDirection>
          <Municipality>Calgary</Municipality>
          <ProvTerrState>Alberta</ProvTerrState>
          <PostalCodeZipCode>T2P3L8</PostalCodeZipCode>
          <Country>Canada</Country>
        </PhysicalAddress>
        <MailingAddress>
          <DeliveryMode>General Delivery</DeliveryMode>
          <UnitNumber>22</UnitNumber>
          <StreetNumber>425</StreetNumber>
          <StreetName>1st Street West</StreetName>
          <StreetType>Street</StreetType>
          <StreetDirection>West</StreetDirection>
          <Municipality>Calgary</Municipality>
          <ProvTerrState>Alberta</ProvTerrState>
          <PostalCodeZipCode>T2P3L8</PostalCodeZipCode>
          <Country>Canada</Country>
          <AdditionalInformation/>
        </MailingAddress>
      </Address>
    </Organisation>
    <Facility>
      <Details>
        <FacilityName>Highway Gas Plant</FacilityName>
        <RelationshipType>Owned and Operated</RelationshipType>
        <PortabilityIndicator>N</PortabilityIndicator>
        <Status>Active</Status>
      </Details>
      <Identifiers>
        <IdentifierList>
          <Identifier>
            <IdentifierType>BCGHGID</IdentifierType>
            <IdentifierValue>12111130550</IdentifierValue>
          </Identifier>
          <Identifier>
            <IdentifierType>GHGRP Identification Number</IdentifierType>
            <IdentifierValue>G10551</IdentifierValue>
          </Identifier>
          <Identifier>
            <IdentifierType>National Pollutant Release Inventory Identifier</IdentifierType>
            <IdentifierValue>5124</IdentifierValue>
          </Identifier>
        </IdentifierList>
        <NAICSCodeList>
          <NAICSCode>
            <NAICSClassification>Conventional Oil and Gas Extraction </NAICSClassification>
            <Code>211113</Code>
            <NaicsPriority>Primary</NaicsPriority>
          </NAICSCode>
        </NAICSCodeList>
        <Permits>
          <Permit>
            <IssuingAgency>BC Ministry of Environment</IssuingAgency>
            <PermitNumber>PA-14929</PermitNumber>
          </Permit>
        </Permits>
      </Identifiers>
      <Address>
        <PhysicalAddress>
          <UnitNumber>0</UnitNumber>
          <StreetName>Mile 121 Alaska Highway</StreetName>
          <Municipality>Peace River District</Municipality>
          <ProvTerrState>British Columbia</ProvTerrState>
          <PostalCodeZipCode>V1J4H7</PostalCodeZipCode>
          <Country>Canada</Country>
        </PhysicalAddress>
        <MailingAddress>
          <DeliveryMode>General Delivery</DeliveryMode>
          <StreetNumber>10923</StreetNumber>
          <StreetNumberSuffix/>
          <StreetName>Alaska Road</StreetName>
          <Municipality>Fort St John</Municipality>
          <ProvTerrState>British Columbia</ProvTerrState>
          <PostalCodeZipCode>V1J4H7</PostalCodeZipCode>
          <Country>Canada</Country>
          <AdditionalInformation>The Highway Plant is 100% owned by Spectra Energy Facilities LP</AdditionalInformation>
        </MailingAddress>
        <GeographicAddress>
          <Latitude>56.22780</Latitude>
          <Longitude>-120.81900</Longitude>
        </GeographicAddress>
      </Address>
      <StackList>
        <Stack>
          <StackNameDescription>Acid Gas Flare Stack</StackNameDescription>
          <HeightAboveGrade>76.2200</HeightAboveGrade>
          <EquivalentDiameter>0.2700</EquivalentDiameter>
          <AverageExitVelocity>20.000</AverageExitVelocity>
          <AverageExitTemperature>1000.000</AverageExitTemperature>
        </Stack>
        <Stack>
          <StackNameDescription>Emergency Flare Stack</StackNameDescription>
          <HeightAboveGrade>76.2200</HeightAboveGrade>
          <EquivalentDiameter>0.2700</EquivalentDiameter>
          <AverageExitVelocity>20.000</AverageExitVelocity>
          <AverageExitTemperature>1000.000</AverageExitTemperature>
        </Stack>
      </StackList>
    </Facility>
    <Contacts>
      <Contact>
        <Details>
          <ContactType>Operator Contact</ContactType>
          <GivenName>Mike</GivenName>
          <FamilyName>Bell</FamilyName>
          <TelephoneNumber>4036991758</TelephoneNumber>
          <FaxNumber>4036991590</FaxNumber>
          <EmailAddress>mrbell@spectraenergy.com</EmailAddress>
          <Position>Director, Environment and Risk Management</Position>
          <LanguageCorrespondence>English</LanguageCorrespondence>
        </Details>
        <Address>
          <PhysicalAddress>
            <StreetNumber>125</StreetNumber>
            <StreetNumberSuffix/>
            <StreetName>First Street</StreetName>
            <StreetType>Street</StreetType>
            <StreetDirection>Southwest</StreetDirection>
            <Municipality>Calgary</Municipality>
            <ProvTerrState>Alberta</ProvTerrState>
            <PostalCodeZipCode>T2P3L8</PostalCodeZipCode>
            <Country>Canada</Country>
          </PhysicalAddress>
          <MailingAddress>
            <StreetNumber>125</StreetNumber>
            <StreetName>First Street</StreetName>
            <StreetType>Street</StreetType>
            <StreetDirection>Southwest</StreetDirection>
            <Municipality>Calgary</Municipality>
            <ProvTerrState>Alberta</ProvTerrState>
            <PostalCodeZipCode>T2P3L8</PostalCodeZipCode>
            <Country>Canada</Country>
            <AdditionalInformation/>
          </MailingAddress>
        </Address>
      </Contact>
      <Contact>
        <Details>
          <ContactType>Operator Representative</ContactType>
          <GivenName>Al</GivenName>
          <FamilyName>Ritchie</FamilyName>
          <TelephoneNumber>2502623420</TelephoneNumber>
          <EmailAddress>aritchie@spectraenergy.com</EmailAddress>
          <Position>VP Operations</Position>
          <LanguageCorrespondence>English</LanguageCorrespondence>
        </Details>
        <Address>
          <MailingAddress>
            <StreetNumber>53</StreetNumber>
            <StreetNumberSuffix/>
            <StreetName>Alaska Highway</StreetName>
            <StreetType>Highway</StreetType>
            <Municipality>Fort St. John</Municipality>
            <ProvTerrState>British Columbia</ProvTerrState>
            <PostalCodeZipCode>V1J 4H7</PostalCodeZipCode>
            <Country>Canada</Country>
            <AdditionalInformation/>
          </MailingAddress>
        </Address>
      </Contact>
      <Contact>
        <Details>
          <ContactType>Person Who Prepared Report</ContactType>
          <GivenName>Katherine</GivenName>
          <Initials>A</Initials>
          <FamilyName>Wreford</FamilyName>
          <TelephoneNumber>6046915665</TelephoneNumber>
          <EmailAddress>kwreford@spectraenergy.com</EmailAddress>
          <Position>Environmental Specialist</Position>
          <LanguageCorrespondence>English</LanguageCorrespondence>
        </Details>
        <Address>
          <MailingAddress>
            <DeliveryMode>Post Office Box</DeliveryMode>
            <POBoxNumber>11162</POBoxNumber>
            <UnitNumber>1100</UnitNumber>
            <StreetNumber>1055</StreetNumber>
            <StreetNumberSuffix/>
            <StreetName>West Georgia Street</StreetName>
            <Municipality>Vancouver</Municipality>
            <ProvTerrState>British Columbia</ProvTerrState>
            <PostalCodeZipCode>V6E3R5</PostalCodeZipCode>
            <Country>Canada</Country>
            <AdditionalInformation/>
          </MailingAddress>
        </Address>
      </Contact>
    </Contacts>
    <ParentOrganisations>
      <ParentOrganisation>
        <Details>
          <BusinessLegalName>Spectra Energy Facilities Holdings Partnership</BusinessLegalName>
          <EnglishTradeName/>
          <FrenchTradeName/>
          <CRABusinessNumber>891167728</CRABusinessNumber>
          <DUNSNumber>0</DUNSNumber>
          <WebSite/>
          <PercentageOwned>100</PercentageOwned>
        </Details>
        <Address>
          <PhysicalAddress>
            <UnitNumber>1500</UnitNumber>
            <StreetNumber>500</StreetNumber>
            <StreetNumberSuffix/>
            <StreetName>4th</StreetName>
            <StreetType>Avenue</StreetType>
            <Municipality>Calgary</Municipality>
            <ProvTerrState>Alberta</ProvTerrState>
            <PostalCodeZipCode>T2P2V6</PostalCodeZipCode>
            <Country>Canada</Country>
            <AdditionalInformation/>
            <LandSurveyDescription/>
            <NationalTopographicalDescription/>
          </PhysicalAddress>
          <MailingAddress>
            <UnitNumber>1500</UnitNumber>
            <StreetNumber>500</StreetNumber>
            <StreetNumberSuffix/>
            <StreetName>4th</StreetName>
            <StreetType>Avenue</StreetType>
            <Municipality>Calgary</Municipality>
            <ProvTerrState>Alberta</ProvTerrState>
            <PostalCodeZipCode>T2P2V6</PostalCodeZipCode>
            <Country>Canada</Country>
            <AdditionalInformation/>
          </MailingAddress>
        </Address>
      </ParentOrganisation>
      <ParentOrganisation>
        <Details>
          <BusinessLegalName>Spectra Energy Facilities LP</BusinessLegalName>
          <EnglishTradeName/>
          <FrenchTradeName/>
          <CRABusinessNumber>891167728</CRABusinessNumber>
          <DUNSNumber>0</DUNSNumber>
          <WebSite/>
          <PercentageOwned>100</PercentageOwned>
        </Details>
        <Address>
          <PhysicalAddress>
            <UnitNumber>1500</UnitNumber>
            <StreetNumber>500</StreetNumber>
            <StreetNumberSuffix/>
            <StreetName>4th</StreetName>
            <StreetType>Avenue</StreetType>
            <Municipality>Calgary</Municipality>
            <ProvTerrState>Alberta</ProvTerrState>
            <PostalCodeZipCode>T2P2V6</PostalCodeZipCode>
            <Country>Canada</Country>
            <AdditionalInformation/>
            <LandSurveyDescription/>
            <NationalTopographicalDescription/>
          </PhysicalAddress>
          <MailingAddress>
            <UnitNumber>1500</UnitNumber>
            <StreetNumber>500</StreetNumber>
            <StreetNumberSuffix/>
            <StreetName>4th</StreetName>
            <StreetType>Avenue</StreetType>
            <Municipality>Calgary</Municipality>
            <ProvTerrState>Alberta</ProvTerrState>
            <PostalCodeZipCode>T2P2V6</PostalCodeZipCode>
            <Country>Canada</Country>
            <AdditionalInformation/>
          </MailingAddress>
        </Address>
      </ParentOrganisation>
      <ParentOrganisation>
        <Details>
          <BusinessLegalName>Spectra Energy Midstream</BusinessLegalName>
          <EnglishTradeName/>
          <FrenchTradeName/>
          <CRABusinessNumber>891167728</CRABusinessNumber>
          <DUNSNumber>0</DUNSNumber>
          <WebSite/>
          <PercentageOwned>100</PercentageOwned>
        </Details>
        <Address>
          <PhysicalAddress>
            <UnitNumber>1500</UnitNumber>
            <StreetNumber>500</StreetNumber>
            <StreetNumberSuffix/>
            <StreetName>4th</StreetName>
            <StreetType>Avenue</StreetType>
            <Municipality>Calgary</Municipality>
            <ProvTerrState>Alberta</ProvTerrState>
            <PostalCodeZipCode>T2P2V6</PostalCodeZipCode>
            <Country>Canada</Country>
            <AdditionalInformation/>
            <LandSurveyDescription/>
            <NationalTopographicalDescription/>
          </PhysicalAddress>
          <MailingAddress>
            <UnitNumber>1500</UnitNumber>
            <StreetNumber>500</StreetNumber>
            <StreetNumberSuffix/>
            <StreetName>4th</StreetName>
            <StreetType>Avenue</StreetType>
            <Municipality>Calgary</Municipality>
            <ProvTerrState>Alberta</ProvTerrState>
            <PostalCodeZipCode>T2P2V6</PostalCodeZipCode>
            <Country>Canada</Country>
            <AdditionalInformation/>
          </MailingAddress>
        </Address>
      </ParentOrganisation>
    </ParentOrganisations>
  </RegistrationData>
  <ReportDetails>
    <ReportID>5619</ReportID>
    <ReportType>R1</ReportType>
    <FacilityId>1316</FacilityId>
    <FacilityType>IF_a</FacilityType>
    <OrganisationId>5485</OrganisationId>
    <ReportingPeriodDuration>2014</ReportingPeriodDuration>
    <ReportStatus>
      <Status>Completed</Status>
      <LastModifiedBy>Jennifer Eby</LastModifiedBy>
    </ReportStatus>
    <ActivityOrSource>
      <ActivityList>
        <Activity>
          <ActivityName>ElectricityGeneration</ActivityName>
          <TableNumber>1</TableNumber>
        </Activity>
        <Activity>
          <ActivityName>GeneralStationaryCombustion2</ActivityName>
          <TableNumber>2</TableNumber>
        </Activity>
        <Activity>
          <ActivityName>OGExtractionProcessing</ActivityName>
          <TableNumber>2</TableNumber>
        </Activity>
      </ActivityList>
    </ActivityOrSource>
    <SelectSourceCategories>
      <OnshoreNGTransmissionCompressionPipelines>false</OnshoreNGTransmissionCompressionPipelines>
      <UndergroundNGStorage>false</UndergroundNGStorage>
      <LNGStorage>false</LNGStorage>
      <LNGImportExportEquipment>false</LNGImportExportEquipment>
      <NGDistribution>false</NGDistribution>
      <OnshorePetroleumAndNGProduction>false</OnshorePetroleumAndNGProduction>
      <OnshoreNGProcessing>true</OnshoreNGProcessing>
    </SelectSourceCategories>
  </ReportDetails>
  <OperationalWorkerReport>
    <ProgramID>12111130550</ProgramID>
    <ProgramIDDate>2015-01-15T10:15:52.127</ProgramIDDate>
    <ProgramIDCreator>LOAD 1 BcGhgId from BcGhg</ProgramIDCreator>
  </OperationalWorkerReport>
  <VerifyTombstone>
    <AlwaysSaveToSwimOnCommit>false</AlwaysSaveToSwimOnCommit>
    <Organisation>
      <Details>
        <BusinessLegalName>Spectra Energy Midstream Corporation</BusinessLegalName>
        <EnglishTradeName>Spectra Energy Midstream Corp</EnglishTradeName>
        <CRABusinessNumber>891167728</CRABusinessNumber>
        <DUNSNumber>201172186</DUNSNumber>
      </Details>
      <Address>
        <MailingAddress>
          <UnitNumber>22</UnitNumber>
          <StreetNumber>425</StreetNumber>
          <StreetName>1st Street West</StreetName>
          <StreetType>Street</StreetType>
          <StreetDirection>West</StreetDirection>
          <Municipality>Calgary</Municipality>
          <ProvTerrState>Alberta</ProvTerrState>
          <PostalCodeZipCode>T2P3L8</PostalCodeZipCode>
          <Country>Canada</Country>
        </MailingAddress>
      </Address>
    </Organisation>
    <Facility>
      <Details>
        <FacilityName>Highway Gas Plant</FacilityName>
        <Identifiers>
          <IdentifierList>
            <Identifier>
              <IdentifierType>NPRI</IdentifierType>
              <IdentifierValue>5124</IdentifierValue>
            </Identifier>
            <Identifier>
              <IdentifierType>BCGHGID</IdentifierType>
              <IdentifierValue>12111130550</IdentifierValue>
            </Identifier>
          </IdentifierList>
          <NAICSCodeList>
            <NAICSCode>
              <Code>211113</Code>
            </NAICSCode>
          </NAICSCodeList>
          <Permits>
            <Permit>
              <IssuingAgency>BC Ministry of Environment</IssuingAgency>
              <PermitNumber>PA-14929</PermitNumber>
            </Permit>
          </Permits>
        </Identifiers>
      </Details>
      <Address>
        <PhysicalAddress>
          <StreetName>Mile 121 Alaska Highway</StreetName>
          <Municipality>Peace River District</Municipality>
          <ProvTerrState>British Columbia</ProvTerrState>
          <PostalCodeZipCode>V1J4H7</PostalCodeZipCode>
          <Country>Canada</Country>
        </PhysicalAddress>
        <GeographicalAddress>
          <Latitude>56.22780</Latitude>
          <Longitude>-120.81900</Longitude>
        </GeographicalAddress>
      </Address>
    </Facility>
    <Contacts>
      <Contact>
        <Details>
          <ContactType>Operator Contact</ContactType>
          <GivenName>Mike Bell</GivenName>
          <TelephoneNumber>4036991758</TelephoneNumber>
          <FaxNumber>4036991590</FaxNumber>
          <EmailAddress>mrbell@spectraenergy.com</EmailAddress>
          <Position>Director, Environment and Risk Management</Position>
        </Details>
        <Address>
          <MailingAddress>
            <StreetNumber>125</StreetNumber>
            <StreetName>First Street</StreetName>
            <StreetType>Street</StreetType>
            <StreetDirection>Southwest</StreetDirection>
            <Municipality>Calgary</Municipality>
            <ProvTerrState>Alberta</ProvTerrState>
            <PostalCodeZipCode>T2P3L8</PostalCodeZipCode>
            <Country>Canada</Country>
          </MailingAddress>
        </Address>
      </Contact>
      <Contact>
        <Details>
          <ContactType>Operator Representative</ContactType>
          <GivenName>Al Ritchie</GivenName>
          <TelephoneNumber>2502623420</TelephoneNumber>
          <EmailAddress>aritchie@spectraenergy.com</EmailAddress>
          <Position>VP Operations</Position>
        </Details>
        <Address>
          <MailingAddress>
            <StreetNumber>53</StreetNumber>
            <StreetName>Alaska Highway</StreetName>
            <StreetType>Highway</StreetType>
            <Municipality>Fort St. John</Municipality>
            <ProvTerrState>British Columbia</ProvTerrState>
            <PostalCodeZipCode>V1J 4H7</PostalCodeZipCode>
            <Country>Canada</Country>
          </MailingAddress>
        </Address>
      </Contact>
      <Contact>
        <Details>
          <ContactType>Person Who Prepared Report</ContactType>
          <GivenName>Katherine Wreford</GivenName>
          <TelephoneNumber>6046915665</TelephoneNumber>
          <EmailAddress>kwreford@spectraenergy.com</EmailAddress>
          <Position>Environmental Specialist</Position>
        </Details>
        <Address>
          <MailingAddress>
            <POBoxNumber>11162</POBoxNumber>
            <UnitNumber>1100</UnitNumber>
            <StreetNumber>1055</StreetNumber>
            <StreetName>West Georgia Street</StreetName>
            <Municipality>Vancouver</Municipality>
            <ProvTerrState>British Columbia</ProvTerrState>
            <PostalCodeZipCode>V6E3R5</PostalCodeZipCode>
            <Country>Canada</Country>
          </MailingAddress>
        </Address>
      </Contact>
    </Contacts>
    <ParentOrganisations>
      <ParentOrganisation>
        <Details>
          <BusinessLegalName>Spectra Energy Facilities Holdings Partnership</BusinessLegalName>
          <PercentageOwned>99.98</PercentageOwned>
        </Details>
        <Address>
          <MailingAddress>
            <UnitNumber>1500</UnitNumber>
            <StreetNumber>500</StreetNumber>
            <StreetName>4th</StreetName>
            <StreetType>Avenue</StreetType>
            <Municipality>Calgary</Municipality>
            <ProvTerrState>Alberta</ProvTerrState>
            <PostalCodeZipCode>T2P2V6</PostalCodeZipCode>
            <Country>Canada</Country>
          </MailingAddress>
        </Address>
      </ParentOrganisation>
      <ParentOrganisation>
        <Details>
          <BusinessLegalName>Spectra Energy Facilities LP</BusinessLegalName>
          <PercentageOwned>100.00</PercentageOwned>
        </Details>
        <Address>
          <MailingAddress>
            <UnitNumber>1500</UnitNumber>
            <StreetNumber>500</StreetNumber>
            <StreetName>4th</StreetName>
            <StreetType>Avenue</StreetType>
            <Municipality>Calgary</Municipality>
            <ProvTerrState>Alberta</ProvTerrState>
            <PostalCodeZipCode>T2P2V6</PostalCodeZipCode>
            <Country>Canada</Country>
          </MailingAddress>
        </Address>
      </ParentOrganisation>
      <ParentOrganisation>
        <Details>
          <BusinessLegalName>Spectra Energy Midstream</BusinessLegalName>
          <PercentageOwned>100.00</PercentageOwned>
        </Details>
        <Address>
          <MailingAddress>
            <UnitNumber>1500</UnitNumber>
            <StreetNumber>500</StreetNumber>
            <StreetName>4th</StreetName>
            <StreetType>Avenue</StreetType>
            <Municipality>Calgary</Municipality>
            <ProvTerrState>Alberta</ProvTerrState>
            <PostalCodeZipCode>T2P2V6</PostalCodeZipCode>
            <Country>Canada</Country>
          </MailingAddress>
        </Address>
      </ParentOrganisation>
    </ParentOrganisations>
  </VerifyTombstone>
  <ActivityData xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <ActivityPages>
      <Process ProcessName="ElectricityGeneration">
        <SubProcess SubprocessName="Emissions from fuel combustion for electricity generation" InformationRequirement="Required">
          <Units UnitType="Non-Cogen Units">
            <Unit>
              <NonCOGenUnit>
                <NonCogenUnitName>Power Generator #1</NonCogenUnitName>
                <NameplateCapacity>0.95</NameplateCapacity>
                <NetPower>8209</NetPower>
              </NonCOGenUnit>
              <Fuels>
                <Fuel>
                  <FuelType>Natural Gas (Sm^3)</FuelType>
                  <FuelClassification>non-biomass</FuelClassification>
                  <FuelUnits>Sm^3</FuelUnits>
                  <AnnualFuelAmount>2026900</AnnualFuelAmount>
                  <AnnualWeightedAverageHighHeatingValue>0.0423</AnnualWeightedAverageHighHeatingValue>
                  <AnnualWeightedAverageCarbonContent>0.7525</AnnualWeightedAverageCarbonContent>
                  <Emissions>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>4423.39</Quantity>
                      <CalculatedQuantity>4423.39</CalculatedQuantity>
                      <GasType>CO2nonbio</GasType>
                      <Methodology>Methodology 3 (measured CC/Steam)</Methodology>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>0.32</Quantity>
                      <CalculatedQuantity>8.00</CalculatedQuantity>
                      <GasType>CH4</GasType>
                      <Methodology>Measured HHV/EFc</Methodology>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>0.11</Quantity>
                      <CalculatedQuantity>32.78</CalculatedQuantity>
                      <GasType>N2O</GasType>
                      <Methodology>Measured HHV/EFc</Methodology>
                    </Emission>
                  </Emissions>
                  <AlternativeMethodologyDescription/>
                </Fuel>
              </Fuels>
            </Unit>
            <Unit>
              <NonCOGenUnit>
                <NonCogenUnitName>Power Generator #2</NonCogenUnitName>
                <NameplateCapacity>0.95</NameplateCapacity>
                <NetPower>8145</NetPower>
              </NonCOGenUnit>
              <Fuels>
                <Fuel>
                  <FuelType>Natural Gas (Sm^3)</FuelType>
                  <FuelClassification>non-biomass</FuelClassification>
                  <FuelUnits>Sm^3</FuelUnits>
                  <AnnualFuelAmount>2011300</AnnualFuelAmount>
                  <AnnualWeightedAverageHighHeatingValue>0.0423</AnnualWeightedAverageHighHeatingValue>
                  <AnnualWeightedAverageCarbonContent>0.7525</AnnualWeightedAverageCarbonContent>
                  <Emissions>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>4389.64</Quantity>
                      <CalculatedQuantity>4389.64</CalculatedQuantity>
                      <GasType>CO2nonbio</GasType>
                      <Methodology>Methodology 3 (measured CC/Steam)</Methodology>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>0.31</Quantity>
                      <CalculatedQuantity>7.75</CalculatedQuantity>
                      <GasType>CH4</GasType>
                      <Methodology>Measured HHV/EFc</Methodology>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>0.11</Quantity>
                      <CalculatedQuantity>32.78</CalculatedQuantity>
                      <GasType>N2O</GasType>
                      <Methodology>Measured HHV/EFc</Methodology>
                    </Emission>
                  </Emissions>
                  <AlternativeMethodologyDescription/>
                </Fuel>
              </Fuels>
            </Unit>
          </Units>
        </SubProcess>
        <SubProcess SubprocessName="Emissions from acid gas scrubbers and acid gas reagents" InformationRequirement="Required">
          <Units>
            <Unit>
              <Fuels>
                <Fuel>
                  <Emissions>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_IndustrialProcessEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_IndustrialProcessEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>CO2nonbio</GasType>
                    </Emission>
                  </Emissions>
                  <AlternativeMethodologyDescription/>
                </Fuel>
              </Fuels>
            </Unit>
          </Units>
        </SubProcess>
        <SubProcess SubprocessName="Emissions from cooling units" InformationRequirement="Required">
          <Units>
            <Unit>
              <Fuels>
                <Fuel>
                  <Emissions>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_FugitiveEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_SpeciatedHFCs</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>HFC23_CHF3</GasType>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_FugitiveEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_SpeciatedHFCs</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>HFC32_CH2F2</GasType>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_FugitiveEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_SpeciatedHFCs</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>HFC41_CH3F</GasType>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_FugitiveEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_SpeciatedHFCs</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>HFC4310mee_C5H2F10</GasType>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_FugitiveEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_SpeciatedHFCs</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>HFC125_C2HF5</GasType>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_FugitiveEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_SpeciatedHFCs</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>HFC134_C2H2F4</GasType>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_FugitiveEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_SpeciatedHFCs</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>HFC134a_C2H2F4</GasType>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_FugitiveEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_SpeciatedHFCs</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>HFC143_C2H3F3</GasType>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_FugitiveEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_SpeciatedHFCs</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>HFC143a_C2H3F3</GasType>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_FugitiveEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_SpeciatedHFCs</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>HFC152a_C2H4F2</GasType>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_FugitiveEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_SpeciatedHFCs</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>HFC227ea_C3HF7</GasType>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_FugitiveEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_SpeciatedHFCs</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>HFC236fa_C3H2F6</GasType>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_FugitiveEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_SpeciatedHFCs</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>HFC245ca_C3H3F5</GasType>
                    </Emission>
                  </Emissions>
                  <AlternativeMethodologyDescription/>
                </Fuel>
              </Fuels>
            </Unit>
          </Units>
        </SubProcess>
        <SubProcess SubprocessName="Emissions from geothermal geyser steam or fluids" InformationRequirement="Required">
          <Units>
            <Unit>
              <Fuels>
                <Fuel>
                  <Emissions>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_FugitiveEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_FugitiveEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>CO2nonbio</GasType>
                    </Emission>
                  </Emissions>
                  <AlternativeMethodologyDescription/>
                </Fuel>
              </Fuels>
            </Unit>
          </Units>
        </SubProcess>
        <SubProcess SubprocessName="Emissions from installation, maintenance, operation and decommissioning of electrical equipment" InformationRequirement="Required">
          <Units>
            <Unit>
              <Fuels>
                <Fuel>
                  <Emissions>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_FugitiveEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_SF6Emissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>SF6</GasType>
                    </Emission>
                  </Emissions>
                  <AlternativeMethodologyDescription/>
                </Fuel>
              </Fuels>
            </Unit>
          </Units>
        </SubProcess>
      </Process>
      <Process ProcessName="GeneralStationaryCombustion2">
        <SubProcess SubprocessName="(a) general stationary combustion, useful energy" InformationRequirement="Required">
          <Units>
            <Unit>
              <UnitName>Highway - Stationary Combustion</UnitName>
              <UnitDesc>All stationary combustion sources.</UnitDesc>
              <Fuels>
                <Fuel>
                  <FuelType>Natural Gas (Sm^3)</FuelType>
                  <FuelClassification>non-biomass</FuelClassification>
                  <FuelUnits>Sm^3</FuelUnits>
                  <AnnualFuelAmount>15096493</AnnualFuelAmount>
                  <AnnualWeightedAverageHighHeatingValue>0.0423</AnnualWeightedAverageHighHeatingValue>
                  <AnnualWeightedAverageCarbonContent>0.7525</AnnualWeightedAverageCarbonContent>
                  <Emissions>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>32938.40</Quantity>
                      <CalculatedQuantity>32938.40</CalculatedQuantity>
                      <GasType>CO2nonbio</GasType>
                      <Methodology>Methodology 3 (measured CC/Steam)</Methodology>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>62.83</Quantity>
                      <CalculatedQuantity>1570.75</CalculatedQuantity>
                      <GasType>CH4</GasType>
                      <Methodology>Measured HHV/EFc</Methodology>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>1.21</Quantity>
                      <CalculatedQuantity>360.58</CalculatedQuantity>
                      <GasType>N2O</GasType>
                      <Methodology>Measured HHV/EFc</Methodology>
                    </Emission>
                  </Emissions>
                  <AlternativeMethodologyDescription/>
                </Fuel>
              </Fuels>
            </Unit>
          </Units>
        </SubProcess>
        <SubProcess SubprocessName="(b) general stationary combustion, no useful energy" InformationRequirement="Required">
          <Units/>
        </SubProcess>
        <SubProcess SubprocessName="Additional information required when other activities selected are Activities in Table 2 rows 2, 4, 5 , or 6" InformationRequirement="Additional">
          <Units>
            <Unit>
              <Fuels>
                <Fuel>
                  <Emissions EmissionsType="Line Heaters: Field gas or Process Vent Gas">
                    <Emission>
                      <Groups/>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>CO2nonbio</GasType>
                    </Emission>
                    <Emission>
                      <Groups/>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>CH4</GasType>
                    </Emission>
                    <Emission>
                      <Groups/>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>N2O</GasType>
                    </Emission>
                  </Emissions>
                  <Emissions EmissionsType="Line Heaters: Other Fuels">
                    <Emission>
                      <Groups/>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>CO2nonbio</GasType>
                    </Emission>
                    <Emission>
                      <Groups/>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>CH4</GasType>
                    </Emission>
                    <Emission>
                      <Groups/>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>N2O</GasType>
                    </Emission>
                  </Emissions>
                  <Emissions EmissionsType="Compressors: Field gas or Process Vent Gas">
                    <Emission>
                      <Groups/>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>CO2nonbio</GasType>
                    </Emission>
                    <Emission>
                      <Groups/>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>CH4</GasType>
                    </Emission>
                    <Emission>
                      <Groups/>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>N2O</GasType>
                    </Emission>
                  </Emissions>
                  <Emissions EmissionsType="Compressors: Other Fuels">
                    <Emission>
                      <Groups/>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>18693.86</Quantity>
                      <CalculatedQuantity>18693.86</CalculatedQuantity>
                      <GasType>CO2nonbio</GasType>
                    </Emission>
                    <Emission>
                      <Groups/>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>60.50</Quantity>
                      <CalculatedQuantity>1512.50</CalculatedQuantity>
                      <GasType>CH4</GasType>
                    </Emission>
                    <Emission>
                      <Groups/>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>0.96</Quantity>
                      <CalculatedQuantity>286.08</CalculatedQuantity>
                      <GasType>N2O</GasType>
                    </Emission>
                  </Emissions>
                  <Emissions EmissionsType="Generators: Field gas or Process Vent Gas">
                    <Emission>
                      <Groups/>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>CO2nonbio</GasType>
                    </Emission>
                    <Emission>
                      <Groups/>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>CH4</GasType>
                    </Emission>
                    <Emission>
                      <Groups/>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>N2O</GasType>
                    </Emission>
                  </Emissions>
                  <Emissions EmissionsType="Generators: Other Fuels">
                    <Emission>
                      <Groups/>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>8813.03</Quantity>
                      <CalculatedQuantity>8813.03</CalculatedQuantity>
                      <GasType>CO2nonbio</GasType>
                    </Emission>
                    <Emission>
                      <Groups/>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>0.63</Quantity>
                      <CalculatedQuantity>15.75</CalculatedQuantity>
                      <GasType>CH4</GasType>
                    </Emission>
                    <Emission>
                      <Groups/>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>0.22</Quantity>
                      <CalculatedQuantity>65.56</CalculatedQuantity>
                      <GasType>N2O</GasType>
                    </Emission>
                  </Emissions>
                  <Emissions EmissionsType="Mobile Drilling Rigs: Field gas or Process Vent Gas">
                    <Emission>
                      <Groups/>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>CO2nonbio</GasType>
                    </Emission>
                    <Emission>
                      <Groups/>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>CH4</GasType>
                    </Emission>
                    <Emission>
                      <Groups/>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>N2O</GasType>
                    </Emission>
                  </Emissions>
                  <Emissions EmissionsType="Mobile Drilling Rigs: Other Fuels">
                    <Emission>
                      <Groups/>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>CO2nonbio</GasType>
                    </Emission>
                    <Emission>
                      <Groups/>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>CH4</GasType>
                    </Emission>
                    <Emission>
                      <Groups/>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>N2O</GasType>
                    </Emission>
                  </Emissions>
                  <Emissions EmissionsType="Workover Equipment: Field gas or Process Vent Gas">
                    <Emission>
                      <Groups/>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>CO2nonbio</GasType>
                    </Emission>
                    <Emission>
                      <Groups/>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>CH4</GasType>
                    </Emission>
                    <Emission>
                      <Groups/>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>N2O</GasType>
                    </Emission>
                  </Emissions>
                  <Emissions EmissionsType="Workover Equipment: Other Fuels">
                    <Emission>
                      <Groups/>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>CO2nonbio</GasType>
                    </Emission>
                    <Emission>
                      <Groups/>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>CH4</GasType>
                    </Emission>
                    <Emission>
                      <Groups/>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>N2O</GasType>
                    </Emission>
                  </Emissions>
                </Fuel>
              </Fuels>
            </Unit>
          </Units>
        </SubProcess>
      </Process>
      <Process ProcessName="OGExtractionProcessing">
        <SubProcess SubprocessName="Flaring" InformationRequirement="Required">
          <Units>
            <Unit>
              <Fuels>
                <Fuel>
                  <Emissions EmissionsType="Onshore NG Processing: Flare Stacks">
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_FlaringEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_FlaringEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>5099.9498</Quantity>
                      <CalculatedQuantity>5099.9498</CalculatedQuantity>
                      <GasType>CO2nonbio</GasType>
                      <Methodology>WCI.363(k)</Methodology>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_FlaringEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_FlaringEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>26.9071</Quantity>
                      <CalculatedQuantity>672.6775</CalculatedQuantity>
                      <GasType>CH4</GasType>
                      <Methodology>WCI.363(k)</Methodology>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_FlaringEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_FlaringEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>0.0266</Quantity>
                      <CalculatedQuantity>7.9268</CalculatedQuantity>
                      <GasType>N2O</GasType>
                      <Methodology>WCI.363(k)</Methodology>
                    </Emission>
                  </Emissions>
                  <AlternativeMethodologyDescription/>
                </Fuel>
              </Fuels>
            </Unit>
          </Units>
        </SubProcess>
        <SubProcess SubprocessName="Venting" InformationRequirement="Required">
          <Units>
            <Unit>
              <Fuels>
                <Fuel>
                  <Emissions EmissionsType="Onshore NG Processing: acid gas removal venting or incineration process">
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_VentingEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_VentingEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>5490.74</Quantity>
                      <CalculatedQuantity>5490.74</CalculatedQuantity>
                      <GasType>CO2nonbio</GasType>
                      <Methodology>WCI.363(c)</Methodology>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_VentingEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_VentingEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>CH4</GasType>
                    </Emission>
                  </Emissions>
                  <Emissions EmissionsType="Onshore NG Processing: Dehydrator Vents">
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_VentingEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_VentingEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>CO2nonbio</GasType>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_VentingEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_VentingEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>CH4</GasType>
                    </Emission>
                  </Emissions>
                  <Emissions EmissionsType="Onshore NG Processing: Blowdown Vent Stacks">
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_VentingEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_VentingEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>CO2nonbio</GasType>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_VentingEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_VentingEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>CH4</GasType>
                    </Emission>
                  </Emissions>
                  <Emissions EmissionsType="Onshore NG Processing: Centrifugal Compressor Venting">
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_VentingEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_VentingEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>0.00</Quantity>
                      <CalculatedQuantity>0.00</CalculatedQuantity>
                      <GasType>CO2nonbio</GasType>
                      <Methodology>WCI.363(l)</Methodology>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_VentingEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_VentingEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>0.00</Quantity>
                      <CalculatedQuantity>0.00</CalculatedQuantity>
                      <GasType>CH4</GasType>
                      <Methodology>WCI.363(l)</Methodology>
                    </Emission>
                  </Emissions>
                  <Emissions EmissionsType="Onshore NG Processing: Reciprocating Compressor Venting">
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_VentingEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_VentingEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>0.10</Quantity>
                      <CalculatedQuantity>0.10</CalculatedQuantity>
                      <GasType>CO2nonbio</GasType>
                      <Methodology>WCI.363(m)</Methodology>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_VentingEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_VentingEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>4.08</Quantity>
                      <CalculatedQuantity>102.00</CalculatedQuantity>
                      <GasType>CH4</GasType>
                      <Methodology>WCI.363(m)</Methodology>
                    </Emission>
                  </Emissions>
                  <Emissions EmissionsType="Onshore NG Processing: Production/processing storage tanks">
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_VentingEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_VentingEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>CO2nonbio</GasType>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_VentingEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_VentingEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>CH4</GasType>
                    </Emission>
                  </Emissions>
                  <Emissions EmissionsType="Onshore NG Processing: other venting sources">
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_VentingEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_VentingEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>0.00</Quantity>
                      <CalculatedQuantity>0.00</CalculatedQuantity>
                      <GasType>CO2nonbio</GasType>
                      <Methodology>Other Methodology</Methodology>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_VentingEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_VentingEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>0.20</Quantity>
                      <CalculatedQuantity>5.00</CalculatedQuantity>
                      <GasType>CH4</GasType>
                      <Methodology>Other Methodology</Methodology>
                    </Emission>
                  </Emissions>
                  <AlternativeMethodologyDescription/>
                </Fuel>
              </Fuels>
            </Unit>
          </Units>
        </SubProcess>
        <SubProcess SubprocessName="Fugitive" InformationRequirement="Required">
          <Units>
            <Unit>
              <Fuels>
                <Fuel>
                  <Emissions EmissionsType="Onshore NG Processing: gathering pipeline equipment leaks">
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_FugitiveEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_FugitiveEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>CO2nonbio</GasType>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_FugitiveEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_FugitiveEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>CH4</GasType>
                    </Emission>
                  </Emissions>
                  <Emissions EmissionsType="Onshore NG Processing: Other Fugitive Sources">
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_FugitiveEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_FugitiveEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>CO2nonbio</GasType>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_FugitiveEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_FugitiveEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity xsi:nil="true"/>
                      <GasType>CH4</GasType>
                    </Emission>
                  </Emissions>
                  <AlternativeMethodologyDescription/>
                </Fuel>
              </Fuels>
            </Unit>
          </Units>
        </SubProcess>
        <SubProcess SubprocessName="Additional Reportable Information as per WCI.362(g)(21)" InformationRequirement="Additional" InfoType="WCI362g21">
          <Faciities/>
        </SubProcess>
        <SubProcess SubprocessName="Mandatory Additional Reportable Information as per WCI.362(g)(1)-(20)" InformationRequirement="MandatoryAdditional" InfoType="WCI362g120">
          <ThroughputBOE ThroughputType="OnshorePetroleumNaturalGasThroughput">5395160.05</ThroughputBOE>
          <FileDetails>
            <File>26</File>
            <UploadedFileName/>
            <UploadedDate/>
          </FileDetails>
        </SubProcess>
      </Process>
    </ActivityPages>
    <NonAttributableEmissions>
      <NonAttribEmissions/>
    </NonAttributableEmissions>
    <TotalCO2Captured>
      <TotalGroups TotalGroupType="TotalCO2CapturedEmissions">
        <Totals>
          <Emissions EmissionsGasType="CO2Captured">
            <TotalRow>
              <Groups>
                <EmissionGroupTypes>BC_CO2Captured</EmissionGroupTypes>
              </Groups>
              <NotApplicable>true</NotApplicable>
              <CalculatedQuantity xsi:nil="true"/>
              <GasType>CO2nonbio</GasType>
            </TotalRow>
          </Emissions>
        </Totals>
      </TotalGroups>
    </TotalCO2Captured>
    <TotalEmissions>
      <TotalGroups TotalGroupType="TotalGHGEmissionGas">
        <Totals>
          <Emissions EmissionsGasType="GHGEmissionGas">
            <TotalRow>
              <Quantity>0.00000000</Quantity>
              <CalculatedQuantity>0.00000000</CalculatedQuantity>
              <GasType>CO2bioC</GasType>
              <GasGroupType>None</GasGroupType>
            </TotalRow>
            <TotalRow>
              <Quantity>0.00000000</Quantity>
              <CalculatedQuantity>0.00000000</CalculatedQuantity>
              <GasType>CO2bionC</GasType>
              <GasGroupType>None</GasGroupType>
            </TotalRow>
            <TotalRow>
              <Quantity>52342.21980000</Quantity>
              <CalculatedQuantity>52342.21980000</CalculatedQuantity>
              <GasType>CO2nonbio</GasType>
              <GasGroupType>None</GasGroupType>
            </TotalRow>
            <TotalRow>
              <Quantity>94.64710000</Quantity>
              <CalculatedQuantity>2366.17750000</CalculatedQuantity>
              <GasType>CH4</GasType>
              <GasGroupType>None</GasGroupType>
            </TotalRow>
            <TotalRow>
              <Quantity>1.45660000</Quantity>
              <CalculatedQuantity>434.06680000</CalculatedQuantity>
              <GasType>N2O</GasType>
              <GasGroupType>None</GasGroupType>
            </TotalRow>
            <GrandTotal>
              <Total>55142.4641</Total>
            </GrandTotal>
          </Emissions>
        </Totals>
      </TotalGroups>
      <TotalGroups TotalGroupType="ReportingOnlyEmissions">
        <Totals>
          <Emissions EmissionsGasType="ReportingOnlyByGas">
            <TotalRow>
              <Quantity>0.00000000</Quantity>
              <CalculatedQuantity>0.00000000</CalculatedQuantity>
              <GasType>CO2bioC</GasType>
              <GasGroupType>None</GasGroupType>
            </TotalRow>
            <GrandTotal>
              <Total>0</Total>
            </GrandTotal>
          </Emissions>
        </Totals>
      </TotalGroups>
      <TotalGroups TotalGroupType="TotalEmissionsSchedB">
        <Totals>
          <Emissions EmissionsGasType="FlaringEmissions">
            <TotalRow>
              <Quantity>5099.94980000</Quantity>
              <CalculatedQuantity>5099.94980000</CalculatedQuantity>
              <GasType>CO2</GasType>
              <GasGroupType>None</GasGroupType>
            </TotalRow>
            <TotalRow>
              <Quantity>26.90710000</Quantity>
              <CalculatedQuantity>672.67750000</CalculatedQuantity>
              <GasType>CH4</GasType>
              <GasGroupType>None</GasGroupType>
            </TotalRow>
            <TotalRow>
              <Quantity>0.02660000</Quantity>
              <CalculatedQuantity>7.92680000</CalculatedQuantity>
              <GasType>N2O</GasType>
              <GasGroupType>None</GasGroupType>
            </TotalRow>
            <GrandTotal>
              <Total>5780.5541</Total>
            </GrandTotal>
          </Emissions>
          <Emissions EmissionsGasType="FugitiveEmissions">
            <TotalRow>
              <Quantity>0.00000000</Quantity>
              <CalculatedQuantity>0.00000000</CalculatedQuantity>
              <GasType>CO2</GasType>
              <GasGroupType>None</GasGroupType>
            </TotalRow>
            <TotalRow>
              <Quantity>0.00000000</Quantity>
              <CalculatedQuantity>0.00000000</CalculatedQuantity>
              <GasType>CH4</GasType>
              <GasGroupType>None</GasGroupType>
            </TotalRow>
            <GrandTotal>
              <Total>0</Total>
            </GrandTotal>
          </Emissions>
          <Emissions EmissionsGasType="StationaryFuelCombustionEmissions">
            <TotalRow>
              <Quantity>41751.43000000</Quantity>
              <CalculatedQuantity>41751.43000000</CalculatedQuantity>
              <GasType>CO2</GasType>
              <GasGroupType>None</GasGroupType>
            </TotalRow>
            <TotalRow>
              <Quantity>63.46000000</Quantity>
              <CalculatedQuantity>1586.50000000</CalculatedQuantity>
              <GasType>CH4</GasType>
              <GasGroupType>None</GasGroupType>
            </TotalRow>
            <TotalRow>
              <Quantity>1.43000000</Quantity>
              <CalculatedQuantity>426.14000000</CalculatedQuantity>
              <GasType>N2O</GasType>
              <GasGroupType>None</GasGroupType>
            </TotalRow>
            <GrandTotal>
              <Total>43764.07</Total>
            </GrandTotal>
          </Emissions>
          <Emissions EmissionsGasType="VentingEmissions">
            <TotalRow>
              <Quantity>5490.84000000</Quantity>
              <CalculatedQuantity>5490.84000000</CalculatedQuantity>
              <GasType>CO2</GasType>
              <GasGroupType>None</GasGroupType>
            </TotalRow>
            <TotalRow>
              <Quantity>4.28000000</Quantity>
              <CalculatedQuantity>107.00000000</CalculatedQuantity>
              <GasType>CH4</GasType>
              <GasGroupType>None</GasGroupType>
            </TotalRow>
            <GrandTotal>
              <Total>5597.84</Total>
            </GrandTotal>
          </Emissions>
          <Emissions EmissionsGasType="WasteEmissions">
            <TotalRow>
              <Quantity>0.00000000</Quantity>
              <CalculatedQuantity>0.00000000</CalculatedQuantity>
              <GasType>CO2</GasType>
              <GasGroupType>None</GasGroupType>
            </TotalRow>
            <TotalRow>
              <Quantity>0.00000000</Quantity>
              <CalculatedQuantity>0.00000000</CalculatedQuantity>
              <GasType>CH4</GasType>
              <GasGroupType>None</GasGroupType>
            </TotalRow>
            <TotalRow>
              <Quantity>0.00000000</Quantity>
              <CalculatedQuantity>0.00000000</CalculatedQuantity>
              <GasType>N2O</GasType>
              <GasGroupType>None</GasGroupType>
            </TotalRow>
            <GrandTotal>
              <Total>0</Total>
            </GrandTotal>
          </Emissions>
        </Totals>
      </TotalGroups>
    </TotalEmissions>
    <ReportComments>
      <Process ProcessName="Comments">
        <SubProcess SubprocessName="This section is optional" InformationRequirement="Optional">
          <ApplicableFacilities xsi:nil="true"/>
          <Comments>ACTIVITY: GENERAL STATIONARY COMBUSTION
Re. Additional information required when other activities selected are Activities in Table 2 rows 2, 4, 5, or 6 (not aggregated in totals): Refer to the uploaded Excel file &apos;WCI_362e_2014_SpectraEnergyMidstream_Highway&apos; for a complete set of the required data.</Comments>
          <FileDetails>
            <File>38</File>
            <UploadedFileName>WCI_362e_2014_SpectraEnergyMidstream_Highway.xlsx</UploadedFileName>
            <UploadedBy>Jennifer Eby</UploadedBy>
            <UploadedDate>19/03/2015 11:57:45 PM</UploadedDate>
          </FileDetails>
        </SubProcess>
      </Process>
    </ReportComments>
    <ConfidentialityRequest>
      <Process ProcessName="ConfidentialityRequest">
        <SubProcess SubprocessName="Confidentiality Request" InformationRequirement="Required">
          <IsRequestingConfidentiality>No</IsRequestingConfidentiality>
          <FileDetails>
            <File>39</File>
            <UploadedFileName/>
            <UploadedDate/>
          </FileDetails>
        </SubProcess>
      </Process>
    </ConfidentialityRequest>
  </ActivityData>
</ReportData>
$$);

refresh materialized view ggircs_swrs.report with data;
refresh materialized view ggircs_swrs.organisation with data;
refresh materialized view ggircs_swrs.facility with data;
refresh materialized view ggircs_swrs.activity with data;
refresh materialized view ggircs_swrs.unit with data;
refresh materialized view ggircs_swrs.identifier with data;
refresh materialized view ggircs_swrs.naics with data;
refresh materialized view ggircs_swrs.emission with data;
refresh materialized view ggircs_swrs.final_report with data;
refresh materialized view ggircs_swrs.fuel with data;
refresh materialized view ggircs_swrs.permit with data;
refresh materialized view ggircs_swrs.parent_organisation with data;
refresh materialized view ggircs_swrs.contact with data;
refresh materialized view ggircs_swrs.address with data;
refresh materialized view ggircs_swrs.descriptor with data;

select ggircs_swrs.export_mv_to_table();

-- Function export_mv_to_table exists
select has_function( 'ggircs_swrs', 'export_mv_to_table', 'Schema ggircs_swrs has function export_mv_to_table()' );

select tables_are('ggircs'::name, ARRAY[
    'report'::name,
    'organisation'::name,
    'facility'::name,
    'activity'::name,
    'unit'::name,
    'identifier'::name,
    'naics'::name,
    'emission'::name,
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
                             unit, identifier, naics. emission, final_report,
                             fuel, permit, parent_organisation, contact, address
                             descriptor $$
);

select isnt_empty('select * from ggircs.report', 'there is data in ggircs.report');
select isnt_empty('select * from ggircs.organisation', 'there is data in ggircs.organisation');
select isnt_empty('select * from ggircs.facility', 'there is data in ggircs.facility');
select isnt_empty('select * from ggircs.activity', 'there is data in ggircs.activity');
select isnt_empty('select * from ggircs.unit', 'there is data in ggircs.unit');
select isnt_empty('select * from ggircs.identifier', 'there is data in ggircs.identifier');
select isnt_empty('select * from ggircs.naics', 'there is data in ggircs.naics');
select isnt_empty('select * from ggircs.emission', 'there is data in ggircs.emission');
select isnt_empty('select * from ggircs.final_report', 'there is data in ggircs.final_report');
select isnt_empty('select * from ggircs.fuel', 'there is data in ggircs.fuel');
select isnt_empty('select * from ggircs.permit', 'there is data in ggircs.permit');
select isnt_empty('select * from ggircs.parent_organisation', 'there is data in ggircs.parent_organisation');
select isnt_empty('select * from ggircs.contact', 'there is data in ggircs.contact');
select isnt_empty('select * from ggircs.address', 'there is data in ggircs.address');
select isnt_empty('select * from ggircs.descriptor', 'there is data in ggircs.descriptor');

select isnt_empty('select * from ggircs_swrs.final_report', 'there is data in ggircs_swrs.final_report');

select set_eq('select * from ggircs_swrs.emission',

              $$select ghgr_import_id,
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
               from ggircs.emission$$,

              'data in ggircs_swrs.emission == ggircs.emission');

select * from finish();
rollback;
