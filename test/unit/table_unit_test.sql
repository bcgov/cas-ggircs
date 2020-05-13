set client_encoding = 'utf-8';
set client_min_messages = warning;
create extension if not exists pgtap;
reset client_min_messages;

begin;
select * from no_plan();

insert into swrs_extract.eccc_xml_file (xml_file) values ($$
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

-- Run table export function without clearing the materialized views (for data equality tests below)
SET client_min_messages TO WARNING; -- load is a bit verbose
select swrs_transform.load(true, false);

-- Table swrs.unit exists
select has_table('swrs'::name, 'unit'::name);

-- Unit has pk
select has_pk('swrs', 'unit', 'ggircs_unit has primary key');

-- Unit has fk
select has_fk('swrs', 'unit', 'ggircs_unit has foreign key constraint(s)');

-- Unit has data
select isnt_empty('select * from swrs.unit', 'there is data in swrs.unit');

-- Unit -> Activity
select set_eq(
    $$
    select distinct(activity.eccc_xml_file_id) from swrs.unit
    join swrs.activity
    on unit.activity_id = activity.id
    $$,

    'select distinct(eccc_xml_file_id) from swrs.activity',

    'Foreign key unit_id in swrs.unit references swrs.activity.id'
);

-- Data in swrs_transform.unit === data in swrs.unit
select set_eq(
              $$
              select
                  eccc_xml_file_id,
                  activity_name,
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

                from swrs_transform.unit
              $$,

              $$
              select
                  eccc_xml_file_id,
                  activity_name,
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

                from swrs.unit
              $$,

              'data in swrs_transform.unit === swrs.unit');

select * from finish();
rollback;
