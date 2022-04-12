begin;

grant usage on schema swrs_history to ggircs_user;
grant usage on schema swrs_extract to ggircs_user;
grant usage on schema ggircs_parameters to ggircs_user;
grant usage on schema swrs to ggircs_user;
grant select on all tables in schema swrs_history to ggircs_user;
grant select on all tables in schema swrs_extract to ggircs_user;
grant select, insert, update on all tables in schema ggircs_parameters to ggircs_user;

insert into ggircs_parameters.carbon_tax_act_fuel_type (carbon_tax_fuel_type, cta_rate_units) values ('Butterflies', '$/unicorn');
insert into ggircs_parameters.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) values (0.0738, '1899-12-30', '2017-03-31', (select id from ggircs_parameters.carbon_tax_act_fuel_type where carbon_tax_fuel_type = 'Butterflies'), null);
insert into ggircs_parameters.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) values (0.0738, '2017-04-01', '2018-03-31', (select id from ggircs_parameters.carbon_tax_act_fuel_type where carbon_tax_fuel_type = 'Butterflies'), null);
insert into ggircs_parameters.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) values (0.0861, '2018-04-01', '2019-03-31', (select id from ggircs_parameters.carbon_tax_act_fuel_type where carbon_tax_fuel_type = 'Butterflies'), null);
insert into ggircs_parameters.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) values (0.0984, '2019-04-01', '2020-03-31', (select id from ggircs_parameters.carbon_tax_act_fuel_type where carbon_tax_fuel_type = 'Butterflies'), null);
insert into ggircs_parameters.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) values (0.0984, '2020-04-01', '2021-03-31', (select id from ggircs_parameters.carbon_tax_act_fuel_type where carbon_tax_fuel_type = 'Butterflies'), null);
insert into ggircs_parameters.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) values (0.1121, '2021-04-01', '2022-03-31', (select id from ggircs_parameters.carbon_tax_act_fuel_type where carbon_tax_fuel_type = 'Butterflies'), null);
insert into ggircs_parameters.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) values (0.1244, '2022-04-01', '2023-03-31', (select id from ggircs_parameters.carbon_tax_act_fuel_type where carbon_tax_fuel_type = 'Butterflies'), null);

commit;
