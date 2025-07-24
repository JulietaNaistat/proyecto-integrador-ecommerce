{{ config(materialized='view') }}
SELECT
    metodopagoid,
    nombre,
    descripcion
FROM {{ source('raw', 'metodos_pago') }}
