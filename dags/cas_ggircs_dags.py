# -*- coding: utf-8 -*-
from dag_configuration import default_dag_args
from trigger_k8s_cronjob import trigger_k8s_cronjob
from airflow.providers.standard.operators.trigger_dagrun import TriggerDagRunOperator
from airflow.decorators import dag, task
from datetime import datetime, timedelta
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


DEPLOY_DB_DAG_DOC = """
DAG triggering cron jobs to setup the ggircs database
"""


@dag(
    dag_id=DEPLOY_DB_DAG_NAME,
    schedule=None,
    default_args=default_args,
    is_paused_upon_creation=False,
    start_date=TWO_DAYS_AGO,
    doc_md=DEPLOY_DB_DAG_DOC,
)
def deploy_db():
    @task()
    def ggircs_db_init():
        trigger_k8s_cronjob("cas-ggircs-db-init", ggircs_namespace)

    trigger_load_db_dag = TriggerDagRunOperator(
        task_id="trigger_cas_ggircs_load_db_dag",
        trigger_dag_id=LOAD_DB_DAG_NAME,
        wait_for_completion=True,
    )

    ggircs_db_init() >> trigger_load_db_dag


deploy_db()


LOAD_DB_DAG_DOC = """
DAG triggered by cas_ggircs_deploy_db DAG to load the data into the database
"""

@dag(
    dag_id=LOAD_DB_DAG_NAME,
    schedule=None,
    default_args=default_args,
    is_paused_upon_creation=False,
    doc_md=LOAD_DB_DAG_DOC,
)
def load_db():
    @task
    def ggircs_etl():
        trigger_k8s_cronjob("cas-ggircs-etl-deploy", ggircs_namespace)

    @task
    def ggircs_read_only_user():
        trigger_k8s_cronjob("cas-ggircs-db-create-readonly-user", ggircs_namespace)

    @task
    def ggircs_app_user():
        trigger_k8s_cronjob("cas-ggircs-app-user", ggircs_namespace)

    @task
    def ggircs_app_schema():
        trigger_k8s_cronjob("cas-ggircs-schema-deploy-data", ggircs_namespace)

    ggircs_etl() >> ggircs_read_only_user()
    ggircs_etl() >> ggircs_app_user()
    ggircs_app_schema() >> ggircs_read_only_user()
    ggircs_app_schema() >> ggircs_app_user()

load_db()


LOAD_TESTING_SETUP_DAG_DOC = """
DAGs triggering cron jobs to setup the ggircs database for load testing
"""


@dag(
    dag_id=LOAD_TESTING_SETUP_DAG_NAME,
    schedule=None,
    default_args=default_args,
    is_paused_upon_creation=False,
    doc_md=LOAD_TESTING_SETUP_DAG_DOC,
)
def load_testing_setup():
    @task
    def ggircs_load_testing_data():
        trigger_k8s_cronjob("cas-ggircs-deploy-load-testing-data", ggircs_namespace)

    @task
    def ciip_init_db():
        trigger_k8s_cronjob("cas-ciip-portal-init-db", ciip_namespace)

    @task
    def ciip_swrs_import():
        trigger_k8s_cronjob("cas-ciip-portal-swrs-import", ciip_namespace)

    @task
    def ciip_load_testing_data():
        trigger_k8s_cronjob("cas-ciip-portal-load-testing-data", ciip_namespace)

    @task
    def ciip_graphile_schema():
        trigger_k8s_cronjob("cas-ciip-portal-init-graphile-schema", ciip_namespace)

    @task
    def ciip_app_user():
        trigger_k8s_cronjob("cas-ciip-portal-app-user", ciip_namespace)

    (
        ggircs_load_testing_data()
        >> ciip_init_db()
        >> ciip_swrs_import()
        >> ciip_load_testing_data()
        >> ciip_graphile_schema()
        >> ciip_app_user()
    )


load_testing_setup()
