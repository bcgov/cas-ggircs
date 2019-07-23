-- Deploy ggircs:ciip/view_compare_ciip_swrs_emission to pg
-- requires: ciip/table_emission
-- requires: table_emission

begin;

create or replace view ciip_2018.compare_ciip_swrs_emission as
    with ciip_data as (select application.application_type, application.source_file_name, operator.business_legal_name, operator.swrs_operator_id,
       facility.facility_name, facility.swrs_facility_id,
       emission.emission_category, emission.gas_type, emission.quantity, emission.calculated_quantity
    from ciip_2018.emission
    join ciip_2018.facility on emission.facility_id = facility.id
    join ciip_2018.operator on emission.operator_id = operator.id
    join ciip_2018.application on facility.application_id = application.id),

    swrs_data as (
        select facility.swrs_facility_id, emission.emission_category, emission.gas_type, sum(emission.quantity) as quantity,
               sum(emission.calculated_quantity) as calculated_quantity
        from swrs.emission
        join swrs.facility on emission.facility_id = facility.id
        join swrs.report on emission.report_id = report.id
        and report.reporting_period_duration = '2018'
        where emission.emission_category != 'BC_ScheduleB_WasteEmissions' and emission.emission_category != 'BC_ScheduleB_WastewaterEmissions'
        group by facility.swrs_facility_id, emission.emission_category, emission.gas_type
        union
        select facility.swrs_facility_id, 'BC_ScheduleB_WasteAndWastewaterEmissions' as emission_category,
               emission.gas_type, sum(emission.quantity) as quantity,
               sum(emission.calculated_quantity) as calculated_quantity
        from swrs.emission
        join swrs.facility on emission.facility_id = facility.id
        join swrs.report on emission.report_id = report.id
        and report.reporting_period_duration = '2018'
        where emission.emission_category = 'BC_ScheduleB_WasteEmissions' or emission.emission_category = 'BC_ScheduleB_WastewaterEmissions'
        group by facility.swrs_facility_id, emission.gas_type
    )
    select ciip_data.application_type, ciip_data.source_file_name, ciip_data.business_legal_name, ciip_data.facility_name,
           ciip_data.swrs_operator_id, ciip_data.swrs_facility_id,
           ciip_data.emission_category, ciip_data.gas_type,
           case
           when
              swrs_data.quantity = 0 or
              (ciip_data.quantity IS NULL and swrs_data.quantity IS NOT NULL) or
              (ciip_data.quantity IS NOT NULL and swrs_data.quantity IS NULL)
           then 1
           else round(abs(ciip_data.quantity - swrs_data.quantity) / swrs_data.quantity, 2)
           end
           as ciip_swrs_discrepancy_ratio,
           ciip_data.quantity as ciip_quantity, swrs_data.quantity as swrs_quantity,
           ciip_data.calculated_quantity as ciip_calculated_quantity, swrs_data.calculated_quantity as swrs_calculated_quantity
    from ciip_data
    full outer join swrs_data
    on ciip_data.swrs_facility_id = swrs_data.swrs_facility_id
    and ciip_data.emission_category = swrs_data.emission_category
    and ciip_data.gas_type = swrs_data.gas_type
    where ciip_data.swrs_facility_id IS NOT NULL
    and (ciip_data.quantity > 0  or swrs_data.quantity > 0);


commit;


