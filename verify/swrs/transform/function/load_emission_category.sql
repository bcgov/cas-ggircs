-- Verify ggircs:swrs/transform/function/load_emission_category on pg

begin;

do $$
  begin

    if (select exists(select * from pg_proc where proname='swrs.load_emission_category')) then
      raise exception 'load_emission_category() exists when it should not';
    else
      perform true;
    end if;

  end; $$;

rollback;
