-- Verify ggircs:swrs/public/table/drop-non-etl-tables on pg

begin;

do $$
  begin

    if (select exists(select * from information_schema.views
                        where table_schema='swrs'
                        and table_name in (
                          'taxed_venting_emisison_type',
                          'naics_naics_category',
                          'naics_mapping',
                          'naics_category',
                          'naics_category_type',
                          'implied_emission_factor',
                          'fuel_mapping',
                          'fuel_carbon_tax_details',
                          'fuel_charge',
                          'emission_category',
                          'carbon_tax_rate_mapping',
                          'carbon_tax_act_fuel_type'
                        )
                      )
        ) then
      raise exception 'A non-ETL table exists in the swrs schema where it should not';
    else
      perform true;
    end if;

  end; $$;

rollback;
