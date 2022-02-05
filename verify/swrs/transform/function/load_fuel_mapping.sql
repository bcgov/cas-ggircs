-- Verify ggircs:swrs/transform/function/load_fuel_mapping on pg

begin;

do $$
  begin

    if (select exists(select * from pg_proc where proname='swrs.load_fuel_mapping')) then
      raise exception 'load_fuel_mapping() exists when it should not';
    else
      perform true;
    end if;

  end; $$;

rollback;
