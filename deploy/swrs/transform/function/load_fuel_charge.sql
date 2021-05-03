-- Deploy ggircs:swrs/transform/function/load_fuel_charge to pg
-- requires: swrs/transform/schema
-- requires: swrs/public/table/fuel_charge

BEGIN;

create or replace function swrs_transform.load_fuel_charge()
  returns void as
$function$
    begin
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0738, '1899-12-30', '2017-03-31', 1, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0738, '2017-04-01', '2018-03-31', 1, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0861, '2018-04-01', '2019-03-31', 1, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0984, '2019-04-01', '2020-03-31', 1, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0984, '2020-04-01', '2021-03-31', 1, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.1121, '2021-04-01', '2022-03-31', 1, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.1244, '2022-04-01', '9999-12-31', 1, null);

        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0667, '1899-12-30', '2017-03-31', 2, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0667, '2017-04-01', '2018-03-31', 2, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0778, '2018-04-01', '2019-03-31', 2, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0889, '2019-04-01', '2020-03-31', 2, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0889, '2020-04-01', '2021-03-31', 2, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0996, '2021-04-01', '2022-03-31', 2, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.1105, '2022-04-01', '9999-12-31', 2, null);

        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0945, '1899-12-30', '2017-03-31', 3, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0945, '2017-04-01', '2018-03-31', 3, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.1103, '2018-04-01', '2019-03-31', 3, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.126, '2019-04-01', '2020-03-31', 3, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.126, '2020-04-01', '2021-03-31', 3, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.1436, '2021-04-01', '2022-03-31', 3, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.1593, '2022-04-01', '9999-12-31', 3, null);

        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0783, '1899-12-30', '2017-03-31', 4, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0783, '2017-04-01', '2018-03-31', 4, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0914, '2018-04-01', '2019-03-31', 4, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.1044, '2019-04-01', '2020-03-31', 4, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.1044, '2020-04-01', '2021-03-31', 4, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.1161, '2021-04-01', '2022-03-31', 4, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.1291, '2022-04-01', '9999-12-31', 4, null);

        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0783, '1899-12-30', '2017-03-31', 5, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0783, '2017-04-01', '2018-03-31', 5, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0914, '2018-04-01', '2019-03-31', 5, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.1044, '2019-04-01', '2020-03-31', 5, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.1044, '2020-04-01', '2021-03-31', 5, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.1161, '2021-04-01', '2022-03-31', 5, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.1291, '2022-04-01', '9999-12-31', 5, null);

        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0767, '1899-12-30', '2017-03-31', 6, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0767, '2017-04-01', '2018-03-31', 6, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0895, '2018-04-01', '2019-03-31', 6, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.1023, '2019-04-01', '2020-03-31', 6, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.1023, '2020-04-01', '2021-03-31', 6, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.1171, '2021-04-01', '2022-03-31', 6, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.1301, '2022-04-01', '9999-12-31', 6, null)
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0327, '1899-12-30', '2017-03-31', 7, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0327, '2017-04-01', '2018-03-31', 7, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0382, '2018-04-01', '2019-03-31', 7, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0436, '2019-04-01', '2020-03-31', 7, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0436, '2020-04-01', '2021-03-31', 7, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0495, '2021-04-01', '2022-03-31', 7, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0549, '2022-04-01', '9999-12-31', 7, null);

        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0765, '1899-12-30', '2017-03-31', 8, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0765, '2017-04-01', '2018-03-31', 8, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0893, '2018-04-01', '2019-03-31', 8, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.102, '2019-04-01', '2020-03-31', 8, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.1013, '2020-04-01', '2021-03-31', 8, 'Because of a methodology change that started in 2020, the Naphta fuel charge decreased, which meant that the rate change was not delayed with the Covid-19 emergency regulation. Therefore this fuel does not need for a separate rate for 2021-2022 vs 2022 onward');
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.1127, '2021-04-01', '2022-03-31', 8, 'Because of a methodology change that started in 2020, the Naphta fuel charge decreased, which meant that the rate change was not delayed with the Covid-19 emergency regulation. Therefore this fuel does not need for a separate rate for 2021-2022 vs 2022 onward');
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.1127, '2022-04-01', '9999-12-31', 8, 'Because of a methodology change that started in 2020, the Naphta fuel charge decreased, which meant that the rate change was not delayed with the Covid-19 emergency regulation. Therefore this fuel does not need for a separate rate for 2021-2022 vs 2022 onward');

        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0528, '1899-12-30', '2017-03-31', 9, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0528, '2017-04-01', '2018-03-31', 9, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0616, '2018-04-01', '2019-03-31', 9, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0704, '2019-04-01', '2020-03-31', 9, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0704, '2020-04-01', '2021-03-31', 9, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0801, '2021-04-01', '2022-03-31', 9, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.089, '2022-04-01', '9999-12-31', 9, null);

        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0483, '1899-12-30', '2017-03-31', 10, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0483, '2017-04-01', '2018-03-31', 10, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0564, '2018-04-01', '2019-03-31', 10, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0644, '2019-04-01', '2020-03-31', 10, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0315, '2020-04-01', '2021-03-31', 10, 'Because of a methodology change that started in 2020, the Coke Oven Gas fuel charge decreased, which meant that the rate change was not delayed with the Covid-19 emergency regulation. Therefore this fuel does not need for a separate rate for 2021-2022 vs 2022 onward');
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0350, '2021-04-01', '2022-03-31', 10, 'Because of a methodology change that started in 2020, the Coke Oven Gas fuel charge decreased, which meant that the rate change was not delayed with the Covid-19 emergency regulation. Therefore this fuel does not need for a separate rate for 2021-2022 vs 2022 onward');
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0350, '2022-04-01', '9999-12-31', 10, 'Because of a methodology change that started in 2020, the Coke Oven Gas fuel charge decreased, which meant that the rate change was not delayed with the Covid-19 emergency regulation. Therefore this fuel does not need for a separate rate for 2021-2022 vs 2022 onward');

        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0294, '1899-12-30', '2017-03-31', 11, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0294, '2017-04-01', '2018-03-31', 11, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0343, '2018-04-01', '2019-03-31', 11, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0392, '2019-04-01', '2020-03-31', 11, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0392, '2020-04-01', '2021-03-31', 11, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0459, '2021-04-01', '2022-03-31', 11, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0509, '2022-04-01', '9999-12-31', 11, null);

        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0462, '1899-12-30', '2017-03-31', 12, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0462, '2017-04-01', '2018-03-31', 12, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0539, '2018-04-01', '2019-03-31', 12, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0616, '2019-04-01', '2020-03-31', 12, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0616, '2020-04-01', '2021-03-31', 12, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0698, '2021-04-01', '2022-03-31', 12, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0774, '2022-04-01', '9999-12-31', 12, null);

        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.057, '1899-12-30', '2017-03-31', 13, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.057, '2017-04-01', '2018-03-31', 13, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0665, '2018-04-01', '2019-03-31', 13, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.076, '2019-04-01', '2020-03-31', 13, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.076, '2020-04-01', '2021-03-31', 13, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0882, '2021-04-01', '2022-03-31', 13, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0979, '2022-04-01', '9999-12-31', 13, null);

        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0528, '1899-12-30', '2017-03-31', 14, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0528, '2017-04-01', '2018-03-31', 14, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0616, '2018-04-01', '2019-03-31', 14, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0704, '2019-04-01', '2020-03-31', 14, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0704, '2020-04-01', '2021-03-31', 14, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.1215, '2021-04-01', '2022-03-31', 14, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.1350, '2022-04-01', '9999-12-31', 14, null);

        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (62.31, '1899-12-30', '2017-03-31', 15, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (62.31, '2017-04-01', '2018-03-31', 15, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (72.7, '2018-04-01', '2019-03-31', 15, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (83.08, '2019-04-01', '2020-03-31', 15, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (83.08, '2020-04-01', '2021-03-31', 15, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (101.34, '2021-04-01', '2022-03-31', 15, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (112.58, '2022-04-01', '9999-12-31', 15, null);

        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (53.31, '1899-12-30', '2017-03-31', 16, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (53.31, '2017-04-01', '2018-03-31', 16, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (62.2, '2018-04-01', '2019-03-31', 16, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (71.08, '2019-04-01', '2020-03-31', 16, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (71.08, '2020-04-01', '2021-03-31', 16, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (79.74, '2021-04-01', '2022-03-31', 16, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (88.62, '2022-04-01', '9999-12-31', 16, null);

        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (74.61, '1899-12-30', '2017-03-31', 17, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (74.61, '2017-04-01', '2018-03-31', 17, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (87.05, '2018-04-01', '2019-03-31', 17, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (99.48, '2019-04-01', '2020-03-31', 17, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (99.48, '2020-04-01', '2021-03-31', 17, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (143.10, '2021-04-01', '2022-03-31', 17, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (158.99, '2022-04-01', '9999-12-31', 17, null);

        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.1101, '1899-12-30', '2017-03-31', 18, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.1101, '2017-04-01', '2018-03-31', 18, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.1285, '2018-04-01', '2019-03-31', 18, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.1468, '2019-04-01', '2020-03-31', 18, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.1468, '2020-04-01', '2021-03-31', 18, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.1728, '2021-04-01', '2022-03-31', 18, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.1919, '2022-04-01', '9999-12-31', 18, null);

        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0495, '1899-12-30', '2017-03-31', 19, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0495, '2017-04-01', '2018-03-31', 19, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0578, '2018-04-01', '2019-03-31', 19, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.066, '2019-04-01', '2020-03-31', 19, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.066, '2020-04-01', '2021-03-31', 19, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0752, '2021-04-01', '2022-03-31', 19, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0832, '2022-04-01', '9999-12-31', 19, null);

        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0528, '1899-12-30', '2017-03-31', 20, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0528, '2017-04-01', '2018-03-31', 20, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0616, '2018-04-01', '2019-03-31', 20, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0704, '2019-04-01', '2020-03-31', 20, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0704, '2020-04-01', '2021-03-31', 20, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0801, '2021-04-01', '2022-03-31', 20, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (0.0890, '2022-04-01', '9999-12-31', 20, null);

        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (30.66, '1899-12-30', '2017-03-31', 21, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (30.66, '2017-04-01', '2018-03-31', 21, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (35.77, '2018-04-01', '2019-03-31', 21, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (40.88, '2019-04-01', '2020-03-31', 21, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (40.88, '2020-04-01', '2021-03-31', 21, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (45.99, '2021-04-01', '2022-03-31', 21, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (51.1, '2022-04-01', '9999-12-31', 21, null);

        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (71.73, '1899-12-30', '2017-03-31', 22, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (71.73, '2017-04-01', '2018-03-31', 22, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (83.69, '2018-04-01', '2019-03-31', 22, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (95.64, '2019-04-01', '2020-03-31', 22, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (89.87, '2020-04-01', '2021-03-31', 22, 'Because of a methodology change that started in 2020, the Tires-Shredded fuel charge decreased, which meant that the rate change was not delayed with the Covid-19 emergency regulation. Therefore this fuel does not need for a separate rate for 2021-2022 vs 2022 onward');
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (99.87, '2021-04-01', '2022-03-31', 22, 'Because of a methodology change that started in 2020, the Tires-Shredded fuel charge decreased, which meant that the rate change was not delayed with the Covid-19 emergency regulation. Therefore this fuel does not need for a separate rate for 2021-2022 vs 2022 onward');
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (99.87, '2022-04-01', '9999-12-31', 22, 'Because of a methodology change that started in 2020, the Tires-Shredded fuel charge decreased, which meant that the rate change was not delayed with the Covid-19 emergency regulation. Therefore this fuel does not need for a separate rate for 2021-2022 vs 2022 onward');

        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (62.4, '1899-12-30', '2017-03-31', 23, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (62.4, '2017-04-01', '2018-03-31', 23, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (72.8, '2018-04-01', '2019-03-31', 23, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (83.2, '2019-04-01', '2020-03-31', 23, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (83.2, '2020-04-01', '2021-03-31', 23, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (89.87, '2021-04-01', '2022-03-31', 23, null);
        INSERT INTO swrs_load.fuel_charge (fuel_charge, start_date, end_date, carbon_tax_act_fuel_type_id, metadata) VALUES (99.87, '2022-04-01', '9999-12-31', 23, null);

    end
$function$ language plpgsql volatile;
COMMIT;
