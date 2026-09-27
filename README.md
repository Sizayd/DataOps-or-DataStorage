# DataOps & Data Storage

**Étudiant :** Zayd ZAYANI — ESTIAM

Pipeline DataOps pédagogique construit sur 5 TP : ingestion dans un mini
Data Lake (Azurite Blob Storage), chargement en base SQL (SQLite),
transformation analytique (dbt), puis orchestration (Apache Airflow).

```
Azurite Blob Storage  --->  SQLite (staging)  --->  dbt (analytics)  --->  Airflow (orchestration)
   container "raw"        stg_blob_files          analytics_messages      dataops_pipeline (DAG)
```

## Structure du dépôt

```
.
├── data/                    # Fichiers JSON sources (TP1)
├── scripts/
│   ├── upload_blob.py       # TP1 - upload vers Azurite
│   └── load_blob_to_sql.py  # TP2 - Blob -> SQLite (staging)
├── database/                # dataops.db générée localement (non versionnée)
├── dataops_dbt/             # Projet dbt (TP3)
│   ├── models/
│   │   ├── sources.yml          # déclare stg_blob_files comme source
│   │   ├── analytics_messages.sql
│   │   └── schema.yml           # tests unique / not_null
│   └── profiles/profiles.local.yml.example
├── .dbt/profiles.yml        # Profil dbt pour l'exécution via Docker/Airflow (TP5)
├── airflow/
│   ├── dags/dataops_pipeline_dag.py  # DAG : dbt_run >> dbt_test
│   ├── .env.example
│   └── setup-airflow.ps1    # Automatise les étapes 2 à 5 du TP5
├── docs/
│   └── tp1-questions-reponses.md
└── requirements.txt
```

## TP couverts

- **TP1** — Azurite Blob Storage : création d'un mini Data Lake local, upload
  Python, partitionnement par date, historisation.
- **TP2** — Blob vers SQL : chargement idempotent des blobs JSON dans une
  table SQLite `stg_blob_files` (staging).
- **TP3** — dbt Analytics Engineering : modèle `analytics_messages`, tests
  de qualité (`unique`, `not_null`), documentation générée (`dbt docs`).
- **TP5** — Orchestration avec Airflow : DAG `dataops_pipeline` qui enchaîne
  `dbt run` puis `dbt test` dans les conteneurs Airflow (Docker Compose).

> Le TP4 n'a pas été fourni au moment de la reconstitution de ce dépôt ;
> le TP5 suppose la base `dataops.db` et le projet `dataops_dbt` déjà en
> place (TP1-TP3).

## Démarrage rapide (local, hors Airflow)

```powershell
py -m pip install -r requirements.txt
$env:AZURE_STORAGE_CONNECTION_STRING = "UseDevelopmentStorage=true"

py scripts/upload_blob.py          # TP1
py scripts/load_blob_to_sql.py     # TP2

# TP3 - copier dataops_dbt/profiles/profiles.local.yml.example vers
# ~/.dbt/profiles.yml, puis :
cd dataops_dbt
dbt run
dbt test
```

## Orchestration Airflow (TP5)

```powershell
cd airflow
.\setup-airflow.ps1
docker compose up airflow-init
docker compose up -d
docker compose exec airflow-scheduler airflow dags unpause dataops_pipeline
docker compose exec airflow-scheduler airflow dags trigger dataops_pipeline
```

Interface Airflow : http://localhost:8080 (identifiants par défaut
`airflow` / `airflow`).
