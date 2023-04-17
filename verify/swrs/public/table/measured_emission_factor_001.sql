-- Verify ggircs:swrs/public/table/measured_emission_factor_001 on pg

begin;

do $$
  begin

    if (select exists(select * from information_schema.views
                        where table_schema='swrs'
                        and table_name in (
                          'measured_emission_factor'
                        )
                      )
        ) then
      raise exception 'measured_emission_factor table exists in the swrs schema where it should not';
    else
      perform true;
    end if;

  end; $$;

rollback;
