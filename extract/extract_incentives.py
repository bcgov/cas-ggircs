import xlrd
import requests
import psycopg2
import hashlib
import datetime
import dateutil.parser

# included_sheets = [
#     'Administrative Info', 'Emissions',
#     'Production', 'Emissions Allocation',
#     'Fuel Usage', 'Electricity',
#     'Statement of Certification'
# ]

def extract_book(book_path, cur):
    hasher = hashlib.sha1()
    with open(book_path, 'rb') as afile:
        buf = afile.read()
        hasher.update(buf)

    incentives_book = xlrd.open_workbook(book_path)
    admin_sheet = incentives_book.sheet_by_name('Administrative Info')
    cert_sheet = incentives_book.sheet_by_name('Statement of Certification')

    cur.execute(
        ('insert into ciip.application '
        '(source_file_name, source_sha1, imported_at, application_year, signature_date) '
        'values (%s, %s, %s, %s, %s) '
        'returning id'),
        (book_path, hasher.hexdigest(),datetime.datetime.now(),
        int(cert_sheet.cell_value(7, 10)), dateutil.parser.parse(cert_sheet.cell_value(47, 6)))
    )

    application_id = cur.fetchone()[0]

    operator = {
        'legal_name'      : admin_sheet.cell_value(4, 1),
        'trade_name'      : admin_sheet.cell_value(6, 1),
        'duns'            : admin_sheet.cell_value(8, 1),
        'bc_corp_reg'  : admin_sheet.cell_value(10, 1),
        'mailing_address' : admin_sheet.cell_value(12, 1),
        'mailing_city'    : admin_sheet.cell_value(12, 3),
        'province'        : admin_sheet.cell_value(14, 1),
        'postal_code'     : admin_sheet.cell_value(14, 3),
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

    cur.execute(
        ('insert into ciip.operator '
        '(application_id, business_legal_name, english_trade_name, bc_corp_reg_number, '
        'is_bc_cop_reg_number_valid, orgbook_legal_name, is_registration_active, duns) '
        'values (%s, %s, %s, %s, %s, %s, %s, %s) '
        'returning id'),
        (application_id, operator['legal_name'], operator['trade_name'], operator['bc_corp_reg'],
        operator['is_bc_cop_reg_valid'], operator['orgbook_legal_name'], operator['is_registration_active'],
        operator['duns'])
    )
    operator['id'] = cur.fetchone()[0]


    facility = {
        'name'            : admin_sheet.cell_value(30, 1),
        'bcghg_id'        : str(int(admin_sheet.cell_value(8, 3))),
        'type'            : admin_sheet.cell_value(32, 1),
        'naics'           : int(admin_sheet.cell_value(32, 3)),
        'location_address': admin_sheet.cell_value(34, 1),
        'nearest_city'    : admin_sheet.cell_value(36, 1),
        'mailing_address' : admin_sheet.cell_value(38, 1),
        'mailing_city'    : admin_sheet.cell_value(38, 3),
        'province'        : admin_sheet.cell_value(40, 1),
        'postal_code'     : admin_sheet.cell_value(40, 3),
        'description'     : admin_sheet.cell_value(42, 1),
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


    representative = {
        'first_name'      : admin_sheet.cell_value(18, 1),
        'last_name'       : admin_sheet.cell_value(18, 3),
        'position'        : admin_sheet.cell_value(20, 1),
        'email'           : admin_sheet.cell_value(20, 3),
        'phone'           : admin_sheet.cell_value(22, 1),
        'fax'             : admin_sheet.cell_value(22, 3),
        'mailing_address' : admin_sheet.cell_value(24, 1),
        'mailing_city'    : admin_sheet.cell_value(24, 3),
        'province'        : admin_sheet.cell_value(26, 1),
        'postal_code'     : admin_sheet.cell_value(26, 3),
    }

    certifying_official = {
        'first_name'      : cert_sheet.cell_value(47, 1),
        'last_name'       : cert_sheet.cell_value(47, 4),
        'position'        : cert_sheet.cell_value(49, 1),
        'email'           : cert_sheet.cell_value(49, 4),
        'phone'           : cert_sheet.cell_value(49, 6),
        'mailing_address' : cert_sheet.cell_value(51, 1),
        'mailing_city'    : cert_sheet.cell_value(51, 4),
        'province'        : cert_sheet.cell_value(53, 1),
        'postal_code'     : cert_sheet.cell_value(53, 4),
    }

    return {
        'operator': operator,
        'representative': representative,
        'facility': facility,
        'certifying_official': certifying_official,
    }

conn = psycopg2.connect(dbname='ggircs_dev', host='localhost')
cur = conn.cursor()

try:
    appl = extract_book('data/test_incentive_appl.xls', cur)
    conn.commit()
except Exception as e:
    conn.rollback()
    print(e)
cur.close()
conn.close()
