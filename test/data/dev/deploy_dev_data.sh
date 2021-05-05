#!/bin/bash
set -e

database=${PGDATABASE:-ggircs_dev}
user=${PGUSER:-$(whoami)}
host=${PGHOST:-localhost}
port=${PGPORT:-5432}

__dirname="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
pushd "$__dirname" > /dev/null

_psql() {
  psql -d "$database" -h "$host" -p "$port" -U "$user" -qtA --set ON_ERROR_STOP=1 "$@" 2>&1
}

deployDevData() {
  _psql -f "./dev_data.sql"
  return 0;
}

if [[ $1 =~ -dev$ ]]; then
  echo 'deploying dev data...';
  deployDevData
fi

