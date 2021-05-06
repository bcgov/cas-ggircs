#!/bin/bash
set -e

database=${PGDATABASE:-ggircs_dev}
user=${PGUSER:-$(whoami)}
host=${PGHOST:-localhost}
port=${PGPORT:-5432}

# =============================================================================
# Usage:
# -----------------------------------------------------------------------------
usage() {
    cat << EOF
$0 [-d] [-p] [-s] [-h]

Truncates all existing data in the swrs schema & deploys dev data for every year 2018-2025.
Requires one parameter "--oc-project".

Example:

deploy_dev_data.sh --oc-project=<NAMESPACE>

EOF
}

__dirname="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
pushd "$__dirname" > /dev/null

_psql() {
  psql -d "$database" -h "$host" -p "$port" -U "$user" -qtA --set ON_ERROR_STOP=1 "$@" 2>&1
}

deployDevData() {
  _psql -f "./dev_data.sql"
  return 0;
}

if [ "$#" != 1 ]; then
    echo "Passed $# parameters. Expected 1."
    usage
    exit 1
fi

if [[ $1 =~ -dev$ ]]; then
  echo 'Truncating all tables in the swrs schema & deploying dev data...';
  deployDevData
fi

