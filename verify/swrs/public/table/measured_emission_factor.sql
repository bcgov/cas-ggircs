-- Verify ggircs:table_measured_emission_factor on pg

begin;

do $$
  begin

    if (select exists(select * from pg_proc where proname='swrs.measured_emission_factor')) then
      raise exception 'swrs.measured_emission_factor() exists when it should not';
    else
      perform true;
    end if;

  end; $$;

rollback;
