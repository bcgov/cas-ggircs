#!/bin/bash

# This script executes the extract python script
# It is intended to be executed in an openshift container having the variables used below defined

python ./extract.py --dirslist /opt/configs/ciip-dirs --host $PGHOST --db $PGDATABASE --user $PGUSER --password $PGPASSWORD && echo 'extraction done'

# start an http server to keep the pod alive
python -m http.server
