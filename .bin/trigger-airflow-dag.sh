#!/usr/bin/env bash

# TODO: move this script to pipeline / airflow project

set -e

dag_id=$1

dag_run_url="https://cas-airflow-$RELEASE_SUFFIX.apps.silver.devops.gov.bc.ca/api/experimental/dags/${dag_id}/dag_runs"
run_id=$(curl -sf -u "$AIRFLOW_USERNAME":"$AIRFLOW_PASSWORD" -X POST \
  $dag_run_url \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -d '{}' | jq -r .run_id )

echo "Started dag run $run_id"


function get_run_state() {
  run_timestamp=${run_id/manual__/}
  dag_state_url="https://cas-airflow-$RELEASE_SUFFIX.apps.silver.devops.gov.bc.ca/api/experimental/dags/${dag_id}/dag_runs/${run_timestamp}"
  curl -s -u "$AIRFLOW_USERNAME":"$AIRFLOW_PASSWORD" -X GET \
    $dag_state_url \
    -H 'Cache-Control: no-cache' \
    -H 'Content-Type: application/json' \
    -d '{}'
}

while true; do
  state=$(get_run_state)
  # echo $state
  case $state in
    '{"state":"success"}' )
      echo "dag succeeded"
      exit 0
      ;;
    '{"state":"running"}' )
      echo 'running'
      sleep 10
      ;;
    '{"state":"failed"}' )
      echo 'DAG failed'
      exit 1
      ;;
    *error* )
      echo "$state"
      exit 1
      ;;
  esac
done