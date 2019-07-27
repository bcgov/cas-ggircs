import psycopg2
import util
from util import get_sheet_value, none_if_not_number, search_col_index

VOLUME_UNITS_COL_HEADER = 'Output/Throughput Volume Units\n(E3m3,m3, etc.)'
FIRST_COL_HEADER = 'Equipment Identifier'

HEADER_ROW = 5
FIRST_DATA_ROW = HEADER_ROW + 1



def extract(ciip_book, cursor, application_id, operator_id, facility_id):
    INSERT_EQUIPMENT = '''insert into ciip_2018.equipment
        (
            application_id, equipment_category, equipment_identifier, equipment_type,
            power_rating, load_factor, utilization, runtime_hours, design_efficiency,
            electrical_source, consumption_allocation_method,
            inlet_sales_compression_same_engine,
            inlet_suction_pressure,
            inlet_discharge_pressure,
            sales_suction_pressure,
            sales_discharge_pressure,
            volume_throughput,
            volume_units,
            volume_estimation_method,
            comments, operator_id, facility_id
        )
        values %s returning id'''

    cursor.execute(
        '''
        select id, product from ciip_2018.production
        where application_id = %s
        ''',
        (application_id,)
    )

    processes = cursor.fetchall()
    process_name_id = {}
    for p in processes:
        process_name_id[p[1]] = p[0]

    def get_equipment(sheet, row, col_range, eq_type):
        eq = [application_id, eq_type]
        numeric_cols = [4, 5, 6,7,8,12,13,14,15,16] # tuple index
        for col in col_range:
            if col is None:
                eq.append(None)
            else:
                val = get_sheet_value(sheet, row, col)
                if val is not None:
                    if isinstance(val, str) and val.strip().endswith('%') :
                        try:
                            val = float(val.replace('%', ''))
                        except:
                            print('Failed to convert ' + val + ' to float')
                    elif len(eq) in numeric_cols:
                        try:
                            val = float(val)
                        except:
                            print('Failed to convert ' + str(val) + ' to float')
                            val = None
                    elif len(eq) == 11: # inlet_sales_compression_same_engine, should be Y or N
                        if not isinstance(val, str) or val.strip().upper() not in ['Y', 'N']:
                            val = None
                eq.append(val)
        eq += [operator_id, facility_id]
        return eq

    def extract_equipment_sheet(sheet, col_range, eq_type, first_col, volume_unit_col):
        equipment_ids = []
        for row in range(6, sheet.nrows):
            eq = get_equipment(sheet, row, col_range, eq_type)
            if not isinstance(eq[4], int) and not isinstance(eq[4], float):
                continue
            psycopg2.extras.execute_values(cursor, INSERT_EQUIPMENT, [tuple(eq)])
            equipment_id = cursor.fetchall()[0]
            equipment_ids.append(equipment_id)

            allocations = []
            for col in range(first_col + 7, first_col + 20):
                allocation = none_if_not_number(get_sheet_value(sheet, row, col))
                if allocation is not None:
                    allocations.append((
                        application_id, equipment_id, get_sheet_value(sheet, 5, col),
                        process_name_id.get(get_sheet_value(sheet, 5, col)), # get the id of the process from the header of the column
                        none_if_not_number(get_sheet_value(sheet, row, col))
                    ))

            psycopg2.extras.execute_values(
                cursor,
                '''insert into ciip_2018.equipment_consumption
                (application_id, equipment_id, processing_unit_name, processing_unit_id, consumption_allocation)
                values %s''',
                allocations
            )
        return equipment_ids

    if 'Electrical Equipment' in ciip_book.sheet_names():
        sheet = ciip_book.sheet_by_name('Electrical Equipment')
        first_col = search_col_index(sheet, 5, FIRST_COL_HEADER)
        volume_unit_col = search_col_index(sheet, 5, VOLUME_UNITS_COL_HEADER)
        col_range = list(range(first_col + 0, first_col + 7)) + list(range(first_col + 21, first_col + 29)) + list(range(volume_unit_col, volume_unit_col + 3))
        extract_equipment_sheet(sheet, col_range, 'Electrical', first_col, volume_unit_col)

    if 'Gas Fired Equipment' in ciip_book.sheet_names():
        sheet = ciip_book.sheet_by_name('Gas Fired Equipment')
        first_col = search_col_index(sheet, 5, FIRST_COL_HEADER)
        volume_unit_col = search_col_index(sheet, 5, VOLUME_UNITS_COL_HEADER)
        col_range = list(range(first_col + 0, first_col + 7))
        col_range.append(None)
        col_range += list(range(first_col + 21, first_col + 28))
        col_range += [volume_unit_col, volume_unit_col + 1]
        col_range.append(volume_unit_col + 16)

        ids = extract_equipment_sheet(sheet, col_range, 'Gas Fired', first_col, volume_unit_col)
        ids.reverse()

        # extract emissions allocations
        for row in range(len(ids)):
            equipment_id = ids[row]
            allocations = []
            for col in range(volume_unit_col + 2, volume_unit_col + 15):
                allocation = none_if_not_number(get_sheet_value(sheet, HEADER_ROW + 1 + row, col))
                if allocation is not None:
                    allocations.append((
                        application_id, equipment_id, get_sheet_value(sheet, HEADER_ROW, col),
                        process_name_id.get(get_sheet_value(sheet, HEADER_ROW, col)), # get the id of the process from the header of the column
                        none_if_not_number(get_sheet_value(sheet, HEADER_ROW + 1 + row, col))
                    ))
            psycopg2.extras.execute_values(
                cursor,
                '''insert into ciip_2018.equipment_emission
                (application_id, equipment_id, processing_unit_name, processing_unit_id, emission_allocation)
                values %s''',
                allocations
            )

            # extract output streams
            output_streams = []
            for col in range(first_col + 28, volume_unit_col):
                output_stream_value = get_sheet_value(sheet, HEADER_ROW + 1 + row, col)
                if output_stream_value is not None:
                    output_streams.append((
                        application_id, equipment_id, get_sheet_value(sheet, HEADER_ROW, col), output_stream_value
                    ))

            psycopg2.extras.execute_values(
                cursor,
                '''insert into ciip_2018.equipment_output_stream
                (application_id, equipment_id, output_stream_label, output_stream_value)
                values %s''',
                output_streams
            )

