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
            <IdentifierValue>123456</IdentifierValue>
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
              <IdentifierValue>12345</IdentifierValue>
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
      <Contact>
        <Details>
          <ContactType>Person Who Prepared Report</ContactType>
          <GivenName>Buddy</GivenName>
          <TelephoneNumber>12345</TelephoneNumber>
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
                <CogenUnitName>Recovery boiler</CogenUnitName>
                <NameplateCapacity>15.5</NameplateCapacity>
                <NetPower>80074</NetPower>
                <CycleType>Topping</CycleType>
                <ThermalOutputQuantity>2354364040</ThermalOutputQuantity>
                <SupplementalFiringPurpose>Electr. Generation</SupplementalFiringPurpose>
              </COGenUnit>
              <Fuels>
                <Fuel>
                  <FuelType>Residual Fuel Oil (#5 &amp; 6)</FuelType>
                  <FuelClassification>non-biomass</FuelClassification>
                  <FuelDescription/>
                  <FuelUnits>kilolitres</FuelUnits>
                  <AnnualFuelAmount>14427</AnnualFuelAmount>
                  <AnnualWeightedAverageCarbonContent>0.862</AnnualWeightedAverageCarbonContent>
                  <Emissions>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>45564.2360</Quantity>
                      <CalculatedQuantity>45564.2360</CalculatedQuantity>
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
                      <Quantity>1.7315</Quantity>
                      <CalculatedQuantity>36.3615</CalculatedQuantity>
                      <GasType>CH4</GasType>
                      <Methodology>Default HHV/EFc</Methodology>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>0.9234</Quantity>
                      <CalculatedQuantity>286.2540</CalculatedQuantity>
                      <GasType>N2O</GasType>
                      <Methodology>Default HHV/EFc</Methodology>
                    </Emission>
                  </Emissions>
                  <AlternativeMethodologyDescription/>
                </Fuel>
                <Fuel>
                  <FuelType>Propane</FuelType>
                  <FuelClassification>non-biomass</FuelClassification>
                  <FuelDescription/>
                  <FuelUnits>kilolitres</FuelUnits>
                  <AnnualFuelAmount>3.63</AnnualFuelAmount>
                  <Emissions>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>5.4872</Quantity>
                      <CalculatedQuantity>5.4872</CalculatedQuantity>
                      <GasType>CO2nonbio</GasType>
                      <Methodology>Methodology 1 (default HHV)</Methodology>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>0.0001</Quantity>
                      <CalculatedQuantity>0.0021</CalculatedQuantity>
                      <GasType>CH4</GasType>
                      <Methodology>Default HHV/EFc</Methodology>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>0.0004</Quantity>
                      <CalculatedQuantity>0.1240</CalculatedQuantity>
                      <GasType>N2O</GasType>
                      <Methodology>Default HHV/EFc</Methodology>
                    </Emission>
                  </Emissions>
                  <AlternativeMethodologyDescription/>
                </Fuel>
              </Fuels>
            </Unit>
            <Unit>
              <COGenUnit>
                <CogenUnitName>Boiler 14</CogenUnitName>
                <NameplateCapacity>1</NameplateCapacity>
                <NetPower>5018</NetPower>
                <CycleType>Topping</CycleType>
                <ThermalOutputQuantity>147550897</ThermalOutputQuantity>
                <SupplementalFiringPurpose>Electr. Generation</SupplementalFiringPurpose>
              </COGenUnit>
              <Fuels>
                <Fuel>
                  <FuelType>Residual Fuel Oil (#5 &amp; 6)</FuelType>
                  <FuelClassification>non-biomass</FuelClassification>
                  <FuelDescription/>
                  <FuelUnits>kilolitres</FuelUnits>
                  <AnnualFuelAmount>5042</AnnualFuelAmount>
                  <AnnualWeightedAverageCarbonContent>0.862</AnnualWeightedAverageCarbonContent>
                  <Emissions>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>15925.7236</Quantity>
                      <CalculatedQuantity>15925.7236</CalculatedQuantity>
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
                      <Quantity>0.6052</Quantity>
                      <CalculatedQuantity>12.7092</CalculatedQuantity>
                      <GasType>CH4</GasType>
                      <Methodology>Default HHV/EFc</Methodology>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>0.3227</Quantity>
                      <CalculatedQuantity>100.0370</CalculatedQuantity>
                      <GasType>N2O</GasType>
                      <Methodology>Default HHV/EFc</Methodology>
                    </Emission>
                  </Emissions>
                  <AlternativeMethodologyDescription/>
                </Fuel>
                <Fuel>
                  <FuelType>Diesel</FuelType>
                  <FuelClassification>non-biomass</FuelClassification>
                  <FuelDescription/>
                  <FuelUnits>kilolitres</FuelUnits>
                  <AnnualFuelAmount>40.62</AnnualFuelAmount>
                  <Emissions>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>108.1710</Quantity>
                      <CalculatedQuantity>108.1710</CalculatedQuantity>
                      <GasType>CO2nonbio</GasType>
                      <Methodology>Methodology 1 (default HHV)</Methodology>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>0.0054</Quantity>
                      <CalculatedQuantity>0.1134</CalculatedQuantity>
                      <GasType>CH4</GasType>
                      <Methodology>Default HHV/EFc</Methodology>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>0.0162</Quantity>
                      <CalculatedQuantity>5.0220</CalculatedQuantity>
                      <GasType>N2O</GasType>
                      <Methodology>Default HHV/EFc</Methodology>
                    </Emission>
                  </Emissions>
                  <AlternativeMethodologyDescription/>
                </Fuel>
              </Fuels>
            </Unit>
            <Unit>
              <COGenUnit>
                <CogenUnitName>Boiler 15</CogenUnitName>
                <NameplateCapacity>4</NameplateCapacity>
                <NetPower>20786</NetPower>
                <CycleType>Topping</CycleType>
                <ThermalOutputQuantity>611167103</ThermalOutputQuantity>
                <SupplementalFiringPurpose>Electr. Generation</SupplementalFiringPurpose>
              </COGenUnit>
              <Fuels>
                <Fuel>
                  <FuelType>Residual Fuel Oil (#5 &amp; 6)</FuelType>
                  <FuelClassification>non-biomass</FuelClassification>
                  <FuelDescription/>
                  <FuelUnits>kilolitres</FuelUnits>
                  <AnnualFuelAmount>20898</AnnualFuelAmount>
                  <AnnualWeightedAverageCarbonContent>0.862</AnnualWeightedAverageCarbonContent>
                  <Emissions>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>66004.3122</Quantity>
                      <CalculatedQuantity>66004.3122</CalculatedQuantity>
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
                      <Quantity>2.5082</Quantity>
                      <CalculatedQuantity>52.6722</CalculatedQuantity>
                      <GasType>CH4</GasType>
                      <Methodology>Default HHV/EFc</Methodology>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>1.3376</Quantity>
                      <CalculatedQuantity>414.6560</CalculatedQuantity>
                      <GasType>N2O</GasType>
                      <Methodology>Default HHV/EFc</Methodology>
                    </Emission>
                  </Emissions>
                  <AlternativeMethodologyDescription/>
                </Fuel>
                <Fuel>
                  <FuelType>Diesel</FuelType>
                  <FuelClassification>non-biomass</FuelClassification>
                  <FuelDescription/>
                  <FuelUnits>kilolitres</FuelUnits>
                  <AnnualFuelAmount>48.74</AnnualFuelAmount>
                  <Emissions>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>129.8052</Quantity>
                      <CalculatedQuantity>129.8052</CalculatedQuantity>
                      <GasType>CO2nonbio</GasType>
                      <Methodology>Methodology 1 (default HHV)</Methodology>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>0.0065</Quantity>
                      <CalculatedQuantity>0.1365</CalculatedQuantity>
                      <GasType>CH4</GasType>
                      <Methodology>Default HHV/EFc</Methodology>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>0.0195</Quantity>
                      <CalculatedQuantity>6.0450</CalculatedQuantity>
                      <GasType>N2O</GasType>
                      <Methodology>Default HHV/EFc</Methodology>
                    </Emission>
                  </Emissions>
                  <AlternativeMethodologyDescription/>
                </Fuel>
              </Fuels>
            </Unit>
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
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>53.8010</Quantity>
                      <CalculatedQuantity>1129.8210</CalculatedQuantity>
                      <GasType>CH4</GasType>
                      <Methodology>Measured Steam</Methodology>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>7.1735</Quantity>
                      <CalculatedQuantity>2223.7850</CalculatedQuantity>
                      <GasType>N2O</GasType>
                      <Methodology>Measured Steam</Methodology>
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
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>1.1332</Quantity>
                      <CalculatedQuantity>23.7972</CalculatedQuantity>
                      <GasType>CH4</GasType>
                      <Methodology>Default HHV/EFc</Methodology>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>0.6043</Quantity>
                      <CalculatedQuantity>187.3330</CalculatedQuantity>
                      <GasType>N2O</GasType>
                      <Methodology>Default HHV/EFc</Methodology>
                    </Emission>
                  </Emissions>
                  <AlternativeMethodologyDescription/>
                </Fuel>
                <Fuel>
                  <FuelType>Propane</FuelType>
                  <FuelClassification>non-biomass</FuelClassification>
                  <FuelDescription/>
                  <FuelUnits>kilolitres</FuelUnits>
                  <AnnualFuelAmount>1.37</AnnualFuelAmount>
                  <Emissions>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>2.0671</Quantity>
                      <CalculatedQuantity>2.0671</CalculatedQuantity>
                      <GasType>CO2nonbio</GasType>
                      <Methodology>Methodology 1 (default HHV)</Methodology>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>0.0000</Quantity>
                      <CalculatedQuantity>0.0000</CalculatedQuantity>
                      <GasType>CH4</GasType>
                      <Methodology>Default HHV/EFc</Methodology>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_GeneralStationaryCombustionEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>0.0001</Quantity>
                      <CalculatedQuantity>0.0310</CalculatedQuantity>
                      <GasType>N2O</GasType>
                      <Methodology>Default HHV/EFc</Methodology>
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
                      <CalculatedQuantity>0</CalculatedQuantity>
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
                      <CalculatedQuantity>0</CalculatedQuantity>
                      <GasType>HFC23_CHF3</GasType>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_FugitiveEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_SpeciatedHFCs</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity>0</CalculatedQuantity>
                      <GasType>HFC32_CH2F2</GasType>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_FugitiveEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_SpeciatedHFCs</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity>0</CalculatedQuantity>
                      <GasType>HFC41_CH3F</GasType>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_FugitiveEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_SpeciatedHFCs</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity>0</CalculatedQuantity>
                      <GasType>HFC4310mee_C5H2F10</GasType>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_FugitiveEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_SpeciatedHFCs</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity>0</CalculatedQuantity>
                      <GasType>HFC125_C2HF5</GasType>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_FugitiveEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_SpeciatedHFCs</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity>0</CalculatedQuantity>
                      <GasType>HFC134_C2H2F4</GasType>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_FugitiveEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_SpeciatedHFCs</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity>0</CalculatedQuantity>
                      <GasType>HFC134a_C2H2F4</GasType>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_FugitiveEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_SpeciatedHFCs</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity>0</CalculatedQuantity>
                      <GasType>HFC143_C2H3F3</GasType>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_FugitiveEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_SpeciatedHFCs</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity>0</CalculatedQuantity>
                      <GasType>HFC143a_C2H3F3</GasType>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_FugitiveEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_SpeciatedHFCs</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity>0</CalculatedQuantity>
                      <GasType>HFC152a_C2H4F2</GasType>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_FugitiveEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_SpeciatedHFCs</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity>0</CalculatedQuantity>
                      <GasType>HFC227ea_C3HF7</GasType>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_FugitiveEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_SpeciatedHFCs</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity>0</CalculatedQuantity>
                      <GasType>HFC236fa_C3H2F6</GasType>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_FugitiveEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_SpeciatedHFCs</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>true</NotApplicable>
                      <CalculatedQuantity>0</CalculatedQuantity>
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
                      <CalculatedQuantity>0</CalculatedQuantity>
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
                      <CalculatedQuantity>0</CalculatedQuantity>
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
      <Process ProcessName="PulpAndPaperProduction">
        <SubProcess SubprocessName="Emissions from pulping and chemical recovery" InformationRequirement="Required">
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
                      <CalculatedQuantity>0</CalculatedQuantity>
                      <GasType>CO2nonbio</GasType>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_IndustrialProcessEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_IndustrialProcessEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>196199.2992</Quantity>
                      <CalculatedQuantity>196199.2992</CalculatedQuantity>
                      <GasType>CO2bioC</GasType>
                      <Methodology>Solids-CC</Methodology>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_IndustrialProcessEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_IndustrialProcessEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>4.9761</Quantity>
                      <CalculatedQuantity>104.4981</CalculatedQuantity>
                      <GasType>CH4</GasType>
                      <Methodology>Solids-HHV</Methodology>
                    </Emission>
                    <Emission>
                      <Groups>
                        <EmissionGroupTypes>BC_FacilityTotal</EmissionGroupTypes>
                        <EmissionGroupTypes>BC_ScheduleB_IndustrialProcessEmissions</EmissionGroupTypes>
                        <EmissionGroupTypes>EC_IndustrialProcessEmissions</EmissionGroupTypes>
                      </Groups>
                      <NotApplicable>false</NotApplicable>
                      <Quantity>3.2602</Quantity>
                      <CalculatedQuantity>1010.6620</CalculatedQuantity>
                      <GasType>N2O</GasType>
                      <Methodology>Solids-HHV</Methodology>
                    </Emission>
                  </Emissions>
                  <AlternativeMethodologyDescription/>
                </Fuel>
              </Fuels>
            </Unit>
          </Units>
        </SubProcess>
        <SubProcess SubprocessName="Mandatory additional reportable information" InformationRequirement="MandatoryAdditional">
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

-- All tables created by the function exist in schema ggircs
select tables_are('ggircs'::name, ARRAY[
    'report'::name,
    'organisation'::name,
    'facility'::name,
    'activity'::name,
    'unit'::name,
    'identifier'::name,
    'naics'::name,
    'non_attributable_emission'::name,
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
                             unit, identifier, naics. non_attributable_emission, attributable_emission, final_report,
                             fuel, permit, parent_organisation, contact, address
                             descriptor $$
);

-- Test all tables have primary key
select has_pk('ggircs', 'report', 'ggircs_report has primary key');
select has_pk('ggircs', 'organisation', 'ggircs_organisation has primary key');
select has_pk('ggircs', 'facility', 'ggircs_facility has primary key');
select has_pk('ggircs', 'activity', 'ggircs_activity has primary key');
select has_pk('ggircs', 'unit', 'ggircs_unit has primary key');
select has_pk('ggircs', 'identifier', 'ggircs_identifier has primary key');
select has_pk('ggircs', 'naics', 'ggircs_naics has primary key');
select has_pk('ggircs', 'non_attributable_emission', 'ggircs_non_attributable_emission has primary key');
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
select has_fk('ggircs', 'non_attributable_emission', 'ggircs.non_attributable_emissions has foreign key constraint(s)');
-- select has_fk('ggircs', 'final_report', 'ggircs_final_report has foreign key constraint(s)');
select has_fk('ggircs', 'fuel', 'ggircs_fuel has foreign key constraint(s)');
select has_fk('ggircs', 'permit', 'ggircs_permit has foreign key constraint(s)');
-- select has_fk('ggircs', 'parent_organisation', 'ggircs_parent_organisation has foreign key constraint(s)');
select has_fk('ggircs', 'contact', 'ggircs_contact has foreign key constraint(s)');
select has_fk('ggircs', 'address', 'ggircs_address has foreign key constraint(s)');
select has_fk('ggircs', 'descriptor', 'ggircs_descriptor has foreign key constraint(s)');


-- Test validity of FK relations
-- NA Emission -> Fuel
select results_eq(
    $$select fuel.ghgr_import_id from ggircs.non_attributable_emission
      join ggircs.fuel
      on
        non_attributable_emission.fuel_id = fuel.id
        limit 1
    $$,

    'select ghgr_import_id from ggircs.fuel limit 1',

    'Foreign key fuel_id in ggircs.non_attributable_emission references ggircs.fuel.id'
);

-- Fuel -> Unit
select results_eq(
    $$select fuel.ghgr_import_id from ggircs.fuel
      join ggircs.unit
      on
        fuel.unit_id = unit.id
        and fuel.unit_id = 1 limit 1
    $$,

    'select ghgr_import_id from ggircs.unit where id=1 limit 1',

    'Foreign key unit_id in ggircs.fuel references ggircs.unit.id'
);

-- Unit -> Activity
select results_eq(
    $$select activity.ghgr_import_id from ggircs.unit
      join ggircs.activity
      on
        unit.activity_id = activity.id
        and unit.activity_id = 1 limit 1
    $$,

    'select ghgr_import_id from ggircs.activity where id=1 limit 1',

    'Foreign key unit_id in ggircs.unit references ggircs.activity.id'
);

-- Descriptor -> Activity
select results_eq(
    $$select activity.ghgr_import_id from ggircs.descriptor
      join ggircs.activity
      on
        descriptor.activity_id = activity.id
        and descriptor.activity_id = 16 limit 1
    $$,

    'select ghgr_import_id from ggircs.activity where id=16 limit 1',

    'Foreign key activity_id in ggircs.descriptor references ggircs.activity.id'
);

-- Activity -> Facility
select results_eq(
    $$select facility.ghgr_import_id from ggircs.activity
      join ggircs.facility
      on
        activity.facility_id = facility.id
        and activity.facility_id = 1 limit 1
    $$,

    'select ghgr_import_id from ggircs.facility where id=1 limit 1',

    'Foreign key facility_id in ggircs.activity references ggircs.facility.id'
);

-- Activity -> Report
select results_eq(
    $$select report.ghgr_import_id from ggircs.activity
      join ggircs.report
      on
        activity.report_id = report.id
        and activity.report_id = 1 limit 1
    $$,

    'select ghgr_import_id from ggircs.report where id=1 limit 1',

    'Foreign key report_id in ggircs.activity references ggircs.report.id'
);

-- Facility -> Report
select results_eq(
    $$select report.ghgr_import_id from ggircs.facility
      join ggircs.report
      on
        facility.report_id = report.id
        and facility.report_id = 1 limit 1
    $$,

    'select ghgr_import_id from ggircs.report where id=1 limit 1',

    'Foreign key report_id in ggircs.facility references ggircs.report.id'
);

-- Address -> Facility
select results_eq(
    $$select facility.ghgr_import_id from ggircs.address
      join ggircs.facility
      on
        address.facility_id = facility.id
        limit 1
    $$,
-- --
    'select ghgr_import_id from ggircs.facility where id=1 limit 1',
-- --
    'Foreign key facility_id in ggircs.address references ggircs.facility.id'
);

-- Contact -> Facility
select results_eq(
    $$select facility.ghgr_import_id from ggircs.contact
      join ggircs.facility
      on
        contact.facility_id = facility.id
        and contact.facility_id = 1 limit 1
    $$,

    'select ghgr_import_id from ggircs.facility where id=1 limit 1',

    'Foreign key facility_id in ggircs.contact references ggircs.facility.id'
);

-- Identifier -> Facility
select results_eq(
    $$select facility.ghgr_import_id from ggircs.identifier
      join ggircs.facility
      on
        identifier.facility_id = facility.id
        and identifier.facility_id = 1 limit 1
    $$,

    'select ghgr_import_id from ggircs.facility where id=1 limit 1',

    'Foreign key facility_id in ggircs.identifier references ggircs.facility.id'
);

-- NAICS -> Facility
select results_eq(
    $$select facility.ghgr_import_id from ggircs.naics
      join ggircs.facility
      on
        naics.facility_id = facility.id
        and naics.facility_id = 1 limit 1
    $$,

    'select ghgr_import_id from ggircs.facility where id=1 limit 1',

    'Foreign key facility_id in ggircs.naics references ggircs.facility.id'
);

-- Permit -> Facility
select results_eq(
    $$select facility.ghgr_import_id from ggircs.permit
      join ggircs.facility
      on
        permit.facility_id = facility.id
        and permit.facility_id = 1 limit 1
    $$,

    'select ghgr_import_id from ggircs.facility where id=1 limit 1',

    'Foreign key facility_id in ggircs.permit references ggircs.facility.id'
);

-- Address -> Organisation
select results_eq(
    $$select organisation.ghgr_import_id from ggircs.address
      join ggircs.organisation
      on
        address.organisation_id = organisation.id
        and address.organisation_id = 1 limit 1
    $$,

    'select ghgr_import_id from ggircs.organisation where id=1 limit 1',

    'Foreign key organisation_id in ggircs.address references ggircs.organisation.id'
);

-- Address -> Organisation
select results_eq(
    $$select parent_organisation.ghgr_import_id from ggircs.address
      join ggircs.parent_organisation
      on
        address.parent_organisation_id = parent_organisation.id
        and address.parent_organisation_id = 1 limit 1
    $$,

    'select ghgr_import_id from ggircs.parent_organisation where id=1 limit 1',

    'Foreign key parent_organisation_id in ggircs.address references ggircs.parent_organisation.id'
);





-- All tables in schema ggircs have data
select isnt_empty('select * from ggircs.report', 'there is data in ggircs.report');
select isnt_empty('select * from ggircs.organisation', 'there is data in ggircs.organisation');
select isnt_empty('select * from ggircs.facility', 'there is data in ggircs.facility');
select isnt_empty('select * from ggircs.activity', 'there is data in ggircs.activity');
select isnt_empty('select * from ggircs.unit', 'there is data in ggircs.unit');
select isnt_empty('select * from ggircs.identifier', 'there is data in ggircs.identifier');
select isnt_empty('select * from ggircs.naics', 'there is data in ggircs.naics');
select isnt_empty('select * from ggircs.non_attributable_emission', 'there is data in ggircs.non_attributable_emission');
select isnt_empty('select * from ggircs.final_report', 'there is data in ggircs.final_report');
select isnt_empty('select * from ggircs.fuel', 'there is data in ggircs.fuel');
select isnt_empty('select * from ggircs.permit', 'there is data in ggircs.permit');
select isnt_empty('select * from ggircs.parent_organisation', 'there is data in ggircs.parent_organisation');
select isnt_empty('select * from ggircs.contact', 'there is data in ggircs.contact');
select isnt_empty('select * from ggircs.address', 'there is data in ggircs.address');
select isnt_empty('select * from ggircs.descriptor', 'there is data in ggircs.descriptor');

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
                  where ghgr_import_id = 1$$,

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
                  from ggircs.report$$,

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
                  from ggircs_swrs.organisation$$,

                 $$select
                      ghgr_import_id,
                      swrs_organisation_id,
                      business_legal_name,
                      english_trade_name,
                      french_trade_name,
                      cra_business_number,
                      duns,
                      website
                  from ggircs.organisation$$,

    'data in ggircs_swrs.organisation === ggircs.organisation');

-- Data in ggircs_swrs.facility === data in ggircs.facility
select results_eq($$select
                      ghgr_import_id,
                      swrs_facility_id,
                      facility_name,
                      facility_type,
                      relationship_type,
                      portability_indicator,
                      status,
                      latitude,
                      longitude
                  from ggircs_swrs.facility$$,

                 $$select
                      ghgr_import_id,
                      swrs_facility_id,
                      facility_name,
                      facility_type,
                      relationship_type,
                      portability_indicator,
                      status,
                      latitude,
                      longitude
                  from ggircs.facility$$,

    'data in ggircs_swrs.facility === ggircs.facility');

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

-- Data in ggircs_swrs.emission (no CO2bioC gastype/ EIO facility) === data in ggircs.non_attributable_emission
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
                join ggircs_swrs.facility
                on emission.ghgr_import_id = facility.ghgr_import_id
                and emission.gas_type='CO2bioC'
                and facility.facility_type='EIO'
              order by
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
                from ggircs.non_attributable_emission
                order by
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

              'data in ggircs_swrs.non_attributable_emission === ggircs.non_attributable_emission');

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

select * from finish();
rollback;
