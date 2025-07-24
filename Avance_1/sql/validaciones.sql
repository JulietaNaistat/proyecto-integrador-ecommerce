-- DETECTAR INCONSISTENCIAS EN LOS DATOS CON SQL 

-- Lista de validaciones lógicas, de formato y de integridad referencial. 
-- Estas últimas no serían del todo necesarias por la misma definicion del modelo de datos, 
-- que evita por ejemplo insertar valores con referencias huerfanas.

------ VALIDACION DE NEGOCIO -----

-- Validar precios base contra precios unitarios de ordenes. 
-- Resultado: Hay una variación muy acentuada de precios incoherentes entre sí que podrían indicar problemas en los datos originales.
SELECT 
	detalle_ordenes.ordenid,
    productos.nombre AS nombre_producto,
    productos.precio AS precio_base,
    detalle_ordenes.cantidad AS cantidad,
    detalle_ordenes.preciounitario AS precio_en_orden,
    detalle_ordenes.preciounitario / detalle_ordenes.cantidad as precio_real
FROM 
    productos
LEFT JOIN 
    detalle_ordenes ON productos.productoid = detalle_ordenes.productoid
ORDER BY productos.nombre


------ VALIDACIÓN FORMATOS INVÁLIDOS --------
-- Validaciones de integridad referencial para todas las FKs.
-- Emails con formato inválido
-- Resultado: Hay muchos emails con espacios y formato inválido. Se podría validar desde el formulario que el email no contenta espacio ni caracteres inadecuados. 
SELECT * FROM Usuarios
WHERE Email !~* '^[A-Za-z0-9áéíóúÁÉÍÓÚñÑüÜ._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'

-- DNI con menos de 6 dígitos o caracteres no numéricos
SELECT * FROM Usuarios
WHERE DNI !~ '^[0-9]{6,}$';

-- Código postal con caracteres inválidos
SELECT * FROM Direcciones_Envio
WHERE CodigoPostal IS NOT NULL AND CodigoPostal !~ '^[A-Za-z0-9\-]{4,10}$';

-- Monto negativo o cero en historial de pagos
SELECT * FROM Historial_Pagos
WHERE Monto <= 0;

-- Cantidad inválida en carrito
SELECT * FROM Carrito
WHERE Cantidad <= 0;

-- Calificación fuera del rango permitido
SELECT * FROM Resenas_Productos
WHERE Calificacion < 1 OR Calificacion > 5;

---- VALIDACION DE PKS Y CLAVES FORÁNEAS -----
-- Valida NULL y duplicados en todas las PKS

---- PKS -----
-- Usuarios
SELECT * FROM Usuarios WHERE UsuarioID IS NULL;
SELECT UsuarioID, COUNT(*) FROM Usuarios GROUP BY UsuarioID HAVING COUNT(*) > 1;

-- Categorias
SELECT * FROM Categorias WHERE CategoriaID IS NULL;
SELECT CategoriaID, COUNT(*) FROM Categorias GROUP BY CategoriaID HAVING COUNT(*) > 1;

-- Productos
SELECT * FROM Productos WHERE ProductoID IS NULL;
SELECT ProductoID, COUNT(*) FROM Productos GROUP BY ProductoID HAVING COUNT(*) > 1;

-- Ordenes
SELECT * FROM Ordenes WHERE OrdenID IS NULL;
SELECT OrdenID, COUNT(*) FROM Ordenes GROUP BY OrdenID HAVING COUNT(*) > 1;

-- Detalle_Ordenes
SELECT * FROM Detalle_Ordenes WHERE DetalleID IS NULL;
SELECT DetalleID, COUNT(*) FROM Detalle_Ordenes GROUP BY DetalleID HAVING COUNT(*) > 1;

-- Direcciones_Envio
SELECT * FROM Direcciones_Envio WHERE DireccionID IS NULL;
SELECT DireccionID, COUNT(*) FROM Direcciones_Envio GROUP BY DireccionID HAVING COUNT(*) > 1;

