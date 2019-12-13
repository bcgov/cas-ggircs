#!/usr/bin/env bash
# Encode non UTF-8 files to UFT-8 for Postgres compatibility

database=${PGDATABASE:-ggircs_dev}
input_file="$1"
encoded_file=${input_file/xmls_from_eccc/utf8_encoded_xmls}
filename=$(basename -- "$1")

_psql() {
  user=${PGUSER:-$(whoami)}
  database=${PGDATABASE:-$database}
  host=${PGHOST:-localhost}
  port=${PGPORT:-5432}
  psql -d "$database" -h "$host" -p "$port" -U "$user" -qtA --set ON_ERROR_STOP=1 "$@" 2>&1
}

#convert xmls to utf-8 encoding
convertToUFT8(){
    charset=$(file -I "$input_file" | awk -F "=" '{print $2}')
    if [[ "$charset" !=  'utf-8' ]]; then
        echo "Converting $filename from $charset to UTF-8"
        iconv -f "$charset" -t UTF-8 "$input_file" > ./data/eccc_xmls/utf8_encoded_xmls/"$filename"
    fi
}

#insert validated and encoded file into ghgr_import
insertIntoGHGRImport(){
    _psql -c "\copy swrs_extract.ghgr_import(xml_file) from '$encoded_file';"
}

#check if the xml is well-formed
validateXML(){
    log=$(xmllint --noout --huge "$input_file" 2>&1)
    isValid=$?
    if [[ "$isValid" -eq 0 ]]; then
        convertToUFT8
        insertIntoGHGRImport
    else
        echo 'XML is not valid. Please check the log table for more details.'
        _psql <<EOF
            insert into swrs_extract.log(report_name, log)
            values ('$filename', '$log')
EOF
    fi
}


validateXML
