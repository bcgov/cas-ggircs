-- Verify ggircs:view_pro_rated_implied_emission_factor on pg

begin;

do $$
  begin

    if (select exists(select * from information_schema.views where table_schema='swrs' and table_name='pro_rated_implied_emission_factor')) then
      raise exception 'swrs.pro_rated_implied_emission_factor exists when it should not';
    else
      perform true;
    end if;

  end; $$;

rollback;