-- Carrito
SELECT * FROM Carrito WHERE CarritoID IS NULL;
SELECT CarritoID, COUNT(*) FROM Carrito GROUP BY CarritoID HAVING COUNT(*) > 1;

-- Metodos_Pago
SELECT * FROM Metodos_Pago WHERE MetodoPagoID IS NULL;
SELECT MetodoPagoID, COUNT(*) FROM Metodos_Pago GROUP BY MetodoPagoID HAVING COUNT(*) > 1;

-- Ordenes_MetodosPago
SELECT * FROM Ordenes_MetodosPago WHERE OrdenMetodoID IS NULL;
SELECT OrdenMetodoID, COUNT(*) FROM Ordenes_MetodosPago GROUP BY OrdenMetodoID HAVING COUNT(*) > 1;

-- Resenas_Productos
SELECT * FROM Resenas_Productos WHERE ReseñaID IS NULL;
SELECT ReseñaID, COUNT(*) FROM Resenas_Productos GROUP BY ReseñaID HAVING COUNT(*) > 1;

-- Historial_Pagos
SELECT * FROM Historial_Pagos WHERE PagoID IS NULL;
SELECT PagoID, COUNT(*) FROM Historial_Pagos GROUP BY PagoID HAVING COUNT(*) > 1;

---- FKS -----
-- Productos ---> Categorias
SELECT * FROM Productos 
WHERE CategoriaID IS NOT NULL AND CategoriaID NOT IN (SELECT CategoriaID FROM Categorias);

-- Ordenes ---> Usuarios
SELECT * FROM Ordenes 
WHERE UsuarioID IS NOT NULL AND UsuarioID NOT IN (SELECT UsuarioID FROM Usuarios);

-- Detalle_Ordenes ---> Ordenes
SELECT * FROM Detalle_Ordenes 
WHERE OrdenID IS NOT NULL AND OrdenID NOT IN (SELECT OrdenID FROM Ordenes);

-- Detalle_Ordenes ---> Productos
SELECT * FROM Detalle_Ordenes 
WHERE ProductoID IS NOT NULL AND ProductoID NOT IN (SELECT ProductoID FROM Productos);

-- Direcciones_Envio ---> Usuarios
SELECT * FROM Direcciones_Envio 
WHERE UsuarioID IS NOT NULL AND UsuarioID NOT IN (SELECT UsuarioID FROM Usuarios);

-- Carrito ---> Usuarios
SELECT * FROM Carrito 
WHERE UsuarioID IS NOT NULL AND UsuarioID NOT IN (SELECT UsuarioID FROM Usuarios);

-- Carrito ---> Productos
SELECT * FROM Carrito 
WHERE ProductoID IS NOT NULL AND ProductoID NOT IN (SELECT ProductoID FROM Productos);

-- Ordenes_MetodosPago ---> Ordenes
SELECT * FROM Ordenes_MetodosPago 
WHERE OrdenID IS NOT NULL AND OrdenID NOT IN (SELECT OrdenID FROM Ordenes);

-- Ordenes_MetodosPago ---> Metodos_Pago
SELECT * FROM Ordenes_MetodosPago 
WHERE MetodoPagoID IS NOT NULL AND MetodoPagoID NOT IN (SELECT MetodoPagoID FROM Metodos_Pago);

-- Resenas_Productos ---> Usuarios
SELECT * FROM Resenas_Productos 
WHERE UsuarioID IS NOT NULL AND UsuarioID NOT IN (SELECT UsuarioID FROM Usuarios);

-- Resenas_Productos ---> Productos
SELECT * FROM Resenas_Productos 
WHERE ProductoID IS NOT NULL AND ProductoID NOT IN (SELECT ProductoID FROM Productos);

-- Historial_Pagos ---> Ordenes
SELECT * FROM Historial_Pagos 
WHERE OrdenID IS NOT NULL AND OrdenID NOT IN (SELECT OrdenID FROM Ordenes);

-- Historial_Pagos ---> Metodos_Pago
SELECT * FROM Historial_Pagos 
WHERE MetodoPagoID IS NOT NULL AND MetodoPagoID NOT IN (SELECT MetodoPagoID FROM Metodos_Pago);
