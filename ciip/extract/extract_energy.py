import psycopg2
import util
from util import get_sheet_value, none_if_not_number

def extract(ciip_book, cursor, application_id, operator_id, facility_id):
    elec_sheet = None
    row_range = None
    col_range = None
    if 'Electricity' in ciip_book.sheet_names():
        elec_sheet = ciip_book.sheet_by_name('Electricity')
        row_range = range(4, 7, 2)
        col_range = range(1, 10, 2)
    else:
        elec_sheet = ciip_book.sheet_by_name('Electricity and Heat')
        row_range = range(5, 7)
        col_range = range(1, 6)


    elec_and_heat = filter(
        lambda e: not all(f is None for f in e[4:]),
        [
            (
                application_id,
                operator_id,
                facility_id,
                'Electricity',
                none_if_not_number(get_sheet_value(elec_sheet, row_range[0], col_range[0])),
                none_if_not_number(get_sheet_value(elec_sheet, row_range[0], col_range[1])),
                none_if_not_number(get_sheet_value(elec_sheet, row_range[0], col_range[2])),
                none_if_not_number(get_sheet_value(elec_sheet, row_range[0], col_range[3])),
                none_if_not_number(get_sheet_value(elec_sheet, row_range[0], col_range[4])),
            ),
            (
                application_id,
                operator_id,
                facility_id,
                'Heat',
                none_if_not_number(get_sheet_value(elec_sheet, row_range[1], col_range[0])),
                none_if_not_number(get_sheet_value(elec_sheet, row_range[1], col_range[1])),
                none_if_not_number(get_sheet_value(elec_sheet, row_range[1], col_range[2])),
                none_if_not_number(get_sheet_value(elec_sheet, row_range[1], col_range[3])),
                none_if_not_number(get_sheet_value(elec_sheet, row_range[1], col_range[4])),
            ),
        ]
    )

    psycopg2.extras.execute_values(
        cursor,
        '''insert into ciip_2018.energy
         (application_id, operator_id, facility_id, energy_type, purchased_energy, generated_energy,
         consumed_energy, sold_energy, emissions_from_generated)
        values %s''',
        elec_and_heat
    )
