{{ config(materialized='view') }}
SELECT
    pais,
    provincia,
    ciudad,
    COUNT(DISTINCT usuarioid) AS cantidad_usuarios
FROM {{ ref('stg_direcciones_envio') }}
GROUP BY pais, provincia, ciudad
