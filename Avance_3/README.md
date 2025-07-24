
# Proyecto DBT: Análisis Regional de Ecommerce

Este proyecto DBT tiene como objetivo construir un modelo de datos escalable en dbt para analizar el rendimiento comercial por región en una plataforma de ecommerce.

---


## Conexión a la base de datos

Este proyecto dbt consume los datos desde una **base de datos externa ubicada en un contenedor de Docker**, fuera del contenedor donde se ejecuta dbt.  
La conexión se realiza mediante la configuración del archivo `profiles.yml`, apuntando al host del contenedor de la base de datos, lo que permite mantener una arquitectura desacoplada y escalable.


## Modelado de Datos

### 1. Modelos `stg_` (Staging)
- Se crearon como **vistas** (`materialized='view'`) para facilitar la transformación inicial de las tablas fuente.
- Idealmente, estas tablas deberían haberse materializado en un **nuevo esquema** para mejorar la performance y trazabilidad.
- Cada modelo `stg_` representa una tabla fuente con nombres estandarizados y sin transformaciones complejas.

### 2. Modelos `int_` (Intermedios)
- Combinan hechos y dimensiones para enriquecer los datos.
- Se diseñaron para responder preguntas de negocio como:
  - ¿Dónde están nuestros usuarios?
  - ¿Dónde se generan más órdenes e ingresos?
  - ¿Cuál es el ticket promedio por región?
  - ¿Qué tan bien convertimos usuarios en compradores?

### 3. Modelos `fct_` (Fact)
- Consolidan métricas clave por región y período.
- Ejemplos:
  - `fct_ticket_promedio_por_region`

---

## Tests de Calidad

Se ejecutaron tests en el archivo `schema.yml` para validar:

- **Llaves primarias**: `unique` y `not_null` en identificadores.
- **Llaves foráneas**: `not_null` en campos de relación.
- Validaciones adicionales en campos como `email`, `dni`, `precio`, `cantidad`.

---

## Objetivo de Negocio

Obtener insights sobre el **rendimiento comercial regional**, incluyendo:

- Distribución de usuarios por ubicación.
- Volumen de órdenes e ingresos por región.
- Ticket promedio y tasa de conversión por ciudad/provincia/país.

Estos datos permiten tomar decisiones estratégicas sobre campañas, logística y experiencia de usuario.

---

## Estructura del Proyecto

- `models/stg_`: Modelos staging desde fuentes externas.
- `models/int_`: Modelos intermedios con joins y enriquecimientos.
- `models/fct_`: Modelos fact con métricas agregadas.
- `models/schema.yml`: Tests y documentación de columnas.
- `models/sources.yml`: Definición de fuentes externas.

