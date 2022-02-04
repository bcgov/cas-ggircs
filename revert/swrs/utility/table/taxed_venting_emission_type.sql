-- Revert ggircs:swrs/utility/table/taxed_venting_emission_type from pg

begin;

drop table swrs_utility.taxed_venting_emission_type;

commit;

