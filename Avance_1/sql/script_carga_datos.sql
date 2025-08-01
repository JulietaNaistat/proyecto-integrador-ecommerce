-- Cambios en el archivo DDL propuesto para adaptar a PostgreSQL

-- Crear base de datos
CREATE DATABASE "EcommerceDB";


-- Tabla: Usuarios
CREATE TABLE Usuarios (
    UsuarioID SERIAL PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    DNI VARCHAR(20) UNIQUE NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Contraseña VARCHAR(255) NOT NULL,
    FechaRegistro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla: Categorías
CREATE TABLE Categorias (
    CategoriaID SERIAL PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Descripcion VARCHAR(255)
);

-- Tabla: Productos
CREATE TABLE Productos (
    ProductoID SERIAL PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Descripcion TEXT,
    Precio DECIMAL(10,2) NOT NULL,
    Stock INT NOT NULL,
    CategoriaID INT REFERENCES Categorias(CategoriaID)
);

-- Tabla: Órdenes
CREATE TABLE Ordenes (
    OrdenID SERIAL PRIMARY KEY,
    UsuarioID INT REFERENCES Usuarios(UsuarioID),
    FechaOrden TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Total DECIMAL(10,2) NOT NULL,
    Estado VARCHAR(50) DEFAULT 'Pendiente'
);

-- Tabla: Detalle de Órdenes
CREATE TABLE Detalle_Ordenes (
    DetalleID SERIAL PRIMARY KEY,
    OrdenID INT REFERENCES Ordenes(OrdenID),
    ProductoID INT REFERENCES Productos(ProductoID),
    Cantidad INT NOT NULL,
    PrecioUnitario DECIMAL(10,2) NOT NULL
);

-- Tabla: Direcciones de Envío
CREATE TABLE Direcciones_Envio (
    DireccionID SERIAL PRIMARY KEY,
    UsuarioID INT REFERENCES Usuarios(UsuarioID),
    Calle VARCHAR(255) NOT NULL,
    Ciudad VARCHAR(100) NOT NULL,
    Departamento VARCHAR(100),
    Provincia VARCHAR(100),
    Distrito VARCHAR(100),
    Estado VARCHAR(100),
    CodigoPostal VARCHAR(20),
    Pais VARCHAR(100) NOT NULL
);

-- Tabla: Carrito de Compras
CREATE TABLE Carrito (
    CarritoID SERIAL PRIMARY KEY,
    UsuarioID INT REFERENCES Usuarios(UsuarioID),
    ProductoID INT REFERENCES Productos(ProductoID),
    Cantidad INT NOT NULL,
    FechaAgregado TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla: Métodos de Pago
CREATE TABLE Metodos_Pago (
    MetodoPagoID SERIAL PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Descripcion VARCHAR(255)
);

-- Tabla: Ordenes Métodos de Pago
CREATE TABLE Ordenes_MetodosPago (
    OrdenMetodoID SERIAL PRIMARY KEY,
    OrdenID INT REFERENCES Ordenes(OrdenID),
    MetodoPagoID INT REFERENCES MetodosPago(MetodoPagoID),
    MontoPagado DECIMAL(10,2) NOT NULL
);

-- Tabla: Reseñas de Productos
CREATE TABLE Resenas_Productos (
    ReseñaID SERIAL PRIMARY KEY,
    UsuarioID INT REFERENCES Usuarios(UsuarioID),
    ProductoID INT REFERENCES Productos(ProductoID),
    Calificacion INT CHECK (Calificacion >= 1 AND Calificacion <= 5),
    Comentario TEXT,
    Fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla: Historial de Pagos
CREATE TABLE Historial_Pagos (
    PagoID SERIAL PRIMARY KEY,
    OrdenID INT REFERENCES Ordenes(OrdenID),
    MetodoPagoID INT REFERENCES MetodosPago(MetodoPagoID),
    Monto DECIMAL(10,2) NOT NULL,
    FechaPago TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    EstadoPago VARCHAR(50) DEFAULT 'Procesando'
);