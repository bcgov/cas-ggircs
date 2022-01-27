-- Revert ggircs:swrs/utility/queries/unmapped_fuel from pg

begin;

drop function if exists swrs_utility.unmapped_fuel;

commit;
