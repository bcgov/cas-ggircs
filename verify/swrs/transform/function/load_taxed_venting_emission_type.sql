-- Verify ggircs:swrs/transform/function/load_taxed_venting_emission_type on pg

begin;

select pg_get_functiondef('swrs_transform.load_taxed_venting_emission_type()'::regprocedure);

rollback;
