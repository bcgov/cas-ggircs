# -*- coding: utf-8 -*-
from dag_configuration import default_dag_args
from trigger_k8s_cronjob import trigger_k8s_cronjob
from reload_nginx_containers import reload_nginx_containers
from walg_backups import create_backup_task
from airflow.providers.standard.operators.trigger_dagrun import TriggerDagRunOperator
from airflow.providers.standard.operators.python import PythonOperator
from datetime import datetime, timedelta
from airflow import DAG
import os
import sys

sys.path.insert(0, os.path.abspath(os.path.dirname(__file__)))

TWO_DAYS_AGO = datetime.now() - timedelta(days=2)

DEPLOY_DB_DAG_NAME = 'cas_ggircs_deploy_db'
LOAD_DB_DAG_NAME = 'cas_ggircs_load_db'
LOAD_TESTING_SETUP_DAG_NAME = 'cas_ggircs_ciip_load_testing_data'
CERT_RENEWAL_DAG_NAME = 'cas_ggircs_acme_renewal'
CERT_ISSUE_DAG_NAME = 'cas_ggircs_acme_issue'
BACKUP_DAG_NAME = 'walg_backup_ggircs_full'

ggircs_namespace = os.getenv('GGIRCS_NAMESPACE')
ciip_namespace = os.getenv('CIIP_NAMESPACE')

default_args = {
    **default_dag_args,
    'start_date': TWO_DAYS_AGO
}

"""
###############################################################################
#                                                                             #
# DAG triggering cron jobs to setup the ggircs database                       #
#                                                                             #
###############################################################################
"""


deploy_db_dag = DAG(DEPLOY_DB_DAG_NAME, schedule=None,
    default_args=default_args, is_paused_upon_creation=False)

ggircs_db_init = PythonOperator(
    python_callable=trigger_k8s_cronjob,
    task_id='ggircs_db_init',
    op_args=['cas-ggircs-db-init', ggircs_namespace],
    dag=deploy_db_dag)

trigger_load_db_dag = TriggerDagRunOperator(
    task_id='trigger_cas_ggircs_load_db_dag',
    trigger_dag_id=LOAD_DB_DAG_NAME,
    dag=deploy_db_dag,
    wait_for_completion=True
)

ggircs_db_init >> trigger_load_db_dag

load_db_dag = DAG(LOAD_DB_DAG_NAME, schedule=None,
    default_args=default_args, is_paused_upon_creation=False)

ggircs_etl = PythonOperator(
    python_callable=trigger_k8s_cronjob,
    task_id='ggircs_etl',
    op_args=['cas-ggircs-etl-deploy', ggircs_namespace],
    dag=load_db_dag)

ggircs_read_only_user = PythonOperator(
    python_callable=trigger_k8s_cronjob,
    task_id='ggircs_read_only_user',
    op_args=['cas-ggircs-db-create-readonly-user', ggircs_namespace],
    dag=load_db_dag)

ggircs_app_user = PythonOperator(
    python_callable=trigger_k8s_cronjob,
    task_id='ggircs_app_user',
    op_args=['cas-ggircs-app-user', ggircs_namespace],
    dag=load_db_dag)

ggircs_app_schema = PythonOperator(
    python_callable=trigger_k8s_cronjob,
    task_id='ggircs_app_schema',
    op_args=['cas-ggircs-schema-deploy-data', ggircs_namespace],
    dag=load_db_dag)


ggircs_etl >> ggircs_read_only_user
ggircs_etl >> ggircs_app_user
ggircs_app_schema >> ggircs_read_only_user
ggircs_app_schema >> ggircs_app_user

"""
###############################################################################
#                                                                             #
# DAGs triggering cron jobs to setup the ggircs database for load testing     #
#                                                                             #
###############################################################################
"""

load_testing_setup_dag = DAG(LOAD_TESTING_SETUP_DAG_NAME, schedule=None,
                            default_args=default_args, is_paused_upon_creation=False)

ggircs_load_testing_data = PythonOperator(
    python_callable=trigger_k8s_cronjob,
    task_id='deploy-ggircs-load-testing-data',
    op_args=['cas-ggircs-deploy-load-testing-data', ggircs_namespace],
    dag=load_testing_setup_dag)

ciip_init_db = PythonOperator(
    python_callable=trigger_k8s_cronjob,
    task_id='ciip_portal_db_init',
    op_args=['cas-ciip-portal-init-db', ciip_namespace],
    dag=load_testing_setup_dag)

ciip_swrs_import = PythonOperator(
    python_callable=trigger_k8s_cronjob,
    task_id='ciip_swrs_import',
    op_args=['cas-ciip-portal-swrs-import', ciip_namespace],
    dag=load_testing_setup_dag)

ciip_load_testing_data = PythonOperator(
    python_callable=trigger_k8s_cronjob,
    task_id='ciip_deploy_load_testing_data',
    op_args=['cas-ciip-portal-load-testing-data', ciip_namespace],
    dag=load_testing_setup_dag)

ciip_graphile_schema = PythonOperator(
    python_callable=trigger_k8s_cronjob,
    task_id='ciip_portal_graphile_schema',
    op_args=['cas-ciip-portal-init-graphile-schema', ciip_namespace],
    dag=load_testing_setup_dag)


ciip_app_user = PythonOperator(
    python_callable=trigger_k8s_cronjob,
    task_id='ciip_portal_app_user',
    op_args=['cas-ciip-portal-app-user', ciip_namespace],
    dag=load_testing_setup_dag)


ggircs_load_testing_data >> ciip_init_db >> ciip_swrs_import >> ciip_load_testing_data >> ciip_graphile_schema >> ciip_app_user


"""
###############################################################################
#                                                                             #
# DAG triggering the cas-ggircs-acme-renewal cron job                         #
#                                                                             #
###############################################################################
"""
SCHEDULE_INTERVAL = '0 8 * * *'

acme_renewal_args = {
    **default_dag_args,
    'start_date': TWO_DAYS_AGO,
    'is_paused_upon_creation': True
}

"""
DAG cas_ggircs_issue
Issues site certificates for the GGIRCS app
"""
acme_issue_dag = DAG(CERT_ISSUE_DAG_NAME,
                     schedule=None, default_args=acme_renewal_args)

cron_acme_issue_task = PythonOperator(
    python_callable=trigger_k8s_cronjob,
    task_id='cas_ggircs_cert_issue',
    op_args=['cas-ggircs-acme-issue', ggircs_namespace],
    dag=acme_issue_dag)

"""
DAG cas_ggircs_acme_renewal
Renews site certificates for the GGIRCS app
"""
acme_renewal_dag = DAG(CERT_RENEWAL_DAG_NAME, schedule=SCHEDULE_INTERVAL,
                       default_args=acme_renewal_args)

cert_renewal_task = PythonOperator(
    python_callable=trigger_k8s_cronjob,
    task_id='cas_ggircs_cert_renewal',
    op_args=['cas-ggircs-acme-renewal', ggircs_namespace],
    dag=acme_renewal_dag)

reload_nginx_task = PythonOperator(
    python_callable=reload_nginx_containers,
    task_id='cas_ggircs_reload_nginx',
    op_args=['cas-ggircs', ggircs_namespace],
    dag=acme_renewal_dag)

cert_renewal_task >> reload_nginx_task
