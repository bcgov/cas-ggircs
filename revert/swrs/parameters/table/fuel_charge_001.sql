-- Revert ggircs:swrs/parameters/table/fuel_charge_001 from pg

begin;

delete from ggircs_parameters.fuel_charge where start_date='2023-04-01';
update ggircs_parameters.fuel_charge set end_date='9999-12-31' where start_date='2022-04-01';

commit;
