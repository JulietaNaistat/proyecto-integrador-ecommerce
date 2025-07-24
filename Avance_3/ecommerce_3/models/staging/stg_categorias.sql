{{ config(materialized='view') }}
SELECT
    categoriaid,
    nombre,
    descripcion
FROM {{ source('raw', 'categorias') }}
