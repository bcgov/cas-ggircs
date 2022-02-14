-- Revert ggircs:swrs/parameters/table/taxed_venting_emission_type from pg

begin;

drop table ggircs_parameters.taxed_venting_emission_type;

commit;
