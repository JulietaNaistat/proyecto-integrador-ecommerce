# Proyecto Integrador: Datos para E-commerce

## Descripción

Este proyecto implementa una solución completa de ingeniería de datos para una empresa emergente de comercio electrónico. El objetivo es transformar datos dispersos en archivos CSV en un modelo de datos relacional y dimensional que facilite el análisis y la toma de decisiones empresariales.

## Tecnologías Utilizadas

- **Base de Datos**: PostgreSQL
- **Transformación de Datos**: DBT (Data Build Tool)
- **Containerización**: Docker & Docker Compose
- **Lenguajes**: SQL, Python
- **Análisis**: Jupyter Notebooks y ORM - SQL ALchemy
- **Modelado**: DBML (Database Markup Language)

## Estructura del Repositorio

```
proyecto-integrador-ecommerce/
├── Avance_1/                    # Carga y entendimiento de datos
│   ├── docker-compose.yml       # Configuración de PostgreSQL
│   ├── EcommerceDB_EDA_ORM.ipynb # Análisis exploratorio
│   └── sql/
│       ├── script_carga_datos.sql    # DDL y estructura de BD
│       └── validaciones.sql          # Validaciones de calidad
├── Avance_2/                    # Diseño del modelo dimensional
│   ├── diseño_de_modelo.md      # Documentación del diseño lógico
│   ├── ecommerce_schema.dbml    # Esquema en DBML
│   ├── ERD_ecommercedb.png      # Diagrama entidad-relación
│   └── scd_tipo2_usuarios.ipynb # Implementación SCD Tipo 2
├── Avance_3/                    # Implementación con DBT
│   ├── config/profiles.yml      # Configuración de conexión DBT
│   ├── docker_compose.yml       # Orquestación de contenedores
│   ├── dockerfile               # Imagen personalizada
│   └── ecommerce_3/             # Proyecto DBT
│       ├── models/
│       │   ├── staging/         # Modelos STG (vistas)
│       │   ├── int-fct/         # Modelos intermedios y hechos
│       │   ├── schema.yml       # Tests y documentación
│       │   └── sources.yml      # Definición de fuentes
│       └── [analyses, macros, tests, etc.]
├── Files/csv/                   # Datos fuente (11 archivos CSV)
└── requirements.txt             # Dependencias Python
```

---

## Avance 1: Carga y Entendimiento de Datos

**Configuración de Base de Datos PostgreSQL**
- Setup de contenedor Docker con PostgreSQL
- Creación de esquema relacional normalizado
- Carga de 11 archivos CSV con datos de e-commerce

**Exploración y Análisis de Calidad**
- Análisis exploratorio con Python ORM (`EcommerceDB_EDA_ORM.ipynb`)
- Detección de inconsistencias y evaluación de calidad de datos
- Identificación de llaves foráneas y atributos clave

### Archivos Relevantes
- `docker-compose.yml`: Configuración de PostgreSQL
- `sql/script_carga_datos.sql`: DDL completo con 11 tablas principales
- `EcommerceDB_EDA_ORM.ipynb`: Análisis exploratorio detallado

### Tablas Implementadas
1. **Usuarios** - Información de clientes registrados
2. **Categorías** - Clasificación de productos
3. **Productos** - Catálogo con precios y stock
4. **Órdenes** - Transacciones de compra
5. **Detalle_Órdenes** - Productos por orden
6. **Direcciones_Envío** - Ubicaciones de entrega
7. **Carrito** - Productos pendientes de compra
8. **Métodos_Pago** - Formas de pago disponibles
9. **Órdenes_MétodosPago** - Relación muchos a muchos
10. **Reseñas_Productos** - Calificaciones y comentarios
11. **Historial_Pagos** - Registro de transacciones

---

## Avance 2: Diseño del Modelo Dimensional

**Análisis de Requerimientos de Negocio**
- Identificación de hechos y dimensiones según metodología Kimball
- Definición de granularidad para cada tabla de hechos
- Mapeo de preguntas de negocio a métricas específicas

**Diseño Conceptual y Lógico**
- Modelo entidad-relación completo
- Implementación de Slowly Changing Dimensions (SCD)
- Justificación de decisiones de diseño

**Documentación Técnica**
- Diagrama ERD visual (`ERD_ecommercedb.png`)
- Esquema en DBML (`ecommerce_schema.dbml`)
- Documentación detallada en `diseño_de_modelo.md`

