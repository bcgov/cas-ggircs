-- Revert ggircs:swrs/parameters/queries/unmapped_fuel from pg

begin;

drop function ggircs_parameters.unmapped_fuel();

commit;
