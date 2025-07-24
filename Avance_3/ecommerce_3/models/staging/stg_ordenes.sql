{{ config(materialized='view') }}
SELECT
    ordenid,
    usuarioid,
    fechaorden,
    total,
    estado
FROM {{ source('raw', 'ordenes') }}
