import xlrd
import requests

# included_sheets = [
#     'Administrative Info', 'Emissions',
#     'Production', 'Emissions Allocation',
#     'Fuel Usage', 'Electricity',
#     'Statement of Certification'
# ]

def extract_book(book_path):
    incentives_book = xlrd.open_workbook(book_path)
    admin_sheet = incentives_book.sheet_by_name('Administrative Info')
    operator = {
        'legal_name'      : admin_sheet.cell_value(4, 1),
        'trade_name'      : admin_sheet.cell_value(6, 1),
        'duns'            : admin_sheet.cell_value(8, 1),
        'bcghg_id'        : admin_sheet.cell_value(8, 3),
        'bc_corp_reg'     : admin_sheet.cell_value(10, 1),
        'mailing_address' : admin_sheet.cell_value(12, 1),
        'mailing_city'    : admin_sheet.cell_value(12, 3),
        'province'        : admin_sheet.cell_value(14, 1),
        'postal_code'     : admin_sheet.cell_value(14, 3),
    }

    orgbook_req = requests.get(
        'https://orgbook.gov.bc.ca/api/v2/topic/ident/registration/' + operator['bc_corp_reg'] + '/formatted')
    if orgbook_req.status_code == 200 :
        orgbook_resp = orgbook_req.json()
        operator['orgbook_legal_name'] = orgbook_resp['names'][0]['text']
        operator['is_registration_active'] = not orgbook_resp['names'][0]['inactive']

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

    facility = {
        'name'            : admin_sheet.cell_value(30, 1),
        'type'            : admin_sheet.cell_value(32, 1),
        'naics'           : admin_sheet.cell_value(32, 3),
        'location_address': admin_sheet.cell_value(34, 1),
        'nearest_city'    : admin_sheet.cell_value(36, 1),
        'mailing_address' : admin_sheet.cell_value(38, 1),
        'mailing_city'    : admin_sheet.cell_value(38, 3),
        'province'        : admin_sheet.cell_value(40, 1),
        'postal_code'     : admin_sheet.cell_value(40, 3),
        'description'     : admin_sheet.cell_value(42, 1),
    }

    cert_sheet = incentives_book.sheet_by_name('Statement of Certification')

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
    return

extract_book('data/test_incentive_appl.xls')