
begin;

-- Start with clean tables
truncate swrs.report restart identity cascade;

/***********************************************
  swrs_organisation data setup
***********************************************/

create temporary table org_helper (
  swrs_org_id int,
  org_name varchar(1000),
  cra_num int,
  duns int
) on commit drop;

insert into org_helper (swrs_org_id, org_name, cra_num, duns)
values
(1, 'Load testing operator', 111111111, 111111111),
(2, 'SFO operator', 222222222, 222222222),
(3, 'LFO operator', 333333333, 333333333),
(4, 'Changes requested operator', 444444444, 444444444),
(5, 'Draft operator', 555555555, 555555555),
(6, 'Not started operator', 666666666, 666666666),
(7, 'Submitted operator', 777777777, 777777777);

/***********************************************
  Create reports, organisations & facilities
***********************************************/

do $report$
  declare
    loop_modifier int := 0;
  begin

    -- Create 1600 reports per year (1000 for load testing & 100 for each other organisation type)
    for year in 2018..2025 loop
      -- Load Testing
      for i in 1..1000 loop
        raise notice 'SUM: %', i+loop_modifier*1600;
        insert into swrs.report(id, imported_at, swrs_report_id, swrs_facility_id, swrs_organisation_id, reporting_period_duration, version, submission_date)
        values(i+loop_modifier*1600, now(), i+loop_modifier*1600, i+loop_modifier*1600, 1, year, 1, now());

        insert into swrs.organisation (id, report_id, swrs_organisation_id, business_legal_name, english_trade_name, cra_business_number, duns)
        values (i+loop_modifier*1600, i+loop_modifier*1600, 1, (select org_name from org_helper where swrs_org_id=1), (select org_name from org_helper where swrs_org_id=1), (select cra_num from org_helper where swrs_org_id=1), (select duns from org_helper where swrs_org_id=1));

        insert into swrs.facility (id, report_id, organisation_id, swrs_facility_id, facility_name, facility_type)
        values (i+loop_modifier*1600, i+loop_modifier*1600, i+loop_modifier*1600, i+loop_modifier*1600, concat('facility ', i+loop_modifier*1600), 'SFO');
      end loop;

      -- SFO
      for i in 1001..1100 loop
        insert into swrs.report(id, imported_at, swrs_report_id, swrs_facility_id, swrs_organisation_id, reporting_period_duration, version, submission_date)
        values(i+loop_modifier*1600, now(), i+loop_modifier*1600, i+loop_modifier*1600, 2, year, 1, now());

        insert into swrs.organisation (id, report_id, swrs_organisation_id, business_legal_name, english_trade_name, cra_business_number, duns)
        values (i+loop_modifier*1600, i+loop_modifier*1600, 2, (select org_name from org_helper where swrs_org_id=2), (select org_name from org_helper where swrs_org_id=2), (select cra_num from org_helper where swrs_org_id=2), (select duns from org_helper where swrs_org_id=2));

        insert into swrs.facility (id, report_id, organisation_id, swrs_facility_id, facility_name, facility_type)
        values (i+loop_modifier*1600, i+loop_modifier*1600, i+loop_modifier*1600, i+loop_modifier*1600, concat('facility ', i+loop_modifier*1600), 'SFO');
      end loop;

      -- LFO
      for i in 1101..1133 loop
        insert into swrs.report(id, imported_at, swrs_report_id, swrs_facility_id, swrs_organisation_id, reporting_period_duration, version, submission_date)
        values(i+loop_modifier*1600, now(), i+loop_modifier*1600, i+loop_modifier*1600, 3, year, 1, now());

        insert into swrs.organisation (id, report_id, swrs_organisation_id, business_legal_name, english_trade_name, cra_business_number, duns)
        values (i+loop_modifier*1600, i+loop_modifier*1600, 3, (select org_name from org_helper where swrs_org_id=3), (select org_name from org_helper where swrs_org_id=3), (select cra_num from org_helper where swrs_org_id=3), (select duns from org_helper where swrs_org_id=3));

        insert into swrs.facility (id, report_id, organisation_id, swrs_facility_id, facility_name, facility_type)
        values (i+loop_modifier*1600, i+loop_modifier*1600, i+loop_modifier*1600, i+loop_modifier*1600, concat('facility ', i+loop_modifier*1600), 'IF_a');
      end loop;

      for i in 1134..1167 loop
        insert into swrs.report(id, imported_at, swrs_report_id, swrs_facility_id, swrs_organisation_id, reporting_period_duration, version, submission_date)
        values(i+loop_modifier*1600, now(), i+loop_modifier*1600, i+loop_modifier*1600, 3, year, 1, now());

        insert into swrs.organisation (id, report_id, swrs_organisation_id, business_legal_name, english_trade_name, cra_business_number, duns)
        values (i+loop_modifier*1600, i+loop_modifier*1600, 3, (select org_name from org_helper where swrs_org_id=3), (select org_name from org_helper where swrs_org_id=3), (select cra_num from org_helper where swrs_org_id=3), (select duns from org_helper where swrs_org_id=3));

        insert into swrs.facility (id, report_id, organisation_id, swrs_facility_id, facility_name, facility_type)
        values (i+loop_modifier*1600, i+loop_modifier*1600, i+loop_modifier*1600, i+loop_modifier*1600, concat('facility ', i+loop_modifier*1600), 'IF_b');
      end loop;

      for i in 1168..1200 loop
        insert into swrs.report(id, imported_at, swrs_report_id, swrs_facility_id, swrs_organisation_id, reporting_period_duration, version, submission_date)
        values(i+loop_modifier*1600, now(), i+loop_modifier*1600, i+loop_modifier*1600, 3, year, 1, now());

        insert into swrs.organisation (id, report_id, swrs_organisation_id, business_legal_name, english_trade_name, cra_business_number, duns)
        values (i+loop_modifier*1600, i+loop_modifier*1600, 3, (select org_name from org_helper where swrs_org_id=3), (select org_name from org_helper where swrs_org_id=3), (select cra_num from org_helper where swrs_org_id=3), (select duns from org_helper where swrs_org_id=3));

        insert into swrs.facility (id, report_id, organisation_id, swrs_facility_id, facility_name, facility_type)
        values (i+loop_modifier*1600, i+loop_modifier*1600, i+loop_modifier*1600, i+loop_modifier*1600, concat('facility ', i+loop_modifier*1600), 'L_c');
      end loop;

      -- Changes Requested
      for i in 1201..1300 loop
        insert into swrs.report(id, imported_at, swrs_report_id, swrs_facility_id, swrs_organisation_id, reporting_period_duration, version, submission_date)
        values(i+loop_modifier*1600, now(), i+loop_modifier*1600, i+loop_modifier*1600, 4, year, 1, now());

        insert into swrs.organisation (id, report_id, swrs_organisation_id, business_legal_name, english_trade_name, cra_business_number, duns)
        values (i+loop_modifier*1600, i+loop_modifier*1600, 4, (select org_name from org_helper where swrs_org_id=4), (select org_name from org_helper where swrs_org_id=4), (select cra_num from org_helper where swrs_org_id=4), (select duns from org_helper where swrs_org_id=4));

        insert into swrs.facility (id, report_id, organisation_id, swrs_facility_id, facility_name, facility_type)
        values (i+loop_modifier*1600, i+loop_modifier*1600, i+loop_modifier*1600, i+loop_modifier*1600, concat('facility ', i+loop_modifier*1600), 'SFO');
      end loop;

      -- Draft
      for i in 1301..1400 loop
        insert into swrs.report(id, imported_at, swrs_report_id, swrs_facility_id, swrs_organisation_id, reporting_period_duration, version, submission_date)
        values(i+loop_modifier*1600, now(), i+loop_modifier*1600, i+loop_modifier*1600, 5, year, 1, now());

        insert into swrs.organisation (id, report_id, swrs_organisation_id, business_legal_name, english_trade_name, cra_business_number, duns)
        values (i+loop_modifier*1600, i+loop_modifier*1600, 5, (select org_name from org_helper where swrs_org_id=5), (select org_name from org_helper where swrs_org_id=5), (select cra_num from org_helper where swrs_org_id=5), (select duns from org_helper where swrs_org_id=5));

        insert into swrs.facility (id, report_id, organisation_id, swrs_facility_id, facility_name, facility_type)
        values (i+loop_modifier*1600, i+loop_modifier*1600, i+loop_modifier*1600, i+loop_modifier*1600, concat('facility ', i+loop_modifier*1600), 'SFO');
      end loop;

      -- Not Started
      for i in 1401..1500 loop
        insert into swrs.report(id, imported_at, swrs_report_id, swrs_facility_id, swrs_organisation_id, reporting_period_duration, version, submission_date)
        values(i+loop_modifier*1600, now(), i+loop_modifier*1600, i+loop_modifier*1600, 6, year, 1, now());

        insert into swrs.organisation (id, report_id, swrs_organisation_id, business_legal_name, english_trade_name, cra_business_number, duns)
        values (i+loop_modifier*1600, i+loop_modifier*1600, 6, (select org_name from org_helper where swrs_org_id=6), (select org_name from org_helper where swrs_org_id=6), (select cra_num from org_helper where swrs_org_id=6), (select duns from org_helper where swrs_org_id=6));

        insert into swrs.facility (id, report_id, organisation_id, swrs_facility_id, facility_name, facility_type)
        values (i+loop_modifier*1600, i+loop_modifier*1600, i+loop_modifier*1600, i+loop_modifier*1600, concat('facility ', i+loop_modifier*1600), 'SFO');
      end loop;

      -- Submitted
      for i in 1501..1533 loop
        insert into swrs.report(id, imported_at, swrs_report_id, swrs_facility_id, swrs_organisation_id, reporting_period_duration, version, submission_date)
        values(i+loop_modifier*1600, now(), i+loop_modifier*1600, i+loop_modifier*1600, 7, (select date_part('year', now() - interval '3 years')), 1, now());

        insert into swrs.organisation (id, report_id, swrs_organisation_id, business_legal_name, english_trade_name, cra_business_number, duns)
        values (i+loop_modifier*1600, i+loop_modifier*1600, 7, (select org_name from org_helper where swrs_org_id=7), (select org_name from org_helper where swrs_org_id=7), (select cra_num from org_helper where swrs_org_id=7), (select duns from org_helper where swrs_org_id=7));

        insert into swrs.facility (id, report_id, organisation_id, swrs_facility_id, facility_name, facility_type)
        values (i+loop_modifier*1600, i+loop_modifier*1600, i+loop_modifier*1600, i+loop_modifier*1600, concat('facility ', i+loop_modifier*1600), 'SFO');
      end loop;

      for i in 1534..1567 loop
        insert into swrs.report(id, imported_at, swrs_report_id, swrs_facility_id, swrs_organisation_id, reporting_period_duration, version, submission_date)
        values(i+loop_modifier*1600, now(), i+loop_modifier*1600, i+loop_modifier*1600, 7, (select date_part('year', now() - interval '2 years')), 1, now());

        insert into swrs.organisation (id, report_id, swrs_organisation_id, business_legal_name, english_trade_name, cra_business_number, duns)
        values (i+loop_modifier*1600, i+loop_modifier*1600, 7, (select org_name from org_helper where swrs_org_id=7), (select org_name from org_helper where swrs_org_id=7), (select cra_num from org_helper where swrs_org_id=7), (select duns from org_helper where swrs_org_id=7));

        insert into swrs.facility (id, report_id, organisation_id, swrs_facility_id, facility_name, facility_type)
        values (i+loop_modifier*1600, i+loop_modifier*1600, i+loop_modifier*1600, i+loop_modifier*1600, concat('facility ', i+loop_modifier*1600), 'SFO');
      end loop;

      for i in 1568..1600 loop
        insert into swrs.report(id, imported_at, swrs_report_id, swrs_facility_id, swrs_organisation_id, reporting_period_duration, version, submission_date)
        values(i+loop_modifier*1600, now(), i+loop_modifier*1600, i+loop_modifier*1600, 7, year, 1, now());

        insert into swrs.organisation (id, report_id, swrs_organisation_id, business_legal_name, english_trade_name, cra_business_number, duns)
        values (i+loop_modifier*1600, i+loop_modifier*1600, 7, (select org_name from org_helper where swrs_org_id=7), (select org_name from org_helper where swrs_org_id=7), (select cra_num from org_helper where swrs_org_id=7), (select duns from org_helper where swrs_org_id=7));

        insert into swrs.facility (id, report_id, organisation_id, swrs_facility_id, facility_name, facility_type)
        values (i+loop_modifier*1600, i+loop_modifier*1600, i+loop_modifier*1600, i+loop_modifier*1600, concat('facility ', i+loop_modifier*1600), 'SFO');
      end loop;
      loop_modifier = loop_modifier+1;
    end loop;

  end
$report$;

select * from org_helper;

select count(*) from swrs.report where swrs_organisation_id = 1;
select count(*) from swrs.report where swrs_organisation_id = 2;
select count(*) from swrs.report where swrs_organisation_id = 3;
select count(*) from swrs.report where swrs_organisation_id = 4;
select count(*) from swrs.report where swrs_organisation_id = 5;
select count(*) from swrs.report where swrs_organisation_id = 6;
select count(*) from swrs.report where swrs_organisation_id = 7;

select count(*) from swrs.report where reporting_period_duration = 2018;
select count(*) from swrs.report where reporting_period_duration = 2019;
select count(*) from swrs.report where reporting_period_duration = 2020;
select count(*) from swrs.report where reporting_period_duration = 2021;
select count(*) from swrs.report where reporting_period_duration = 2022;
select count(*) from swrs.report where reporting_period_duration = 2023;

commit;
