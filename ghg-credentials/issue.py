import argparse
import json
import requests
import parse as csv_parser
import psycopg2
import csv

ENVIRONMENT_URLS = {
    'dev': 'https://ghg-emissions-issuer-a3e512-dev.apps.silver.devops.gov.bc.ca/issue-credential',
    'test': 'https://ghg-emissions-issuer-a3e512-test.apps.silver.devops.gov.bc.ca/issue-credential',
    'prod': 'https://ghg-emissions-issuer-a3e512-prod.apps.silver.devops.gov.bc.ca/issue-credential'
}

ISSUER_SECRET_HEADER = 'Issuer-Secret-Key'

parser = argparse.ArgumentParser(
    description='Issue Verified Credentials from GHG Emissions CSV')

parser.add_argument('--env', '-e',
                    dest='environment',
                    help='Environment to issue (dev = default, test, prod)',
                    default='dev')
parser.add_argument('--url', '-u',
                    dest='url',
                    help='Full Url to Credential Issuer (instead of using --env)')
parser.add_argument('--issuer-key', '-i',
                    dest='issuer_key',
                    help='Issuer Secret Authorization Key',
                    required=True)
#
# These are passed on to the csv parsing routine
#
parser.add_argument('--csv', '-c',
                    dest='csv_file',
                    help='Path to CSV file (defaults to ghg-emissions.csv)',
                    default='ghg-emissions.csv')
parser.add_argument('--year', '-y',
                    dest='year',
                    help='Reporting Year (optional)')
parser.add_argument('--schemas', '-s',
                    dest='schema_file',
                    help='Path to schemas file (optional)')
parser.add_argument('--name', '-n',
                    dest='schema_name',
                    help='Schema name (optional)')
parser.add_argument('--version', '-v',
                    dest='schema_version',
                    help='Schema version (optional)')
parser.add_argument('--mapping', '-m',
                    dest='csv_schema_mapping',
                    help='CSV to Schema Mappings (optional)')
parser.add_argument('--registry', '-r',
                    dest='company_registry',
                    help='Company to BC Registration ID Mappings (optional)')

def issue_credentials(environment, url, issuer_key, data):
    result = []
    _url = ENVIRONMENT_URLS[environment]

    if url:
        # override the environment url
        _url = url
    print(f"Issuing {len(data)} credentials to '{_url}'")
    for d in data:
        # get some tracking data...
        registration_id = d['attributes']['registration_id']
        facility_name = d['attributes']['facility_name']
        # request needs to be an array...
        body = [d]
        response = requests.post(_url,
                                 json=body,
                                 headers={ISSUER_SECRET_HEADER: issuer_key})
        if response.ok:
            res = {'registration_id': registration_id,
                   'facility_name': facility_name,
                   'success': response.json()[0]['success'],
                   'result': response.json()[0]['result']
                   }
            result.append(res)
        else:
            print(f"Error issuing credential for registration_id = '{registration_id}', facility_name = '{facility_name}'. ({response.status_code}) - {response.reason}")

    return json.dumps(result)

def main():
    args = parser.parse_args()

    pg_conn = psycopg2.connect(dsn="")
    pg_cursor = pg_conn.cursor()
    pg_cursor.execute("""
    with bio as (select report_id, sum(quantity) bio_sum from swrs.emission where gas_type ilike 'co2bio%' group by report_id),
    nonbio as (select report_id, sum(quantity) nonbio_sum from swrs.emission where gas_type ilike 'co2nonbio%' group by report_id),
    n2o as (select report_id, sum(quantity) n2o_sum from swrs.emission where gas_type ilike 'n2o' group by report_id),
    ch4 as (select report_id, sum(quantity) ch4_sum from swrs.emission where gas_type ilike 'ch4' group by report_id),
    hfc as (select report_id, sum(quantity) hfc_sum from swrs.emission where gas_type ilike 'hfc%' group by report_id),
    pfc as (select report_id, sum(quantity) pfc_sum from swrs.emission where gas_type ilike 'perf%' group by report_id),
    sf6 as (select report_id, sum(quantity) sf6_sum from swrs.emission where gas_type ilike 'sf6%' group by report_id)
    select distinct on (f.facility_name, r.reporting_period_duration)
        obcid.bc_registry_id as registration_id,
        f.facility_name, o.business_legal_name as company_name, r.reporting_period_duration as reporting_year, n.naics_code, nc.naics_category as naics_description, f.latitude, f.longitude,
        coalesce((select bio_sum from bio where f.report_id = bio.report_id), 0) as co2bio,
        coalesce((select nonbio_sum from nonbio where f.report_id = nonbio.report_id), 0) as co2nonbio,
        coalesce((select n2o_sum from n2o where f.report_id = n2o.report_id), 0) as n2o,
        coalesce((select ch4_sum from ch4 where f.report_id = ch4.report_id), 0) as ch4,
        coalesce((select hfc_sum from hfc where f.report_id = hfc.report_id), 0) as hfc,
        coalesce((select pfc_sum from pfc where f.report_id = pfc.report_id), 0) as pfc,
        coalesce((select sf6_sum from sf6 where f.report_id = sf6.report_id), 0) as sf6
        from swrs.facility f
        join swrs.organisation o on f.organisation_id = o.id
        right join swrs.organisation_bc_registry_id obcid on o.swrs_organisation_id = obcid.swrs_organisation_id
        join swrs.report r on f.report_id = r.id
        join swrs.naics n on f.report_id = n.report_id
        join swrs.naics_naics_category nnc on n.naics_code::text = nnc.naics_code_pattern::text
        and nnc.category_type_id=2
        join swrs.naics_category nc on nnc.category_id = nc.id
        order by f.facility_name, r.reporting_period_duration;
    """)
    db_data = pg_cursor.fetchall()
    # print(db_data)
    with open('/tmp/ghg.csv', 'w', newline='') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(['registration_id','facility_name', 'company_name', 'reporting_year', 'naics_code', 'naics_description', 'latitude', 'longitude', 'co2bio', 'co2nonbio', 'n2o', 'ch4', 'hfc', 'pfc', 'sf6'])
        writer.writerows(db_data)



    json_data = csv_parser.parse_csv(csv_file="/tmp/ghg.csv",
                       year=args.year,
                       schema_file=args.schema_file,
                       schema_name=args.schema_name,
                       schema_version=args.schema_version,
                       csv_schema_mapping=args.csv_schema_mapping)

    py_data = json.loads(json_data)
    print(py_data)
    result = issue_credentials(environment=args.environment,
                               url=args.url,
                               issuer_key=args.issuer_key,
                               data=py_data)

    print(json.dumps(json.loads(result), indent=4))


if __name__ == "__main__":
    main()
