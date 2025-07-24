{{ config(materialized='view') }}
SELECT
    o.ordenid,
    o.usuarioid,
    o.total,
    o.fechaorden,
    d.pais,
    d.provincia,
    d.ciudad
FROM {{ ref('stg_ordenes') }} o
LEFT JOIN {{ ref('stg_direcciones_envio') }} d
    ON o.usuarioid = d.usuarioid
