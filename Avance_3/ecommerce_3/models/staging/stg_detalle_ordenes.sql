{{ config(materialized='view') }}
SELECT
    detalleid,
    ordenid,
    productoid,
    cantidad,
    preciounitario
FROM {{ source('raw', 'detalle_ordenes') }}
