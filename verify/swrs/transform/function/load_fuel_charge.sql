-- Verify ggircs:swrs/transform/function/load_fuel_charge on pg

begin;

do $$
  begin

    if (select exists(select * from pg_proc where proname='swrs.load_fuel_charge')) then
      raise exception 'load_fuel_charge() exists when it should not';
    else
      perform true;
    end if;

  end; $$;

rollback;
