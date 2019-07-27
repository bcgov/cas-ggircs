import xlrd
import psycopg2
import os
import argparse
import extract_application
import extract_operator
import extract_facility
import extract_contact_info
import extract_production
import extract_equipment
import extract_energy
import extract_fuel
import extract_emission

def extract_book(book_path, cursor):
    try:
        ciip_book = xlrd.open_workbook(book_path)
    except xlrd.biffh.XLRDError:
        print('skipping file ' + book_path)
        return

    application_id = extract_application.extract(ciip_book, cursor, book_path)
    operator = extract_operator.extract(ciip_book, cursor, application_id)
    facility = extract_facility.extract(ciip_book, cursor, application_id, operator)
    extract_contact_info.extract(ciip_book, cursor, application_id, operator['id'], facility['id'])
    extract_fuel.extract(ciip_book, cursor, application_id, operator['id'], facility['id'])
    extract_energy.extract(ciip_book, cursor, application_id, operator['id'], facility['id'])
    extract_production.extract(ciip_book, cursor, application_id, operator['id'], facility['id'])
    extract_equipment.extract(ciip_book, cursor, application_id, operator['id'], facility['id'])
    extract_emission.extract(ciip_book, cursor, application_id, operator['id'], facility['id'])

    return


parser = argparse.ArgumentParser(description='Extracts data from CIIP excel application files and writes it to database')
parser.add_argument('--dirslist', type=open)
parser.add_argument('--db', default='ggircs_dev')
parser.add_argument('--host', default='localhost')
parser.add_argument('--user')
parser.add_argument('--password')
args = parser.parse_args()

conn = psycopg2.connect(dbname=args.db, host=args.host, user=args.user, password=args.password)
cur = conn.cursor()

directories = args.dirslist.read().split('\n')

try:
    cur.execute('truncate table ciip_2018.application cascade;')
    for directory in directories:
        if directory.strip() == '':
            continue
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
