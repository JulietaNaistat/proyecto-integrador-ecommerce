{{ config(materialized='view') }}
SELECT
    reseñaid,
    usuarioid,
    productoid,
    calificacion,
    comentario,
    fecha
FROM {{ source('raw', 'resenas_productos') }}
