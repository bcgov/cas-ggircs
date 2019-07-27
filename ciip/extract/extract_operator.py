import psycopg2
import requests

import util
from util import get_sheet_value, none_if_not_number

def extract(ciip_book, cursor, application_id):
    admin_sheet = ciip_book.sheet_by_name('Administrative Info')

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
        cursor.execute(
            """
            select distinct swrs_organisation_id from swrs.organisation
            where duns = %s
            """,
            (duns,)
        )
        res = cursor.fetchone()
        if res is not None:
            operator['swrs_operator_id'] = res[0]

    cursor.execute(
        ('insert into ciip_2018.operator '
        '(application_id, business_legal_name, english_trade_name, bc_corp_reg_number, '
        'is_bc_cop_reg_number_valid, orgbook_legal_name, is_registration_active, duns, swrs_operator_id) '
        'values (%s, %s, %s, %s, %s, %s, %s, %s, %s) '
        'returning id'),
        (application_id, operator['legal_name'], operator['trade_name'], operator['bc_corp_reg'],
        operator.get('is_bc_cop_reg_valid'), operator.get('orgbook_legal_name'), operator.get('is_registration_active'),
        operator.get('duns'), operator.get('swrs_operator_id'))
    )
    operator['id'] = cursor.fetchone()[0]
    return operator
