-- Verify ggircs:swrs/transform/function/load_naics_naics_category on pg

begin;

do $$
  begin

    if (select exists(select * from pg_proc where proname='swrs.load_naics_naics_category')) then
      raise exception 'load_naics_naics_category() exists when it should not';
    else
      perform true;
    end if;

  end; $$;

rollback;
