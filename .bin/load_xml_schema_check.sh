#!/usr/bin/env bash
# Load all xml schema nodes into the xml_schema_check table

set -e
database=${PGDATABASE:-ggircs_dev}

_psql() {
  user=${PGUSER:-$(whoami)}
  database=${PGDATABASE:-$database}
  host=${PGHOST:-localhost}
  port=${PGPORT:-5432}
  psql -d "$database" -h "$host" -p "$port" -U "$user" -qtA --set ON_ERROR_STOP=1 "$@" 2>&1
}


#load data into xml_schema_check
loadXMLSchemaCheck(){
    _psql -c "truncate swrs_extract.xml_schema_check"
    _psql -c  "\copy swrs_extract.xml_schema_check(historic_node) FROM './data/xml_schema_check.csv' delimiter '|' csv"
}

loadXMLSchemaCheck
