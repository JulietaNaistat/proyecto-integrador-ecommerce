{{ config(materialized='view') }}
SELECT
    pagoid,
    ordenid,
    metodopagoid,
    monto,
    fechapago,
    estadopago
FROM {{ source('raw', 'historial_pagos') }}
