-- Deploy ggircs:swrs/parameters/table/emission_category to pg
-- requires: swrs/parameters/schema

begin;

create table ggircs_parameters.emission_category (
  id integer primary key generated always as identity,
  swrs_emission_category varchar(1000) unique,
  carbon_taxed boolean default true,
  category_definition varchar(100000)
);

comment on table ggircs_parameters.emission_category is 'Table of emission categories used in the CIIP program as defined in Schedule A / Schedule B of the Greenhouse Gas Industrial Reporting and Control Act (https://www.bclaws.gov.bc.ca/civix/document/id/complete/statreg/249_2015#ScheduleA)';
comment on column ggircs_parameters.emission_category.id is 'Unique ID for the emission_category';
comment on column ggircs_parameters.emission_category.swrs_emission_category is 'The emission category name as displayed in the swrs xml reports';
comment on column ggircs_parameters.emission_category.carbon_taxed is 'Boolean carbon_taxed column indicates whether or not a fuel reported in this category is taxed';
comment on column ggircs_parameters.emission_category.category_definition is 'Definition of the emission_category as defined in Schedule A / Schedule B of the Greenhouse Gas Industrial Reporting and Control Act (https://www.bclaws.gov.bc.ca/civix/document/id/complete/statreg/249_2015#ScheduleA)';

insert into ggircs_parameters.emission_category(
    swrs_emission_category,
    carbon_taxed,
    category_definition
  )
  values (
    'BC_ScheduleB_GeneralStationaryCombustionEmissions',
    true,
    $$ "general stationary combustion" means the combustion of fuel or waste in a boiler, combustion turbine, stationary engine, kiln, heater, incinerator, furnace, mobile crude oil compressor, or natural gas drilling rig while being used at a well site, or any other stationary device using combustion
    (a)to produce steam or heat or other forms of energy, or
    (b)to reduce volumes of waste,
    but does not include
      (c)the combustion of fuel to produce electricity,
      (d)refinery fuel gas combustion,
      (e)combustion by construction-related equipment temporarily used at a construction site,
      (f)combustion in generators used for emergency purposes only, or
      (g)emergency flaring
    $$
  ),
  (
    'BC_ScheduleB_IndustrialProcessEmissions',
    false,
    $$
      "industrial process emissions" means emissions from an industrial process that involves chemical or physical reactions other than combustion
    $$
  ),
  (
    'BC_ScheduleB_VentingEmissions',
    true,
    $$
      "venting emissions" means controlled or intended emissions that occur due to the design of equipment, or due to pressure beyond the capacity of manufacturing or processing equipment, and includes emissions from
        (a)releases of casing gas, a gas associated with a liquid, solution gas, treater, stabilizer or dehydrator off-gas or blanket gas,
        (b)releases from pneumatic devices that use natural gas as a driver,
        (c)releases from compressor start-ups, pipelines and other blowdowns, and
        (d)releases from metering and regulation station control loops,
        but does not include
          (e)emissions from combustion,
          (f)industrial process emissions, or
          (g)fugitive emissions
    $$
  ),
  (
    'BC_ScheduleB_FlaringEmissions',
    true,
    $$
      "flaring emissions" means emissions from the combustion of a gas or liquid for a purpose other than producing energy or reducing volumes of waste, including from combustion of waste petroleum, hazardous emission prevention systems, well testing, natural gas gathering systems, natural gas processing plants, crude oil production and pipeline operations
    $$
  ),
  (
    'BC_ScheduleB_FugitiveEmissions',
    false,
    $$
      "fugitive emissions" means the unintended or incidental emissions of greenhouse gases from the transmission, processing, storage, use or transportation of fossil fuels, greenhouse gases or other
    $$
  ),
  (
    'BC_ScheduleB_OnSiteTransportationEmissions',
    true,
    $$
      Fuel combustion by mobile equipment that is part of the facility
    $$
  ),
  (
    'BC_ScheduleB_WasteEmissions',
    true,
    $$
      General stationary combustion of fuel without production of useful energy
    $$
  ),
  (
    'BC_ScheduleB_WastewaterEmissions',
    false,
    $$
      (a) Industrial wastewater process using anaerobic digestion	Methane,
      (b) Oil-water separators
    $$
  );

commit;
