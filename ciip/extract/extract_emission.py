import psycopg2
import util
from util import get_sheet_value, zero_if_not_number

ciip_swim_gas_types = {
    'Carbon dioxide from non-biomass (CO2)': 'CO2nonbio',
    'Carbon dioxide from biomass not listed in Schedule C of GGERR (CO2)': 'CO2bioNC',
    'Carbon dioxide from biomass listed in Schedule C of GGERR  (bioCO2) ': 'CO2bioC',
    'Methane (CH4)': 'CH4',
    'Nitrous oxide (N2O)': 'N2O',
    'Sulfur Hexafluoride (SF6)': 'SF6',
    'Perfluoromethane (CF4)': 'Perfluoromethane_CF4',
    'Perfluoroethane (C2F6)':'Perfluoroethane_C2F6',
}

ciip_swim_emissions_categories = {
    'Stationary Fuel Combustion Emissions ': 'BC_ScheduleB_GeneralStationaryCombustionEmissions',
    'Venting Emissions': 'BC_ScheduleB_VentingEmissions',
    'Flaring Emissions':'BC_ScheduleB_FlaringEmissions',
    'Fugitive/Other Emissions': 'BC_ScheduleB_FugitiveEmissions',
    'On-Site Transportation Emissions': 'BC_ScheduleB_OnSiteTransportationEmissions',
    'Waste and Wastewater Emissions': 'BC_ScheduleB_WasteAndWastewaterEmissions',
    'Industrial Process Emissions': 'BC_ScheduleB_IndustrialProcessEmissions',
}

def extract(ciip_book, cursor, application_id, operator_id, facility_id):
    emissions_sheet = ciip_book.sheet_by_name('Emissions')
    emissions = []

    current_emission_cat = None
    for row in range(2, emissions_sheet.nrows - 1, 2) : # ignore the last row
        if get_sheet_value(emissions_sheet, row, 5) is None: # it's the category header
            current_emission_cat = ciip_swim_emissions_categories[get_sheet_value(emissions_sheet, row, 1)]
        else :
            quantity = zero_if_not_number(get_sheet_value(emissions_sheet, row, 4))
            emissions.append(
                (
                    current_emission_cat,
                    ciip_swim_gas_types[get_sheet_value(emissions_sheet, row, 1)],
                    quantity,
                    zero_if_not_number(get_sheet_value(emissions_sheet, row, 8)),
                    application_id, operator_id, facility_id
                )
            )




    psycopg2.extras.execute_values(
        cursor,
        '''insert into ciip_2018.emission(
            emission_category, gas_type, quantity, calculated_quantity,
            application_id, operator_id, facility_id)
        values %s''',
        emissions
    )
