#!/usr/bin/env bash
# Encode non UTF-8 files to UFT-8 for Postgres compatibility

set -e

database=${PGDATABASE:-ggircs_dev}
input_file=$1
encoded_file=${input_file/xmls_from_eccc/utf8_encoded_xmls}
filename=$(basename -- $1)


#convert xmls to utf-8 encoding
convertToUFT8(){
    CHARSET=$(file -I $input_file | awk -F "=" '{print $2}')
    if [[ "$CHARSET" !=  'utf-8' ]]; then
        echo "Converting $filename from $CHARSET to UTF-8"
        iconv -f "$CHARSET" -t UTF-8 "$input_file" > ./data/eccc_xmls/utf8_encoded_xmls/"$filename"
    fi
}


_psql() {
  user=${PGUSER:-$(whoami)}
  database=${PGDATABASE:-$database}
  host=${PGHOST:-localhost}
  port=${PGPORT:-5432}
  psql -d "$database" -h "$host" -p "$port" -U "$user" -qtA --set ON_ERROR_STOP=1 "$@" 2>&1
}


# Check if schema is still the same
checkXMLSchema() {
echo 'Running Check XML Schema' $1
echo 'New nodes:'
_psql <<EOF
with report_diff as (
  with input_report as (
    with x as (
      select pg_read_file('$encoded_file', 0, 100000000)::xml
               as source_xml
      )
      select distinct concat(
                          level5, '/', level4, '/', level3, '/', level2, '/', level1, '/', leaf) as historic_node
      from x,
           xmltable(
               '//*'
               passing source_xml
               columns
                 leaf text path 'name(.)' not null
                 ,level1 text path 'name(./parent::*)'
                 ,level2 text path 'name(./parent::*/parent::*)'
                 ,level3 text path 'name(./parent::*/parent::*/parent::*)'
                 ,level4 text path 'name(./parent::*/parent::*/parent::*/parent::*)'
                 ,level5 text path 'name(./parent::*/parent::*/parent::*/parent::*/parent::*)'
             ) as report_flat
      order by historic_node
    )
    select *
    from input_report except
    select historic_node
    from swrs.xml_schema_check)
insert
into swrs_extract.report_schema_diff(report_name, new_node)
select '$filename', historic_node
from report_diff
on conflict (
   report_name,
   new_node)
   do update set created_at = now()
   returning (
     new_node)
;

EOF

}

insertIntoGHGRImport(){
    _psql <<EOF
      insert into ggircs_dev.swrs_extract.ghgr_import(xml_file)
        select pg_read_file('$encoded_file', 0, 100000000)::xml;
EOF
}

convertToUFT8
checkXMLSchema
insertIntoGHGRImport
