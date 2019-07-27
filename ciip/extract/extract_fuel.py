import psycopg2
import util
from util import get_sheet_value

def extract(ciip_book, cursor, application_id, operator_id, facility_id):
    fuel_sheet = ciip_book.sheet_by_name('Fuel Usage') if 'Fuel Usage' in ciip_book.sheet_names() else ciip_book.sheet_by_name('Fuel Usage ')
    fuels = []
    use_alt_fuel_format = get_sheet_value(fuel_sheet, 3, 0) != 'Fuel Type '
    row_range = range(4, fuel_sheet.nrows) if not use_alt_fuel_format else range(5, fuel_sheet.nrows - 1, 2)

    for row in row_range:
        fuel_fields = [
            get_sheet_value(fuel_sheet, row, 0),
            None,
            get_sheet_value(fuel_sheet, row, 1),
            get_sheet_value(fuel_sheet, row, 2),
            get_sheet_value(fuel_sheet, row, 3),
            get_sheet_value(fuel_sheet, row, 4),
        ] if not use_alt_fuel_format else [
            get_sheet_value(fuel_sheet, row, 1),
            get_sheet_value(fuel_sheet, row, 3),
            get_sheet_value(fuel_sheet, row, 5),
            get_sheet_value(fuel_sheet, row, 7),
            get_sheet_value(fuel_sheet, row, 9),
            get_sheet_value(fuel_sheet, row, 11),
        ]
        if not all(f is None for f in fuel_fields[0:3]): # skip rows without any label
            try:
                if fuel_fields[3] is not None:
                    fuel_fields[3] = float(fuel_fields[3])
                if fuel_fields[5] is not None:
                    fuel_fields[5] = float(fuel_fields[5])
                fuel_fields += [application_id, operator_id, facility_id]
                fuel = tuple(fuel_fields)
                fuels.append(fuel)
            except:
                print('Could not parse Fuel row: ' + ','.join(str(e) for e in fuel_fields))

    psycopg2.extras.execute_values(
        cursor,
        '''insert into ciip_2018.fuel(
            fuel_type, fuel_type_alt, fuel_description, quantity, fuel_units, carbon_emissions,
            application_id, operator_id, facility_id)
        values %s''',
        fuels
    )
