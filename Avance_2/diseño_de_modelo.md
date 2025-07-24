## Diseño de Base de Datos: 

### 1. Diseño Lógico

#### Entidades identificadas:
- **Usuario**: persona que se registra y compra.
- **Producto**: ítem disponible para la venta.
- **Categoría**: clasificación de productos.
- **Orden**: compra realizada por un usuario.
- **Detalle de orden**: productos incluidos en una orden.
- **Dirección de envío**: ubicación donde se entrega una orden.
- **Carrito**: productos que un usuario agrega antes de comprar.
- **Método de pago**: forma de pago utilizada.
- **Reseña de producto**: calificación y comentario de un usuario.
- **Historial de pago**: registro de pagos realizados.

#### Relaciones entre entidades:
- Un usuario puede tener muchas órdenes, reseñas, direcciones y carritos.
- Una orden puede tener muchos detalles de orden y pagos.
- Un producto puede pertenecer a una categoría y estar en muchas órdenes, carritos y reseñas.
- Un método de pago puede estar asociado a muchas órdenes y pagos.

---

### 2. Diseño Conceptual

#### Tablas y relaciones:

| Tabla                  | PK             | FK                                       | Relación                         |
|-----------------------|----------------|------------------------------------------|----------------------------------|
| `Usuarios`            | UsuarioID      | —                                        | 1:N con Órdenes, Carrito, etc.   |
| `Categorias`          | CategoriaID    | —                                        | 1:N con Productos                |
| `Productos`           | ProductoID     | CategoriaID → Categorias(CategoriaID)    | N:1 con Categorías               |
| `Ordenes`             | OrdenID        | UsuarioID → Usuarios(UsuarioID)          | N:1 con Usuarios                 |
| `Detalle_Ordenes`     | DetalleID      | OrdenID, ProductoID                      | N:1 con Ordenes y Productos      |
| `Direcciones_Envio`   | DireccionID    | UsuarioID → Usuarios(UsuarioID)          | N:1 con Usuarios                 |
| `Carrito`             | CarritoID      | UsuarioID, ProductoID                    | N:1 con Usuarios y Productos     |
| `Metodos_Pago`        | MetodoPagoID   | —                                        | 1:N con Ordenes_MetodosPago      |
| `Ordenes_MetodosPago` | OrdenMetodoID  | OrdenID, MetodoPagoID                    | N:1 con Ordenes y Metodos_Pago   |
| `Resenas_Productos`   | ReseñaID       | UsuarioID, ProductoID                    | N:1 con Usuarios y Productos     |
| `Historial_Pagos`     | PagoID         | OrdenID, MetodoPagoID                    | N:1 con Ordenes y Metodos_Pago   |

#### Tipos de relaciones:
- **1:N**: un usuario puede tener muchas órdenes, pero cada orden pertenece a un solo usuario.
- **N:M** (resueltas con tablas intermedias): por ejemplo, productos en órdenes → se resuelve con `Detalle_Ordenes`.

### Conclusión
Basado en el análisis previo y teniendo en cuenta que este modelo tiene:

- Jerarquías geográficas (pais, provincia, ciudad).
- Relaciones complejas (usuario → orden → detalle → producto).
- Posibles cambios históricos (SCD).
- Necesidad de integridad y trazabilidad y escalabilidad.

Se decidio usar un Schema Snowflake como modelo de datos.



