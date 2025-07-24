{{ config(materialized='view') }}
SELECT
    direccionid,
    usuarioid,
    calle,
    ciudad,
    departamento,
    provincia,
    distrito,
    estado,
    codigopostal,
    pais
FROM {{ source('raw', 'direcciones_envio') }}
