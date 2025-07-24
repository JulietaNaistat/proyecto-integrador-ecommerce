{{ config(materialized='view') }}
SELECT
    pais,
    provincia,
    ciudad,
    SUM(total) AS ingresos_totales
FROM {{ ref('int_ordenes_ubicacion') }}
GROUP BY pais, provincia, ciudad
