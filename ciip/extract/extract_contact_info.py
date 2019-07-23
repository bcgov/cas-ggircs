import psycopg2
import psycopg2.extras
import util
from util import get_sheet_value, reduce_dicts_array, partial_dict_eq, search_row_index

## returns True if two contact dicts represent the same individual
def should_merge_contacts(a,b):
    return partial_dict_eq(a, b, ['first_name', 'last_name', 'position', 'email', 'phone'])


def addresses_eq(a, b):
    return partial_dict_eq(a, b, ['street_address', 'municipality', 'province', 'postal_code'])

def extract(ciip_book, cursor, application_id, operator_id, facility_id):
    admin_sheet = ciip_book.sheet_by_name('Administrative Info')
    cert_sheet = ciip_book.sheet_by_name('Statement of Certification')
    co_header_idx = search_row_index(cert_sheet, 1, 'Signature of Certifying Official')

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
            'operator_id'     : operator_id,
        },
        # facility location
        {
            'street_address'  : admin_sheet.cell_value(34, 1),
            'municipality'    : admin_sheet.cell_value(36, 1),
            'application_id'  : application_id,
            'facility_location_id' : facility_id,
        },
        # facility mailing
        {
            'street_address'  : get_sheet_value(admin_sheet, 38, 1, get_sheet_value(admin_sheet, 34, 1)),
            'municipality'    : get_sheet_value(admin_sheet, 38, 3, get_sheet_value(admin_sheet, 36, 1)),
            'province'        : admin_sheet.cell_value(40, 1),
            'postal_code'     : admin_sheet.cell_value(40, 3),
            'application_id'  : application_id,
            'facility_mailing_id' : facility_id,
        },
        rep_addr,
        co_addr
    ]

    addresses = reduce_dicts_array(addresses, addresses_eq)
    addr_ids = []

    for a in addresses:
        cursor.execute('''insert into ciip_2018.address (application_id, facility_location_id, facility_mailing_id,
        operator_id, street_address, municipality, postal_code, province)
        values (%s,%s,%s,%s,%s,%s,%s,%s)  returning id ''', (
            a.get('application_id'), a.get('facility_location_id'), a.get('facility_mailing_id'),
            a.get('operator_id'), a.get('street_address'), a.get('municipality'), a.get('postal_code'),
            a.get('province')
        ))
        addr_ids.append(cursor.fetchone())


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
            'facility_id'     : facility_id,
            'operator_id'     : operator_id,
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
            'facility_id'     : facility_id,
            'operator_id'     : operator_id,
            'fax'             : get_sheet_value(admin_sheet, 22, 3),
            'facility_rep_id' : facility_id,
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
        cursor,
        '''insert into ciip_2018.contact (application_id, application_co_id, address_id,
        facility_id, facility_rep_id, operator_id, given_name, family_name, telephone_number,
        fax_number, email_address, position)
        values %s''',
        list(map(contact_dict_to_tuple, contacts))
    )
