{{ config(materialized='view') }}
SELECT
    productoid,
    nombre,
    descripcion,
    precio,
    stock,
    categoriaid
FROM {{ source('raw', 'productos') }}
