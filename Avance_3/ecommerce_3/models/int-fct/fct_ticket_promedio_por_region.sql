{{ config(materialized='table') }}
SELECT
    pais,
    provincia,
    ciudad,
    COUNT(ordenid) AS cantidad_ordenes,
    SUM(total) AS ingresos_totales,
    AVG(total) AS ticket_promedio,
    TO_CHAR(fechaorden, 'MM - YYYY') AS periodo
FROM {{ ref('int_ordenes_ubicacion') }}
GROUP BY pais, provincia, ciudad, periodo
