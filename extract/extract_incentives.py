import xlrd
import requests
import psycopg2
import psycopg2.extras
import hashlib
import datetime
import dateutil.parser
import os

def zero_if_not_number(a):
    try:
        return float(a)
    except:
        return 0

def none_if_not_number(a):
    try:
        return float(a)
    except:
        return None

def partial_dict_eq(a, b, fields):
    for f in fields:
        if a.get(f) != b.get(f):
            return False
    return True

## returns True if two contact dicts represent the same individual
def should_merge_contacts(a,b):
    return partial_dict_eq(a, b, ['first_name', 'last_name', 'position', 'email', 'phone'])

## using the provided function, returns an array where the equal dicts are merged
def reduce_dicts_array(dicts_array, should_merge_fn):
    if len(dicts_array) == 1:
        return dicts_array

    for i in range(len(dicts_array) - 1):
        if (should_merge_fn(dicts_array[i], dicts_array[i+1])):
            reduced_array = dicts_array[0:i] if i > 0 else []
            reduced_array.append({**dicts_array[i], **dicts_array[i+1]})
            reduced_array += dicts_array[i+2:len(dicts_array)]
            return reduce_dicts_array(reduced_array, should_merge_fn)

    return dicts_array


def get_sheet_value(sheet, row, col, default = None) :
    v = sheet.cell_value(row, col)
    return v if (v != '' and v != 'N/A') else default


def extract_equipment(ciip_book, cur, application_id):
    INSERT_EQUIPMENT = '''insert into ciip.equipment
        (
            application_id, equipment_category, equipment_identifier, equipment_type,
            power_rating, load_factor, utilization, runtime_hours, design_efficiency,
            electrical_source, consumption_allocation_method,
            inlet_sales_compression_same_engine,
            inlet_suction_pressure,
            inlet_discharge_pressure,
            sales_suction_pressure,
            sales_compression_pressure,
            volume_throughput,
            volume_units,
            volume_estimation_method,
            comments
        )
        values %s returning id'''

    cur.execute(
        '''
        select id, product from ciip.production
        where application_id = %s
        ''',
        (application_id,)
    )

    processes = cur.fetchall()
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
        return eq

    def get_first_col(sheet):
        for c in range(0, sheet.ncols):
            if get_sheet_value(sheet, 5, c) == 'Equipment Identifier':
                return c
        return None

    def get_volume_units_column(sheet):
        for c in range(0, sheet.ncols):
            if get_sheet_value(sheet, 5, c) == 'Output/Throughput Volume Units\n(E3m3,m3, etc.)':
                return c
        return None

    def extract_equipment_sheet(sheet, col_range, eq_type, first_col, volume_unit_col):
        equipment_ids = []
        for row in range(6, sheet.nrows):
            eq = get_equipment(sheet, row, col_range, eq_type)
            if not isinstance(eq[4], int) and not isinstance(eq[4], float):
                continue
            psycopg2.extras.execute_values(cur, INSERT_EQUIPMENT, [tuple(eq)])
            equipment_id = cur.fetchall()[0]
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
                cur,
                '''insert into ciip.equipment_consumption
                (application_id, equipment_id, processing_unit_name, processing_unit_id, consumption_allocation)
                values %s''',
                allocations
            )

            #TODO: extract equipment emission and consumption
            # Find associated


        return equipment_ids

    if 'Gas Fired Equipment' in ciip_book.sheet_names():
        sheet = ciip_book.sheet_by_name('Gas Fired Equipment')
        first_col = get_first_col(sheet)
        volume_unit_col = get_volume_units_column(sheet)
        col_range = list(range(first_col + 0, first_col + 7))
        col_range.append(None)
        col_range += list(range(first_col + 21, first_col + 28))
        col_range += [volume_unit_col, volume_unit_col + 1]
        col_range.append(volume_unit_col + 16)
        ids = extract_equipment_sheet(sheet, col_range, 'Gas Fired', first_col, volume_unit_col)
        ids.reverse()
        # extract emissions allocations
        for row in range(6, 6 + len(ids)):
            equipment_id = ids.pop()
            allocations = []
            for col in range(volume_unit_col + 2, volume_unit_col + 15):
                allocation = none_if_not_number(get_sheet_value(sheet, row, col))
                if allocation is not None:
                    allocations.append((
                        application_id, equipment_id, get_sheet_value(sheet, 5, col),
                        process_name_id.get(get_sheet_value(sheet, 5, col)), # get the id of the process from the header of the column
                        none_if_not_number(get_sheet_value(sheet, row, col))
                    ))

            psycopg2.extras.execute_values(
                cur,
                '''insert into ciip.equipment_emission
                (application_id, equipment_id, processing_unit_name, processing_unit_id, emission_allocation)
                values %s''',
                allocations
            )




    if 'Electrical Equipment' in ciip_book.sheet_names():
        sheet = ciip_book.sheet_by_name('Electrical Equipment')
        first_col = get_first_col(sheet)
        volume_unit_col = get_volume_units_column(sheet)
        col_range = list(range(first_col + 0, first_col + 7)) + list(range(first_col + 21, first_col + 29)) + list(range(volume_unit_col, volume_unit_col + 3))
        extract_equipment_sheet(sheet, col_range, 'Electrical', first_col, volume_unit_col)

