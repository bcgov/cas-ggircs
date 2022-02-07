-- Verify ggircs:swrs/transform/function/load_naics_category_type on pg

begin;

do $$
  begin

    if (select exists(select * from pg_proc where proname='swrs.load_naics_category_type')) then
      raise exception 'load_naics_category_type() exists when it should not';
    else
      perform true;
    end if;

  end; $$;

rollback;
