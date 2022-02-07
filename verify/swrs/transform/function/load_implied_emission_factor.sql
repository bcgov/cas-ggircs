-- Verify ggircs:swrs/transform/function/load_implied_emission_factor on pg

begin;

do $$
  begin

    if (select exists(select * from pg_proc where proname='swrs.load_implied_emission_factor')) then
      raise exception 'load_implied_emission_factor() exists when it should not';
    else
      perform true;
    end if;

  end; $$;

rollback;
