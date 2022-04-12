begin;

grant usage on schema swrs_history to ggircs_user;
grant usage on schema swrs_extract to ggircs_user;
grant usage on schema ggircs_parameters to ggircs_user;
grant usage on schema swrs to ggircs_user;
grant select on all tables in schema swrs_history to ggircs_user;
grant select on all tables in schema swrs_extract to ggircs_user;
grant select, insert, update on all tables in schema ggircs_parameters to ggircs_user;

delete from ggircs_parameters.fuel_charge where carbon_tax_act_fuel_type_id = (select id from ggircs_parameters.carbon_tax_act_fuel_type where carbon_tax_fuel_type = 'Butterflies');
delete from ggircs_parameters.carbon_tax_act_fuel_type where carbon_tax_fuel_type = 'Butterflies';

commit;
