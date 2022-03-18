begin;

grant usage on schema swrs_history to ggircs_user;
grant usage on schema swrs_extract to ggircs_user;
grant usage on schema ggircs_parameters to ggircs_user;
grant usage on schema swrs to ggircs_user;
grant select on all tables in schema swrs_history to ggircs_user;
grant select on all tables in schema swrs_extract to ggircs_user;
grant select, insert, update on all tables in schema ggircs_parameters to ggircs_user;
grant select, update on swrs.fuel to ggircs_user;
grant select on swrs.report to ggircs_user;

insert into swrs.report (id, swrs_report_id, reporting_period_duration) values (1, 1, 2020);

insert into swrs.fuel (id, report_id, fuel_type, fuel_mapping_id)
values (1, 1, 'Not Mapped', null);

commit;
