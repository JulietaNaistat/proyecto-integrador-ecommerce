{{ config(materialized='view') }}
SELECT
    ordenmetodoid,
    ordenid,
    metodopagoid,
    montopagado
FROM {{ source('raw', 'ordenes_metodospago') }}
