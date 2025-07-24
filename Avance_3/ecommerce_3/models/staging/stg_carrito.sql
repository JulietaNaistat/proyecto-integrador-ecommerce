{{ config(materialized='view') }}
SELECT
    carritoid,
    usuarioid,
    productoid,
    cantidad,
    fechaagregado
FROM {{ source('raw', 'carrito') }}
