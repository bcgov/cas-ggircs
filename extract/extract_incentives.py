import xlrd
import requests
import psycopg2
import psycopg2.extras
import hashlib
import datetime
import dateutil.parser
import os

# included_sheets = [
#     'Administrative Info', 'Emissions',
#     'Production', 'Emissions Allocation',
#     'Fuel Usage', 'Electricity',
#     'Statement of Certification'
# ]


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

    # TODO: Find header of signature of CO section and offset from there.

    cur.execute(
        ('insert into ciip.application '
        '(source_file_name, source_sha1, imported_at, application_year, signature_date) '
        'values (%s, %s, %s, %s, %s) '
        'returning id'),
        (book_path, hasher.hexdigest(),datetime.datetime.now(),
        int(cert_sheet.cell_value(7, 10)), dateutil.parser.parse(get_sheet_value(cert_sheet, 47, 6)))
    )

    application_id = cur.fetchone()[0]

    duns = get_sheet_value(admin_sheet, 8, 1)
    duns = duns if duns is None else str(int(duns))

    operator = {
        'legal_name'      : get_sheet_value(admin_sheet, 4, 1),
        'trade_name'      : get_sheet_value(admin_sheet, 6, 1),
        'duns'            : duns,
        'bc_corp_reg'     : get_sheet_value(admin_sheet, 10, 1),
    }

    orgbook_req = requests.get(
        'https://orgbook.gov.bc.ca/api/v2/topic/ident/registration/' + operator['bc_corp_reg'] + '/formatted')
    if orgbook_req.status_code == 200 :
        orgbook_resp = orgbook_req.json()
        operator['is_bc_cop_reg_valid'] = True
        operator['orgbook_legal_name'] = orgbook_resp['names'][0]['text']
        operator['is_registration_active'] = not orgbook_resp['names'][0]['inactive']
    else :
        operator['is_bc_cop_reg_valid'] = False

    print(operator)

    cur.execute(
        ('insert into ciip.operator '
        '(application_id, business_legal_name, english_trade_name, bc_corp_reg_number, '
        'is_bc_cop_reg_number_valid, orgbook_legal_name, is_registration_active, duns) '
        'values (%s, %s, %s, %s, %s, %s, %s, %s) '
        'returning id'),
        (application_id, operator['legal_name'], operator['trade_name'], operator['bc_corp_reg'],
        operator.get('is_bc_cop_reg_valid'), operator.get('orgbook_legal_name'), operator.get('is_registration_active'),
        operator.get('duns'))
    )
    operator['id'] = cur.fetchone()[0]


    facility = {
        'name'            : get_sheet_value(admin_sheet, 30, 1),
        'bcghg_id'        : str(int(get_sheet_value(admin_sheet, 8, 3))),
        'type'            : get_sheet_value(admin_sheet, 32, 1),
        'naics'           : int(get_sheet_value(admin_sheet, 32, 3)),
        'description'     : get_sheet_value(admin_sheet, 42, 1) if admin_sheet.nrows >= 43 else None,
    }

    cur.execute(
        ('insert into ciip.facility '
        '(application_id, operator_id, facility_name, facility_type, '
        'bc_ghg_id, facility_description, naics) '
        'values (%s, %s, %s, %s, %s, %s, %s) '
        'returning id'),
        (application_id, operator['id'], facility['name'], facility['type'],
        facility['bcghg_id'], facility['description'], facility['naics'])
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
        'street_address'  : get_sheet_value(cert_sheet, 51, 1),
        'municipality'    : cert_sheet.cell_value(51, 4),
        'province'        : cert_sheet.cell_value(53, 1),
        'postal_code'     : cert_sheet.cell_value(53, 4),
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
            'province'        : admin_sheet.cell_value(40, 1),
            'postal_code'     : admin_sheet.cell_value(40, 3),
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
            a['province'] == b['province'] and
            a['postal_code'] == b['postal_code']
        )

    addresses = reduce_dicts_array(addresses, addresses_eq)
    print(addresses)
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

    print(addr_ids)
    rep_addr_idx = next (i for i,a in enumerate(addresses) if addresses_eq(a, rep_addr))
    co_addr_idx = next (i for i,a in enumerate(addresses) if addresses_eq(a, co_addr))
    print(co_addr_idx)
    contacts = [
        {
            'first_name'      : cert_sheet.cell_value(47, 1),
            'last_name'       : cert_sheet.cell_value(47, 4),
            'position'        : cert_sheet.cell_value(49, 1),
            'email'           : cert_sheet.cell_value(49, 4),
            'phone'           : cert_sheet.cell_value(49, 6),
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
    print(contacts)
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

    return {
        'operator': operator,
        'contacts': contacts,
        'facility': facility,
        'addresses': addresses,
    }

conn = psycopg2.connect(dbname='ggircs_dev', host='localhost')
cur = conn.cursor()

directory = 'data/ciip/SFO Received/Applications'

try:
    for filename in os.listdir(directory):
        print('parsing:' + filename)
        appl = extract_book(os.path.join(directory,filename), cur)
    conn.commit()
except Exception as e:
    conn.rollback()
    raise e
finally:
    cur.close()
    conn.close()
