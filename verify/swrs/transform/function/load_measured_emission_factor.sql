-- Verify ggircs:function_load_measured_emission_factor on pg

begin;

do $$
  begin

    if (select exists(select * from pg_proc where proname='swrs_transform.load_measured_emission_factor')) then
      raise exception 'swrs_transform.load_measured_emission_factor() exists when it should not';
    else
      perform true;
    end if;

  end; $$;

rollback;
