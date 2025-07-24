-- models/stg_bookings.sql
{{ config(materialized='view') }}
SELECT
    usuarioid,
    nombre,
    apellido,
    dni,
    email,
    contraseña,
    fecharegistro
FROM {{ source('raw', 'usuarios') }}