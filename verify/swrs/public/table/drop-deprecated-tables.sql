-- Verify ggircs:swrs/public/table/drop-deprecated-tables on pg

begin;

do $$
  begin

    if (select exists(select * from information_schema.views
                        where table_schema='swrs'
                        and table_name in (
                          'naics_mapping',
                          'naics_category_type',
                          'implied_emission_factor',
                          'carbon_tax_rate_mapping'
                        )
                      )
        ) then
      raise exception 'A deprecated table exists in the swrs schema where it should not';
    else
      perform true;
    end if;

  end; $$;

rollback;
