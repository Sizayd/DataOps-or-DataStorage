<#
    TP5 - Installation d'Apache Airflow avec Docker Compose.
    A executer depuis le dossier airflow/ (cd airflow avant de lancer ce script).

    Reproduit les etapes 2 a 5 du TP5 :
      - creation des sous-dossiers dags/logs/plugins/config
      - telechargement du docker-compose.yaml officiel Airflow
      - creation du fichier .env (AIRFLOW_UID + dependances dbt)
      - ajout du montage du projet parent dans les conteneurs Airflow
#>

New-Item -ItemType Directory -Force -Path dags, logs, plugins, config | Out-Null

if (-not (Test-Path "docker-compose.yaml")) {
    curl.exe -LfO "https://airflow.apache.org/docs/apache-airflow/stable/docker-compose.yaml"
}

Copy-Item -Path ".env.example" -Destination ".env" -Force
Get-Content ".env"

# Monte le projet parent (dataops_dbt, database, scripts, .dbt) dans les
# conteneurs Airflow, sous /opt/airflow/project - indispensable pour que
# dbt puisse lire/ecrire la base SQLite et le profil Docker.
$composePath = "docker-compose.yaml"
$marker = '${AIRFLOW_PROJ_DIR:-.}/plugins:/opt/airflow/plugins'
$mountLine = "  - ..:/opt/airflow/project"

$content = Get-Content $composePath -Raw
if ($content -notmatch [regex]::Escape($mountLine)) {
    $content = $content -replace [regex]::Escape($marker), "$marker`n$mountLine"
    Set-Content -Path $composePath -Value $content
    Write-Host "Montage /opt/airflow/project ajoute a $composePath"
} else {
    Write-Host "Montage /opt/airflow/project deja present."
}

Write-Host ""
Write-Host "Etapes suivantes :"
Write-Host "  docker compose up airflow-init"
Write-Host "  docker compose up -d"
