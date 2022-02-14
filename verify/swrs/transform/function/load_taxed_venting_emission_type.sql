-- Verify ggircs:swrs/transform/function/load_taxed_venting_emission_type on pg

begin;

do $$
  begin

    if (select exists(select * from pg_proc where proname='swrs.load_taxed_venting_emission_type')) then
      raise exception 'load_taxed_venting_emission_type() exists when it should not';
    else
      perform true;
    end if;

  end; $$;

rollback;
