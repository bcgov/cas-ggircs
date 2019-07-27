import psycopg2
import util
from util import get_sheet_value, none_if_not_number

def extract(ciip_book, cursor, application_id, operator_id, facility_id):
    products = []
    if 'Production' in ciip_book.sheet_names():
        # In the SFO applications, associated emissions are in a separate sheet
        # Make a dict of the associated emissions
        associated_emissions_sheet = ciip_book.sheet_by_name('Emissions Allocation')
        associated_emissions = {}
        for row in range(4, 26, 2):
            product = get_sheet_value(associated_emissions_sheet, row, 2)
            emission = none_if_not_number(get_sheet_value(associated_emissions_sheet, row, 6))
            if emission is None: # in case a unit was entered in the 'tonnes CO2' column
                emission = none_if_not_number(get_sheet_value(associated_emissions_sheet, row, 4))
            if product is not None:
                associated_emissions[product.strip().lower()] = emission

        production_sheet = ciip_book.sheet_by_name('Production')
        for row in range(3, 42, 2):
            product = get_sheet_value(production_sheet, row, 4)
            if product is not None :
                emission = associated_emissions.get(product.strip().lower()) if len(associated_emissions) > 1 else list(associated_emissions.values())[0]
                products.append((
                    application_id,
                    operator_id,
                    facility_id,
                    product,
                    get_sheet_value(production_sheet, row, 6),
                    get_sheet_value(production_sheet, row, 8),
                    emission
                ))
    else:
        production_sheet = ciip_book.sheet_by_name('Module GHGs and production')
        for row in range(5, 18):
            q = none_if_not_number(get_sheet_value(production_sheet, row, 1))
            e = none_if_not_number(get_sheet_value(production_sheet, row, 3))
            if q is not None or e is not None:
                products.append((
                    application_id,
                    operator_id,
                    facility_id,
                    get_sheet_value(production_sheet, row, 0),
                    q,
                    get_sheet_value(production_sheet, row, 2),
                    e,
                ))

    psycopg2.extras.execute_values(
        cursor,
        '''insert into ciip_2018.production (application_id, operator_id, facility_id, product, quantity, units, associated_emissions)
        values %s''',
        products
    )
