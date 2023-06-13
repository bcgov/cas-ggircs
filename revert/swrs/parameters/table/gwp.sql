-- Revert ggircs:swrs/parameters/table/gwp from pg

begin;

drop table ggircs_parameters.gwp;

commit;
