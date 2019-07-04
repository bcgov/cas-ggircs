import xlrd
import requests
import psycopg2
import psycopg2.extras
import hashlib
import datetime
import dateutil.parser
import os

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


def extract_book(book_path, cur):
    hasher = hashlib.sha1()
    with open(book_path, 'rb') as afile:
        buf = afile.read()
        hasher.update(buf)

    incentives_book = xlrd.open_workbook(book_path)
    admin_sheet = incentives_book.sheet_by_name('Administrative Info')
    cert_sheet = incentives_book.sheet_by_name('Statement of Certification')

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

    cur.execute(
        ('insert into ciip.facility '
        '(application_id, operator_id, facility_name, facility_type, '
        'bc_ghg_id, facility_description, naics, swrs_facility_id) '
        'values (%s, %s, %s, %s, %s, %s, %s, %s) '
        'returning id'),
        (application_id, operator['id'], facility['name'], facility['type'],
        facility['bcghg_id'], facility['description'], facility['naics'], facility.get('swrs_facility_id'))
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

    def should_merge_contacts(a,b):
        return (
            a['first_name'] == b['first_name'] and
            a['last_name'] == b['last_name'] and
            a['position'] == b['position'] and
            a['email'] == b['email'] and
            a['phone'] == b['phone']
        )

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
        values %s returning id''',
        list(map(contact_dict_to_tuple, contacts))
    )

    fuel_sheet = incentives_book.sheet_by_name('Fuel Usage') if 'Fuel Usage' in incentives_book.sheet_names() else incentives_book.sheet_by_name('Fuel Usage ')
    # emissions_sheet = incentives_book.sheet_by_name('Emissions')
    # production_sheet = incentives_book.sheet_by_name('Production')
    # emissions_allocation_sheet = incentives_book.sheet_by_name('Emissions Allocation')
    # electricity_sheet = incentives_book.sheet_by_name('Electricity')

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
