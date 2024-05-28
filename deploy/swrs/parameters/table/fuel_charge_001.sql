-- Deploy ggircs:swrs/parameters/table/fuel_charge_001 to pg
-- requires: swrs/parameters/table/fuel_charge

begin;


update ggircs_parameters.fuel_charge set end_date='2023-03-31' where start_date='2022-04-01' and carbon_tax_act_fuel_type_id=1;
insert into ggircs_parameters.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) values (0.1592, '2023-04-01', '9999-12-31', 1, null);

update ggircs_parameters.fuel_charge set end_date='2023-03-31' where start_date='2022-04-01' and carbon_tax_act_fuel_type_id=2;
insert into ggircs_parameters.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) values (0.1431, '2023-04-01', '9999-12-31', 2, null);

update ggircs_parameters.fuel_charge set end_date='2023-03-31' where start_date='2022-04-01' and carbon_tax_act_fuel_type_id=3;
insert into ggircs_parameters.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) values (0.1593, '2023-04-01', '9999-12-31', 3, null);

update ggircs_parameters.fuel_charge set end_date='2023-03-31' where start_date='2022-04-01' and carbon_tax_act_fuel_type_id=4;
insert into ggircs_parameters.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) values (0.1678, '2023-04-01', '9999-12-31', 4, null);

update ggircs_parameters.fuel_charge set end_date='2023-03-31' where start_date='2022-04-01' and carbon_tax_act_fuel_type_id=5;
insert into ggircs_parameters.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) values (0.1678, '2023-04-01', '9999-12-31', 5, null);

update ggircs_parameters.fuel_charge set end_date='2023-03-31' where start_date='2022-04-01' and carbon_tax_act_fuel_type_id=6;
insert into ggircs_parameters.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) values (0.1685, '2023-04-01', '9999-12-31', 6, null);

update ggircs_parameters.fuel_charge set end_date='2023-03-31' where start_date='2022-04-01' and carbon_tax_act_fuel_type_id=7;
insert into ggircs_parameters.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) values (0.0714, '2023-04-01', '9999-12-31', 7, null);

update ggircs_parameters.fuel_charge set end_date='2023-03-31' where start_date='2022-04-01' and carbon_tax_act_fuel_type_id=8;
insert into ggircs_parameters.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) values (0.1465, '2023-04-01', '9999-12-31', 8, 'Because of a methodology change that started in 2020, the Naphta fuel charge decreased, which meant that the rate change was not delayed with the Covid-19 emergency regulation. Therefore this fuel does not need for a separate rate for 2021-2022 vs 2022 onward');

update ggircs_parameters.fuel_charge set end_date='2023-03-31' where start_date='2022-04-01' and carbon_tax_act_fuel_type_id=9;
insert into ggircs_parameters.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) values (0.1157, '2023-04-01', '9999-12-31', 9, null);

update ggircs_parameters.fuel_charge set end_date='2023-03-31' where start_date='2022-04-01' and carbon_tax_act_fuel_type_id=10;
insert into ggircs_parameters.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) values (0.0455, '2023-04-01', '9999-12-31', 10, 'Because of a methodology change that started in 2020, the Coke Oven Gas fuel charge decreased, which meant that the rate change was not delayed with the Covid-19 emergency regulation. Therefore this fuel does not need for a separate rate for 2021-2022 vs 2022 onward');

update ggircs_parameters.fuel_charge set end_date='2023-03-31' where start_date='2022-04-01' and carbon_tax_act_fuel_type_id=11;
insert into ggircs_parameters.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) values (0.0662, '2023-04-01', '9999-12-31', 11, null);

update ggircs_parameters.fuel_charge set end_date='2023-03-31' where start_date='2022-04-01' and carbon_tax_act_fuel_type_id=12;
insert into ggircs_parameters.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) values (0.1006, '2023-04-01', '9999-12-31', 12, null);

update ggircs_parameters.fuel_charge set end_date='2023-03-31' where start_date='2022-04-01' and carbon_tax_act_fuel_type_id=13;
insert into ggircs_parameters.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) values (0.1239, '2023-04-01', '9999-12-31', 13, null);

update ggircs_parameters.fuel_charge set end_date='2023-03-31' where start_date='2022-04-01' and carbon_tax_act_fuel_type_id=14;
insert into ggircs_parameters.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) values (0.1396, '2023-04-01', '9999-12-31', 14, null);

update ggircs_parameters.fuel_charge set end_date='2023-03-31' where start_date='2022-04-01' and carbon_tax_act_fuel_type_id=15;
insert into ggircs_parameters.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) values (145.02, '2023-04-01', '9999-12-31', 15, null);

update ggircs_parameters.fuel_charge set end_date='2023-03-31' where start_date='2022-04-01' and carbon_tax_act_fuel_type_id=16;
insert into ggircs_parameters.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) values (115.21, '2023-04-01', '9999-12-31', 16, null);

update ggircs_parameters.fuel_charge set end_date='2023-03-31' where start_date='2022-04-01' and carbon_tax_act_fuel_type_id=17;
insert into ggircs_parameters.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) values (206.68, '2023-04-01', '9999-12-31', 17, null);

update ggircs_parameters.fuel_charge set end_date='2023-03-31' where start_date='2022-04-01' and carbon_tax_act_fuel_type_id=18;
insert into ggircs_parameters.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) values (0.2452, '2023-04-01', '9999-12-31', 18, null);

update ggircs_parameters.fuel_charge set end_date='2023-03-31' where start_date='2022-04-01' and carbon_tax_act_fuel_type_id=19;
insert into ggircs_parameters.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) values (0.1081, '2023-04-01', '9999-12-31', 19, null);

update ggircs_parameters.fuel_charge set end_date='2023-03-31' where start_date='2022-04-01' and carbon_tax_act_fuel_type_id=20;
insert into ggircs_parameters.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) values (0.1157, '2023-04-01', '9999-12-31', 20, null);

update ggircs_parameters.fuel_charge set end_date='2023-03-31' where start_date='2022-04-01' and carbon_tax_act_fuel_type_id=21;
insert into ggircs_parameters.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) values (66.43, '2023-04-01', '9999-12-31', 21, null);

update ggircs_parameters.fuel_charge set end_date='2023-03-31' where start_date='2022-04-01' and carbon_tax_act_fuel_type_id=22;
insert into ggircs_parameters.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) values (129.82, '2023-04-01', '9999-12-31', 22, 'Because of a methodology change that started in 2020, the Tires-Shredded fuel charge decreased, which meant that the rate change was not delayed with the Covid-19 emergency regulation. Therefore this fuel does not need for a separate rate for 2021-2022 vs 2022 onward');

update ggircs_parameters.fuel_charge set end_date='2023-03-31' where start_date='2022-04-01' and carbon_tax_act_fuel_type_id=23;
insert into ggircs_parameters.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) values (129.82, '2023-04-01', '9999-12-31', 23, null);

insert into ggircs_parameters.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) values (129.82, '2023-04-01', '9999-12-31', 24, null);

commit;
