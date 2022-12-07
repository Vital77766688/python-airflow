# python-airflow
Python Airflow Framework Quick Start

## Installation (Run only first time)

### Create .env files in env_files folder and fill them

* .postgres_env
    * POSTGRESQL_USERNAME=airflow
    * POSTGRESQL_PASSWORD=airflow
    * POSTGRESQL_DATABASE=airflow

* .airflow_env
    * AIRFLOW_DATABASE_USER=airflow
    * AIRFLOW_DATABASE_PASSWORD=airflow
    * AIRFLOW_DATABASE=airflow
    * AIRFLOW_DATABASE_SCHEMA=airflow

### Init postgres database 
```
docker compose up postgresql -d
```

### Connect to db from IDE as superuser and run db_setup.sql

### Create folders dags, plugins, logs with proper permissions
```
mkdir dags && sudo chmod u=rwx,g=rwx,o=rwx ./dags
mkdir plugins && sudo chmod u=rwx,g=rwx,o=rwx ./plugins
mkdir logs && sudo chmod u=rwx,g=rwx,o=rwx ./logs
```

### Build airflow image
```
docker build -t custom/airflow .
```

### Init airflow database
```
docker compose up airflow_init
```

### Run webserver and scheduler (don't forget check logs)
```
docker compose up airflow airflow_scheduler -d
```

### Create airflow user (set your userdata in parameters)
```
docker exec -it airflow airflow users create --username admin --firstname admin --lastname admin --role Admin --email admin@example.com --password admin
```

### Open localhost:8080 and login with specified username and password

# Dynamic DAGs usage

All dags will be generated on the start of airflow_scheduler container.

For manual dag generation use command in terminal:
```
docker exec -it airflow python ./plugins/include/generate_dags.py
```

## DAGs confing
Dags are generated from json config file (./plugins/include/dag_conf)

### DAG config structure
dag_template - specifies the path to jinja2 template for dag, dag_id, retries, retry_delay, description, schedule, start_date, catchup, tags - list and tasks.

### Task config structure
tasks list contains dictioanries with task_id, task_path - path to file with task, depends_on (optional) - list of dependecies.

### Task function structure
Task function must return operator class and it will be dynamically imported in the dag.

Example of task code:
```
from airflow.operators.python import PythonOperator


def log_info():
    print('test')


def test_task(task_id):
    test_task = PythonOperator(
        task_id=task_id,
        python_callable=log_info
    )    
    return test_task
```