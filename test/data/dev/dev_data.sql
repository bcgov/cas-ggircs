
begin;

-- Start with clean tables
truncate swrs.report restart identity cascade;

/***********************************************
  swrs_organisation data setup
***********************************************/

create temporary table org_helper (
  swrs_org_id int,
  org_name varchar(1000),
  cra_num varchar(1000),
  duns varchar(1000)
) on commit drop;

insert into org_helper (swrs_org_id, org_name, cra_num, duns)
values
(1, 'SFO operator', 111111111, 111111111),
(2, 'LFO operator', 222222222, 222222222),
(3, 'Changes requested operator', 333333333, 333333333),
(4, 'Draft operator', 444444444, 11100444444),
(5, 'Not started operator', 555555555, 555555555),
(6, 'Submitted operator', 666666666, 666666666);

/***********************************************
  Create dev data
***********************************************/
drop sequence if exists address_sequence;
create sequence address_sequence start 1;

drop sequence if exists emission_sequence;
create sequence emission_sequence start 1;

create or replace function insert_swrs_report(
  _id integer,
  _swrs_facility_id integer,
  _swrs_org_id integer,
  _facility_type varchar(1000),
  _reporting_year integer)
  returns void as
$function$
begin
  insert into swrs.report(id, imported_at, swrs_report_id, swrs_facility_id, swrs_organisation_id, reporting_period_duration, version, submission_date)
  values(_id, now(), _id, _swrs_facility_id, _swrs_org_id, _reporting_year, 1, now());

  insert into swrs.organisation (id, report_id, swrs_organisation_id, business_legal_name, english_trade_name, cra_business_number, duns)
  values (
    _id, _id, _swrs_org_id,
    (select org_name from org_helper where swrs_org_id=_swrs_org_id),
    (select org_name from org_helper where swrs_org_id=_swrs_org_id),
    (select cra_num from org_helper where swrs_org_id=_swrs_org_id),
    (select duns from org_helper where swrs_org_id=_swrs_org_id)
  );

  insert into swrs.facility (id, report_id, organisation_id, swrs_facility_id, facility_name, facility_type, facility_bc_ghg_id)
  values (_id, _id, _id, _swrs_facility_id, concat('facility ', _swrs_facility_id), _facility_type, (_swrs_facility_id)::varchar(1000));

  insert into swrs.naics (id, report_id, facility_id, registration_data_facility_id, swrs_facility_id, naics_code)
  values (_id, _id, _id, _id, _id, 211110);

  insert into swrs.activity (id, report_id, facility_id)
  values
    (_id*2, _id, _id),
    (_id*2+1, _id, _id);

  insert into swrs.unit (id, activity_id)
  values
    (_id*2, _id*2),
    (_id*2+1, _id*2+1);

  insert into swrs.fuel (id, report_id, unit_id, fuel_mapping_id, fuel_type, fuel_description, fuel_units, annual_fuel_amount, emission_category)
  values (_id, _id, (_id)*2, 96, 'Natural Gas (Sm^3)', 'Natural Gas (Sm^3)', 'Sm^3', 1234, 'BC_ScheduleB_GeneralStationaryCombustionEmissions');

  insert into swrs.emission (id, activity_id, facility_id, fuel_id, naics_id, organisation_id, report_id, unit_id, quantity, calculated_quantity, emission_category, gas_type)
  values
    ((select nextval('emission_sequence')), _id*2, _id, _id, _id, _id, _id, _id*2, 10000, 10000, 'BC_ScheduleB_GeneralStationaryCombustionEmissions', 'CO2nonbio'),
    ((select nextval('emission_sequence')), _id*2+1, _id, _id, _id, _id, _id, _id*2+1, 444, 11100, 'BC_ScheduleB_FlaringEmissions', 'CH4');

  insert into swrs.address (id, report_id, facility_id, organisation_id, swrs_facility_id, swrs_organisation_id, path_context, type, mailing_address_street_number, mailing_address_street_name, mailing_address_street_type, mailing_address_municipality, mailing_address_prov_terr_state, mailing_address_postal_code_zip_code, mailing_address_country)
  values
    ((select nextval('address_sequence')), _id, _id, _id, _swrs_facility_id, _swrs_org_id, 'RegistrationData', 'Facility', '1234', 'Rainbow', 'road', 'Victoria',  'British Columbia', 'H0H0H0', 'Canada'),
    ((select nextval('address_sequence')), _id, _id, _id, _swrs_facility_id, _swrs_org_id, 'RegistrationData', 'Organisation', '1234', 'Rainbow', 'road', 'Victoria',  'British Columbia', 'H0H0H0', 'Canada'),
    ((select nextval('address_sequence')), _id, _id, _id, _swrs_facility_id, _swrs_org_id, 'RegistrationData', 'Contact', '1234', 'Rainbow', 'road', 'Victoria',  'British Columbia', 'H0H0H0', 'Canada');

  insert into swrs.contact (id, report_id, address_id, facility_id, organisation_id, path_context, contact_type, given_name, family_name, telephone_number, email_address, position)
  values (_id, _id, (select id from swrs.address where report_id = _id and type='Contact'), _id, _id, 'RegistrationData', 'Operator Representative', 'Mario', 'Super', '8889876543', 'supermario@bowser.ca', 'CEO');
end
$function$ language plpgsql volatile;


do $report$
  declare
    loop_modifier int := 0;
    loop_offset int;
  begin

    -- Create 600 reports per year (100 for each organisation type)
    for year in 2018..2025 loop
      loop_offset := loop_modifier*600;
      -- SFO
      for i in 1001..1002 loop
        perform insert_swrs_report(i+loop_offset, i, 1, 'SFO', year);
      end loop;

      -- LFO
      for i in 1003..1034 loop
        perform insert_swrs_report(i+loop_offset, i, 2, 'IF_a', year);
      end loop;

      for i in 1035..1067 loop
        perform insert_swrs_report(i+loop_offset, i, 2, 'IF_b', year);
      end loop;

      for i in 1068..1100 loop
        perform insert_swrs_report(i+loop_offset, i, 2, 'L_c', year);
      end loop;

      -- Changes Requested
      for i in 1101..1102 loop
        perform insert_swrs_report(i+loop_offset, i, 3, 'SFO', year);
      end loop;

      -- Draft
      for i in 1103..1104 loop
        perform insert_swrs_report(i+loop_offset, i, 4, 'SFO', year);
      end loop;

      -- Not Started
      for i in 1105..1106 loop
        perform insert_swrs_report(i+loop_offset, i, 5, 'SFO', year);
      end loop;

      -- Submitted
      for i in 1107..1108 loop
        perform insert_swrs_report(i+loop_offset, i, 6, 'SFO', year);
      end loop;
      loop_modifier = loop_modifier+1;
    end loop;
    raise notice 'Deploy Complete';
    raise notice '** Created % reports. **', (select count(*) from swrs.report);
    raise notice '** % reports for each year from 2018-2025. **', (select count(*)/8 from swrs.report);
    raise notice '** Operator types: {%} **', (select string_agg(quote_literal(org_name), ', ') as Orgs from org_helper);

  end
$report$;

delete from swrs.organisation_bc_registry_id;
insert into swrs.organisation_bc_registry_id (swrs_organisation_id, bc_registry_id) values
(1, 'BC0022383'), -- randomly selected bc registry ids available in the dev instance of Orgbook
(6, 'BC0033357');

commit;
