-- Revert ggircs:ciip_table_energy from pg

begin;

drop table ciip.energy;

commit;

