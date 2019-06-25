set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

/** This unit test tests the integrity of our left joins. Ensuring we have no row duplication as a result of a left join.
    The id's from the original state of the ggircs table before any left joins is tested against the final state of the
    ggircs table after all left joins have been done. **/

begin;
select plan(14);

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
    <FacilityType>EIO</FacilityType>
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
    <FacilityType>LF_a</FacilityType>
    <OrganisationId>0000</OrganisationId>
    <ReportingPeriodDuration>2020</ReportingPeriodDuration>
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
              <Code>321111</Code>
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
    <ReportID>1236</ReportID>
    <ReportType>R1</ReportType>
    <FacilityId>0002</FacilityId>
    <FacilityType>LFO</FacilityType>
    <OrganisationId>0000</OrganisationId>
    <ReportingPeriodDuration>2020</ReportingPeriodDuration>
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
              <Code>321111</Code>
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

-- Run table export function
select ggircs_swrs.export_mv_to_table();

-- Refresh all materialized views (run again so materialized views are populated for data equality tests below)
do
$do$
   declare mv_array text[] := $${report, organisation, facility,
                       activity, unit, identifier, naics, emission,
                       final_report, fuel, permit, parent_organisation, contact,
                       address, additional_data, measured_emission_factor}$$;
    begin
      for i in 1 .. array_upper(mv_array, 1)
          loop
            perform ggircs_swrs.refresh_materialized_views(quote_ident(mv_array[i]), 'with data');
          end loop;
    end
$do$;

/** ACTIVITY **/
select set_eq(
    'select id from ggircs.activity',

    $$
    select activity.id from ggircs_swrs.activity
    inner join ggircs_swrs.final_report as _final_report
    on activity.ghgr_import_id = _final_report.ghgr_import_id
    $$,

    'Ensure left joins are not causing additional rows to be returned in ggircs.activity'
);

/** ADDITIONAL DATA **/
select set_eq(
    'select id from ggircs.additional_data',

    $$
    select additional_data.id from ggircs_swrs.additional_data
    inner join ggircs_swrs.final_report as _final_report
    on additional_data.ghgr_import_id = _final_report.ghgr_import_id
    $$,

    'Ensure left joins are not causing additional rows to be returned in ggircs.additional_data'
);

/** ADDRESS **/
select set_eq(
    'select id from ggircs.address',

    $$
    select address.id from ggircs_swrs.address
    inner join ggircs_swrs.final_report as _final_report
    on address.ghgr_import_id = _final_report.ghgr_import_id
    $$,

    'Ensure left joins are not causing additional rows to be returned in ggircs.address'
);

/** CONTACT **/
select set_eq(
    'select id from ggircs.contact',

    $$
    select contact.id from ggircs_swrs.contact
    inner join ggircs_swrs.final_report as _final_report
    on contact.ghgr_import_id = _final_report.ghgr_import_id
    $$,

    'Ensure left joins are not causing additional rows to be returned in ggircs.contact'
);

/** EMISSION **/
select set_eq(
    'select id from ggircs.emission',

    $$
    select emission.id from ggircs_swrs.emission
    inner join ggircs_swrs.final_report as _final_report
    on emission.ghgr_import_id = _final_report.ghgr_import_id
    $$,

    'Ensure left joins are not causing additional rows to be returned in ggircs.emission'
);

/** FUEL **/
select set_eq(
    'select id from ggircs.fuel',

    $$
    select fuel.id from ggircs_swrs.fuel
    inner join ggircs_swrs.final_report as _final_report
    on fuel.ghgr_import_id = _final_report.ghgr_import_id
    $$,

    'Ensure left joins are not causing additional rows to be returned in ggircs.fuel'
);

/** IDENTIFIER **/
select set_eq(
    'select id from ggircs.identifier',

    $$
    select identifier.id from ggircs_swrs.identifier
    inner join ggircs_swrs.final_report as _final_report
    on identifier.ghgr_import_id = _final_report.ghgr_import_id
    $$,

    'Ensure left joins are not causing additional rows to be returned in ggircs.identifier'
);


/** SINGLE FACILITY **/
select set_eq(
    'select id from ggircs.facility',

    $$
    select facility.id from ggircs_swrs.facility
    inner join ggircs_swrs.final_report as _final_report
    on facility.ghgr_import_id = _final_report.ghgr_import_id
    $$,

    'Ensure left joins are not causing additional rows to be returned in ggircs.facility'
);

/** MEASURED EMISSION FACTOR **/
select set_eq(
    'select id from ggircs.measured_emission_factor',

    $$
    select measured_emission_factor.id from ggircs_swrs.measured_emission_factor
    inner join ggircs_swrs.final_report as _final_report
    on measured_emission_factor.ghgr_import_id = _final_report.ghgr_import_id
    $$,

    'Ensure left joins are not causing additional rows to be returned in ggircs.measured_emission_factor'
);

/** NAICS **/
select set_eq(
    'select id from ggircs.naics',

    $$
    select naics.id from ggircs_swrs.naics
    inner join ggircs_swrs.final_report as _final_report
    on naics.ghgr_import_id = _final_report.ghgr_import_id
    $$,

    'Ensure left joins are not causing additional rows to be returned in ggircs.naics'
);

/** ORGANISATION **/
select set_eq(
    'select id from ggircs.organisation',

    $$
    select organisation.id from ggircs_swrs.organisation
    inner join ggircs_swrs.final_report as _final_report
    on organisation.ghgr_import_id = _final_report.ghgr_import_id
    $$,

    'Ensure left joins are not causing additional rows to be returned in ggircs.organisation'
);

/** PARENT ORGANISATION **/
select set_eq(
    'select id from ggircs.parent_organisation',

    $$
    select parent_organisation.id from ggircs_swrs.parent_organisation
    inner join ggircs_swrs.final_report as _final_report
    on parent_organisation.ghgr_import_id = _final_report.ghgr_import_id
    $$,

    'Ensure left joins are not causing additional rows to be returned in ggircs.parent_organisation'
);

/** PERMIT **/
select set_eq(
    'select id from ggircs.permit',

    $$
    select permit.id from ggircs_swrs.permit
    inner join ggircs_swrs.final_report as _final_report
    on permit.ghgr_import_id = _final_report.ghgr_import_id
    $$,

    'Ensure left joins are not causing additional rows to be returned in ggircs.permit'
);

/** UNIT **/
select set_eq(
    'select id from ggircs.unit',

    $$
    select unit.id from ggircs_swrs.unit
    inner join ggircs_swrs.final_report as _final_report
    on unit.ghgr_import_id = _final_report.ghgr_import_id
    $$,

    'Ensure left joins are not causing additional rows to be returned in ggircs.unit'
);

select * from finish();
rollback;
