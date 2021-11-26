-- Revert ggircs:swrs/public/table/taxed_venting_emission_type from pg

begin;

drop table swrs.taxed_venting_emission_type;

commit;
