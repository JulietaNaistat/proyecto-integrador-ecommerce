{{ config(materialized='view') }}
WITH usuarios_por_region AS (
    SELECT
        usuarioid,
        pais,
        provincia,
        ciudad
    FROM {{ ref('stg_direcciones_envio') }}
),
usuarios_con_orden AS (
    SELECT DISTINCT usuarioid
    FROM {{ ref('stg_ordenes') }}
)
SELECT
    u.pais,
    u.provincia,
    u.ciudad,
    COUNT(DISTINCT u.usuarioid) AS usuarios_registrados,
    COUNT(DISTINCT CASE WHEN o.usuarioid IS NOT NULL THEN u.usuarioid END) AS usuarios_con_orden,
    ROUND(
        COUNT(DISTINCT CASE WHEN o.usuarioid IS NOT NULL THEN u.usuarioid END) * 1.0 /
        NULLIF(COUNT(DISTINCT u.usuarioid), 0), 4
    ) AS tasa_conversion
FROM usuarios_por_region u
LEFT JOIN usuarios_con_orden o
    ON u.usuarioid = o.usuarioid
GROUP BY u.pais, u.provincia, u.ciudad
