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