### Decisiones de Diseño
- **Granularidad**: Orden-Producto como nivel más detallado
- **SCD Tipo 2**: Implementado para tabla Usuarios para tracking histórico

### Dimensiones Identificadas
- **Dim_Usuario**: Información demográfica y de registro
- **Dim_Producto**: Catálogo con categorías y atributos
- **Dim_Ubicación**: Geografía para análisis regional
- **Dim_Método_Pago**: Formas de pago y características

### Hechos Identificados
- **Fct_Ventas**: Transacciones de venta con métricas
- **Fct_Pagos**: Historial de pagos y estados
- **Fct_Inventario**: Snapshots de stock por período

---

## Avance 3: Implementación con DBT

**Construcción del Modelo Físico**
- Implementación en DBT con arquitectura de capas
- Configuración de conexión externa a base de datos PostgreSQL
- Organización en staging, intermediate y fact layers

**Transformaciones y Modelado**
- 11 modelos staging (`stg_`) como vistas para transformación inicial
- 4 modelos intermedios (`int_`) para enriquecimiento de datos
- 1 modelo fact (`fct_`) para métricas agregadas por región

**Tests y Calidad de Datos**
- Tests de unicidad y nulidad en llaves primarias
- Validaciones de integridad referencial
- Documentación completa en `schema.yml`

### Arquitectura DBT Implementada

#### Capa Staging (`models/staging/`)
**Materialización**: Vistas (`materialized='view'`)
**Propósito**: Normalización inicial y renaming de columnas

- `stg_usuarios.sql` - Datos de clientes
- `stg_productos.sql` - Catálogo de productos  
- `stg_ordenes.sql` - Transacciones
- `stg_detalle_ordenes.sql` - Líneas de orden
- `stg_direcciones_envio.sql` - Ubicaciones
- `stg_carrito.sql` - Carritos de compra
- `stg_metodos_pago.sql` - Formas de pago
- `stg_ordenes_metodospago.sql` - Relación orden-pago
- `stg_resenas_productos.sql` - Reseñas
- `stg_historial_pagos.sql` - Historial de pagos
- `stg_categorias.sql` - Categorías

#### Capa Intermedia (`models/int-fct/`)
**Materialización**: Mixta (vistas y tablas)
**Propósito**: Joins complejos y enriquecimiento dimensional

- `int_usuarios_ubicacion.sql` - Usuarios con datos geográficos
- `int_ordenes_ubicacion.sql` - Órdenes enriquecidas con ubicación
- `int_ingresos_por_region.sql` - Agregación de ingresos regionales
- `int_conversion_por_region.sql` - Métricas de conversión por región

#### Capa de Hechos (`models/int-fct/`)
**Materialización**: Tablas (`materialized='table'`)
**Propósito**: Métricas de negocio agregadas y optimizadas

- `fct_ticket_promedio_por_region.sql` - KPI principal por región con:
  - Cantidad de órdenes por ubicación
  - Ingresos totales por región
  - Ticket promedio calculado
  - Agregación temporal por mes-año

### Configuración Técnica

#### Conexión a Base de Datos
```yaml
# profiles.yml
ecommerce_3:
  target: dev
  outputs:
    dev:
      type: postgres
      host: [docker_container_host]
      user: postgres
      password: [password]
      port: 5432
      dbname: EcommerceDB
      schema: public
```

#### Tests Implementados
- **Llaves Primarias**: `unique` + `not_null` en todos los IDs
- **Integridad Referencial**: `not_null` en foreign keys críticas
- **Validaciones de Negocio**: Campos como email, DNI, precios
- **Cobertura**: 100% de modelos staging con tests básicos

### Métricas de Negocio Disponibles

El modelo final permite responder preguntas como:

**Análisis Regional**:
- Distribución de usuarios por país/provincia/ciudad
- Volume de órdenes e ingresos por región  
- Ticket promedio por ubicación geográfica
- Tasa de conversión regional (usuarios vs compradores)

**KPIs Implementados**:
- **Ticket Promedio Regional**: `SUM(total) / COUNT(ordenes)` por ubicación
- **Ingresos por Región**: Agregación de ventas por geografía
- **Conversión Regional**: `COUNT(compradores) / COUNT(usuarios)` por región
- **Tendencias Temporales**: Análisis mes a mes por región



