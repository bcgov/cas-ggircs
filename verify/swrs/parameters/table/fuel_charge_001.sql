-- Verify ggircs:swrs/parameters/table/fuel_charge_001 on pg

begin;

do $$
  begin

    assert (select
        (select count(*) from ggircs_parameters.fuel_charge where start_date = '2023-04-01') = 24
      ),
      'We should have 24 records (one per CTA fuel type) with a start date of Apr 1, 2023';

    assert (select not exists
              (
                select carbon_tax_act_fuel_type_id, fuel_charge from ggircs_parameters.fuel_charge where start_date='2023-04-01'
                except values
                  ( 1, 0.1592),
                  ( 2, 0.1431),
                  ( 3, 0.2072),
                  ( 4, 0.1678),
                  ( 5, 0.1678),
                  ( 6, 0.1685),
                  ( 7, 0.0714),
                  ( 8, 0.1465),
                  ( 9, 0.1157),
                  (10, 0.0455),
                  (11, 0.0662),
                  (12, 0.1006),
                  (13, 0.1239),
                  (14, 0.1396),
                  (15, 145.02),
                  (16, 115.21),
                  (17, 206.68),
                  (18, 0.2452),
                  (19, 0.1081),
                  (20, 0.1157),
                  (21, 66.43),
                  (22, 129.82),
                  (23, 129.82),
                  (24, 129.82)
              )
           ),
          'The following tax rates should be implemented';
  end;
$$;

rollback;
