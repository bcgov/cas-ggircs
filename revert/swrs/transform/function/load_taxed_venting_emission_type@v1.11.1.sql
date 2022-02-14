-- Revert ggircs:swrs/transform/function/load_taxed_venting_emission_type from pg

begin;

drop function swrs_transform.load_taxed_venting_emission_type;

commit;