def extract_book(book_path, cur):
    hasher = hashlib.sha1()
    with open(book_path, 'rb') as afile:
        buf = afile.read()
        hasher.update(buf)

    try:
        ciip_book = xlrd.open_workbook(book_path)
    except xlrd.biffh.XLRDError:
        print('skipping file ' + book_path)
        return

    admin_sheet = ciip_book.sheet_by_name('Administrative Info')
    cert_sheet = ciip_book.sheet_by_name('Statement of Certification')

    header = 'Signature of Certifying Official'
    co_header_idx = None
    for r in range(cert_sheet.nrows):
        if (get_sheet_value(cert_sheet, r, 1) == header):
            co_header_idx = r
            break
    if co_header_idx is None:
        raise "could not find certyfing official header"

    signature_date = get_sheet_value(cert_sheet, co_header_idx + 7, 6)
    signature_date = dateutil.parser.parse(signature_date) if signature_date is not None else None
    cur.execute(
        ('insert into ciip.application '
        '(source_file_name, source_sha1, imported_at, application_year, signature_date) '
        'values (%s, %s, %s, %s, %s) '
        'returning id'),
        (
            book_path, hasher.hexdigest(),datetime.datetime.now(),
            str(cert_sheet.cell_value(7, 10)), signature_date,
        )
    )

    application_id = cur.fetchone()[0]

    duns = get_sheet_value(admin_sheet, 8, 1)
    if type(duns) is str:
        duns = duns.replace('-', '')
    elif duns is not None:
        duns = str(int(duns))

    bc_corp_reg = get_sheet_value(admin_sheet, 10, 1)
    if bc_corp_reg is not None:
        bc_corp_reg = str(bc_corp_reg).replace(" ", "").replace('.0', '')

    operator = {
        'legal_name'      : get_sheet_value(admin_sheet, 4, 1),
        'trade_name'      : get_sheet_value(admin_sheet, 6, 1),
        'duns'            : duns,
        'bc_corp_reg'     : bc_corp_reg,
        'is_bc_cop_reg_valid' : False # overwritten below if true
    }

    if bc_corp_reg is not None:
        orgbook_req = requests.get(
            'https://orgbook.gov.bc.ca/api/v2/topic/ident/registration/' + operator.get('bc_corp_reg') + '/formatted')
        if orgbook_req.status_code == 200 :
            orgbook_resp = orgbook_req.json()
            operator['is_bc_cop_reg_valid'] = True
            operator['orgbook_legal_name'] = orgbook_resp['names'][0]['text']
            operator['is_registration_active'] = not orgbook_resp['names'][0]['inactive']

    if duns is not None:
        cur.execute(
            """
            select distinct swrs_organisation_id from ggircs.organisation
            where duns = %s
            """,
            (duns,)
        )
        res = cur.fetchone()
        if res is not None:
            operator['swrs_operator_id'] = res[0]

    cur.execute(
        ('insert into ciip.operator '
        '(application_id, business_legal_name, english_trade_name, bc_corp_reg_number, '
        'is_bc_cop_reg_number_valid, orgbook_legal_name, is_registration_active, duns, swrs_operator_id) '
        'values (%s, %s, %s, %s, %s, %s, %s, %s, %s) '
        'returning id'),
        (application_id, operator['legal_name'], operator['trade_name'], operator['bc_corp_reg'],
        operator.get('is_bc_cop_reg_valid'), operator.get('orgbook_legal_name'), operator.get('is_registration_active'),
        operator.get('duns'), operator.get('swrs_operator_id'))
    )
    operator['id'] = cur.fetchone()[0]

    bcghg_id = str(get_sheet_value(admin_sheet, 8, 3)).replace('.0', '').strip() if get_sheet_value(admin_sheet, 8, 3) is not None else None
    facility = {
        'name'            : get_sheet_value(admin_sheet, 30, 1, operator['trade_name']),
        'bcghg_id'        : bcghg_id,
        'type'            : get_sheet_value(admin_sheet, 32, 1),
        'naics'           : int(get_sheet_value(admin_sheet, 32, 3, get_sheet_value(admin_sheet, 10, 3, 0))),
        'description'     : get_sheet_value(admin_sheet, 42, 1) if admin_sheet.nrows >= 43 else None,
    }

    cur.execute(
        '''
        select distinct swrs_facility_id from ggircs.identifier
        where identifier_value = %s
        ''',
        (facility['bcghg_id'],)
    )

    res = cur.fetchone()
    if res is not None:
        facility['swrs_facility_id'] = res[0]

    activities = []
    if 'Production' in ciip_book.sheet_names():
        # In the SFO applications, associated emissions are in a separate sheet
        # Make a dict of the associated emissions
        associated_emissions_sheet = ciip_book.sheet_by_name('Emissions Allocation')
        associated_emissions = {}
        for row in range(4, 26, 2):
            product = get_sheet_value(associated_emissions_sheet, row, 2)
            emission = zero_if_not_number(get_sheet_value(associated_emissions_sheet, row, 6))
            if emission == 0: # in case a unit was entered in the 'tonnes CO2' column
                emission = zero_if_not_number(get_sheet_value(associated_emissions_sheet, row, 4))
            if product is not None:
                associated_emissions[product.strip().lower()] = emission

        production_sheet = ciip_book.sheet_by_name('Production')
        for row in range(3, 42, 2):
            product = get_sheet_value(production_sheet, row, 4)
            if product is not None :
                emission = associated_emissions.get(product.strip().lower()) if len(associated_emissions) > 1 else list(associated_emissions.values())[0]
                activities.append((
                    application_id,
                    product,
                    get_sheet_value(production_sheet, row, 6),
                    get_sheet_value(production_sheet, row, 8),
                    emission
                ))

        facility['production_calculation_explanation'] = get_sheet_value(production_sheet, 47, 2)
        facility['production_additional_info'] = get_sheet_value(production_sheet, 51, 2)
        facility['production_public_info'] = get_sheet_value(production_sheet, 55, 2)
    else:
        production_sheet = ciip_book.sheet_by_name('Module GHGs and production')
        for row in range(5, 18):
            q = none_if_not_number(get_sheet_value(production_sheet, row, 1))
            e = none_if_not_number(get_sheet_value(production_sheet, row, 3))
            if q is not None or e is not None:
                activities.append((
                    application_id,
                    get_sheet_value(production_sheet, row, 0),
                    q,
                    get_sheet_value(production_sheet, row, 2),
                    e,
                ))

    psycopg2.extras.execute_values(
        cur,
        '''insert into ciip.production (application_id, product, quantity, units, associated_emissions)
        values %s''',
        activities
    )

    cur.execute(
        ('''
        insert into ciip.facility
        (
            application_id, operator_id, facility_name, facility_type,
            bc_ghg_id, facility_description, naics, swrs_facility_id,
            production_calculation_explanation, production_additional_info,
            production_public_info
        )
        values (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        returning id
        '''
        ),
        (
            application_id,
            operator['id'],
            facility['name'],
            facility['type'],
            facility['bcghg_id'],
            facility['description'],
            facility['naics'],
            facility.get('swrs_facility_id'),
            facility.get('production_calculation_explanation'),
            facility.get('production_additional_info'),
            facility.get('production_public_info'),
        )
    )
    facility['id'] = cur.fetchone()[0]

    rep_addr =  {
        'street_address'  : get_sheet_value(admin_sheet, 24, 1),
        'municipality'    : get_sheet_value(admin_sheet, 24, 3),
        'province'        : get_sheet_value(admin_sheet, 26, 1),
        'postal_code'     : get_sheet_value(admin_sheet, 26, 3),
        'application_id'  : application_id,
    }

    co_addr =  {
        'street_address'  : get_sheet_value(cert_sheet, co_header_idx + 11, 1),
        'municipality'    : get_sheet_value(cert_sheet, co_header_idx + 11, 4),
        'province'        : get_sheet_value(cert_sheet, co_header_idx + 13, 1),
        'postal_code'     : get_sheet_value(cert_sheet, co_header_idx + 13, 4),
        'application_id'  : application_id,
    }

    addresses = [
        # operator address
        {
            'street_address'  : admin_sheet.cell_value(12, 1),
            'municipality'    : admin_sheet.cell_value(12, 3),
            'province'        : admin_sheet.cell_value(14, 1),
            'postal_code'     : admin_sheet.cell_value(14, 3),
            'application_id'  : application_id,
            'operator_id'     : operator['id'],
        },
        # facility location
        {
            'street_address'  : admin_sheet.cell_value(34, 1),
            'municipality'    : admin_sheet.cell_value(36, 1),
            'application_id'  : application_id,
            'facility_location_id' : facility['id'],
        },
        # facility mailing
        {
            'street_address'  : get_sheet_value(admin_sheet, 38, 1, get_sheet_value(admin_sheet, 34, 1)),
            'municipality'    : get_sheet_value(admin_sheet, 38, 3, get_sheet_value(admin_sheet, 36, 1)),
            'province'        : admin_sheet.cell_value(40, 1),
            'postal_code'     : admin_sheet.cell_value(40, 3),
            'application_id'  : application_id,
            'facility_mailing_id' : facility['id'],
        },
        rep_addr,
        co_addr
    ]

    def addresses_eq(a, b):
        return (
            a['street_address'] == b['street_address'] and
            a['municipality'] == b['municipality'] and
            a.get('province') == b.get('province') and
            a.get('postal_code') == b.get('postal_code')
        )

    addresses = reduce_dicts_array(addresses, addresses_eq)
    addr_ids = []

    for a in addresses:
        cur.execute('''insert into ciip.address (application_id, facility_location_id, facility_mailing_id,
        operator_id, street_address, municipality, postal_code, province)
        values (%s,%s,%s,%s,%s,%s,%s,%s)  returning id ''', (
            a.get('application_id'), a.get('facility_location_id'), a.get('facility_mailing_id'),
            a.get('operator_id'), a.get('street_address'), a.get('municipality'), a.get('postal_code'),
            a.get('province')
        ))
        addr_ids.append(cur.fetchone())

    rep_addr_idx = next (i for i,a in enumerate(addresses) if addresses_eq(a, rep_addr))
    co_addr_idx = next (i for i,a in enumerate(addresses) if addresses_eq(a, co_addr))
    contacts = [
        {
            'first_name'      : get_sheet_value(cert_sheet, co_header_idx + 7, 1),
            'last_name'       : get_sheet_value(cert_sheet, co_header_idx + 7, 4),
            'position'        : get_sheet_value(cert_sheet, co_header_idx + 9, 1),
            'email'           : get_sheet_value(cert_sheet, co_header_idx + 9, 4),
            'phone'           : get_sheet_value(cert_sheet, co_header_idx + 9, 6),
            'application_id'  : application_id,
            'facility_id'     : facility['id'],
            'operator_id'     : operator['id'],
            'application_co_id' : application_id,
            'address_id'      : addr_ids[co_addr_idx][0]
        },
        {
            'first_name'      : admin_sheet.cell_value(18, 1),
            'last_name'       : admin_sheet.cell_value(18, 3),
            'position'        : admin_sheet.cell_value(20, 1),
            'email'           : admin_sheet.cell_value(20, 3),
            'phone'           : admin_sheet.cell_value(22, 1),
            'application_id'  : application_id,
            'facility_id'     : facility['id'],
            'operator_id'     : operator['id'],
            'fax'             : get_sheet_value(admin_sheet, 22, 3),
            'facility_rep_id' : facility['id'],
            'address_id'      : addr_ids[rep_addr_idx][0]
        }
    ]

    contacts = reduce_dicts_array(contacts, should_merge_contacts)
    def contact_dict_to_tuple(c) :
        return (
            c['application_id'], c.get('application_co_id'), c['address_id'],
            c['facility_id'], c.get('facility_rep_id'), c['operator_id'], c['first_name'],
            c['last_name'], c.get('phone'), c.get('fax'), c['email'],
            c['position']
        )

    psycopg2.extras.execute_values(
        cur,
        '''insert into ciip.contact (application_id, application_co_id, address_id,
        facility_id, facility_rep_id, operator_id, given_name, family_name, telephone_number,
        fax_number, email_address, position)
        values %s''',
        list(map(contact_dict_to_tuple, contacts))
    )

    fuel_sheet = ciip_book.sheet_by_name('Fuel Usage') if 'Fuel Usage' in ciip_book.sheet_names() else ciip_book.sheet_by_name('Fuel Usage ')
    # emissions_sheet = incentives_book.sheet_by_name('Emissions')

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
                fuel_fields.append(application_id)
                fuel = tuple(fuel_fields)
                fuels.append(fuel)
            except:
                print('Could not parse Fuel row: ' + ','.join(str(e) for e in fuel_fields))

    psycopg2.extras.execute_values(
        cur,
        '''insert into ciip.fuel(fuel_type, fuel_type_alt, fuel_description, quantity, fuel_units, carbon_emissions, application_id)
        values %s''',
        fuels
    )

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


    elec_and_heat = [
        (
            application_id,
            'Electricity',
            zero_if_not_number(get_sheet_value(elec_sheet, row_range[0], col_range[0])),
            zero_if_not_number(get_sheet_value(elec_sheet, row_range[0], col_range[1])),
            zero_if_not_number(get_sheet_value(elec_sheet, row_range[0], col_range[2])),
            zero_if_not_number(get_sheet_value(elec_sheet, row_range[0], col_range[3])),
            zero_if_not_number(get_sheet_value(elec_sheet, row_range[0], col_range[4])),
        ),
        (
            application_id,
            'Heat',
            zero_if_not_number(get_sheet_value(elec_sheet, row_range[1], col_range[0])),
            zero_if_not_number(get_sheet_value(elec_sheet, row_range[1], col_range[1])),
            zero_if_not_number(get_sheet_value(elec_sheet, row_range[1], col_range[2])),
            zero_if_not_number(get_sheet_value(elec_sheet, row_range[1], col_range[3])),
            zero_if_not_number(get_sheet_value(elec_sheet, row_range[1], col_range[4])),
        ),
    ]

    psycopg2.extras.execute_values(
        cur,
        '''insert into ciip.energy
         (application_id, energy_type, purchased_energy, generated_energy,
         consumed_energy, sold_energy, emissions_from_generated)
        values %s''',
        elec_and_heat
    )

    extract_equipment(ciip_book, cur, application_id)

    return

conn = psycopg2.connect(dbname='ggircs_dev', host='localhost')
cur = conn.cursor()

directories = [
    'data/ciip/02_Applications_unverified admin_SFO',
    'data/ciip/02_Applications_unverified admin_LFO'
]

try:
    for directory in directories:
        for filename in os.listdir(directory):
            print('parsing: ' + filename)
            extract_book(os.path.join(directory,filename), cur)
    conn.commit()
except Exception as e:
    conn.rollback()
    raise e
finally:
    cur.close()
    conn.close()
