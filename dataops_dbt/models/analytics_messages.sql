-- Couche analytique : ne garde que les messages exploitables issus du staging.
SELECT
    source_file,
    message
FROM {{ source('staging', 'stg_blob_files') }}
WHERE message IS NOT NULL
