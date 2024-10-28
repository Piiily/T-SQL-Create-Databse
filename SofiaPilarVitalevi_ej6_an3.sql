USE master
GO

CREATE DATABASE Ejercicio6_ANEXO3
GO

USE Ejercicio6_ANEXO3 
GO

/*DROP TABLE Clientes
GO
DROP Table Cuentas
GO
DROP TABLE Facturas
GO
DROP TABLE DetalleFacturas
GO
DROP TABLE Articulos
GO
DROP TABLE Proveedores
GO*/

CREATE Table Proveedores
(
CodProveedor_prov int IDENTITY(1000,1) NOT NULL,
RazonSocial_prov varchar(30) NULL,
Direccion_prov varchar(30) NULL,
Ciudad_prov varchar(30) NULL,
Provincia_prov varchar(30) NULL,
CUIT_prov char(11) NOT NULL,
Telefono_prov varchar(13) NULL,
Contacto_prov varchar(30) NULL,
Web_prov varchar(50) NULL,
Email_prov varchar(30)NULL,
CONSTRAINT PK_Proveedores PRIMARY KEY (CodProveedor_prov),
CONSTRAINT UK_Proveedores_CUIT UNIQUE (CUIT_prov)
)
GO

CREATE Table Articulos
(
CodProveedor_art int NOT NULL,
CodArticulo_art int IDENTITY(1,1) NOT NULL,
Descripción_art varchar(50) NULL,
Stock_art int DEFAULT 0 NOT NULL CHECK (Stock_art >=0),
PrecioUnitario_art money DEFAULT 0 NOT NULL CHECK (PrecioUnitario_art >=0),
CONSTRAINT PK_Articulos PRIMARY KEY (CodProveedor_art, CodArticulo_art),
CONSTRAINT FK_Articulos_Proveedores FOREIGN KEY (CodProveedor_art) REFERENCES Proveedores(CodProveedor_prov)
)
GO


CREATE Table Clientes
(
DNI_Cli char(8) NOT NULL,
Nombre_Cli varchar(20) NULL,
Apellido_Cli varchar(20) NULL,
Direccion_Cli varchar(30) NULL,
Telefono_Cli varchar(30) NULL,
CONSTRAINT PK_Clientes PRIMARY KEY (DNI_Cli)
)
GO

CREATE Table Cuentas
(
CodCuenta_Cu int IDENTITY(100000,1) NOT NULL,
DNI_Cu char(8) NOT NULL,
LimiteCuenta_Cu money NOT NULL CHECK (LimiteCuenta_Cu >=0),
SaldoCuenta_Cu money NOT NULL CHECK (SaldoCuenta_Cu >=0),
CONSTRAINT PK_Cuentas PRIMARY KEY (CodCuenta_Cu),
CONSTRAINT FK_Cuentas_Clientes FOREIGN KEY (DNI_Cu) REFERENCES Clientes(DNI_Cli)
)
GO

CREATE Table Facturas
(
CodFactura_Fa int IDENTITY(10000,1) NOT NULL,
CodCuentaCliente_Fa int NOT NULL,
TotalFactura_Fa money NOT NULL CHECK (TotalFactura_Fa >=0),
FechaFactura_Fa varchar(10) NOT NULL,
CONSTRAINT PK_Facturas PRIMARY KEY (CodFactura_Fa),
CONSTRAINT FK_Facturas_Cuentas FOREIGN KEY (CodCuentaCliente_Fa) REFERENCES Cuentas(CodCuenta_Cu)
)
GO

CREATE Table DetalleFacturas
(
CodFactura_DF int NOT NULL,
CodProveedor_DF int NOT NULL,
CodArticulo_DF int NOT NULL,
Cantidad_DF int NOT NULL CHECK (Cantidad_DF >=1),
PrecioUnitario_DF money NOT NULL CHECK (PrecioUnitario_DF >=0),
CONSTRAINT PK_DetalleFacturas PRIMARY KEY (CodFactura_DF, CodProveedor_DF, CodArticulo_DF),
CONSTRAINT FK_DetalleFacturas_Articulos FOREIGN KEY (CodProveedor_DF, CodArticulo_DF) REFERENCES Articulos(CodProveedor_art, CodArticulo_art),
CONSTRAINT FK_DetalleFacturas_Facturas FOREIGN KEY (CodFactura_DF) REFERENCES Facturas(CodFactura_Fa)
)
GO

INSERT INTO Proveedores (RazonSocial_prov, Direccion_prov, Ciudad_prov, 
Provincia_prov, CUIT_prov, Telefono_prov, Contacto_prov, Web_prov, Email_prov)
SELECT 'Patricios Cars', NULL, 'CABA', 'BsAs', 1234567890, NULL, NULL, NULL, NULL UNION
SELECT 'Cinemark papia', NULL, 'CORRIENTES', 'CORRIENTES', 54203948657, NULL, NULL, NULL, NULL UNION
SELECT 'Pastelería Marta', NULL, 'La Plata', 'BsAs', 48263947152, NULL, NULL, NULL, NULL UNION
SELECT 'Ferretería Claudio', NULL, 'Tigre', 'BsAs', 94827361832, NULL, NULL, NULL, NULL UNION
SELECT 'Frutillita', NULL, 'Tigre', 'BsAs', 4567891233, NULL, NULL, NULL, NULL
GO

INSERT INTO Articulos(CodProveedor_art, Descripción_art, Stock_art, PrecioUnitario_art)
SELECT 1000, 'Aceite 15w40 autos', 45, 30000 UNION
SELECT 1001, 'Cubre Volante Rosa Peluche', 23, 10000 UNION
SELECT 1002, 'Lapicera Bic Negra', 300, 1200 UNION
SELECT 1003, 'Agenda 2025 Rosa', 45, 9800 UNION
SELECT 1004, 'Afiche verde 1mx1m', 100, 1000 UNION
SELECT 1004, 'Balde de pochoclos grande', 1000, 2000 
GO

INSERT INTO Clientes(DNI_Cli, Nombre_Cli, Apellido_Cli, Telefono_Cli)
SELECT 12345678, 'Carmina', 'Sanchez', 112345678 UNION
SELECT 47654321, 'Daniel', 'Perez', 118745867 UNION
SELECT 34001923, 'Marcela', 'Iglesias', 1100876433 UNION
SELECT 29008710, 'Tobías', 'Carrizo', 1189002301 UNION
SELECT 30406887, 'Alejandro', 'Zempla', 1190765340 
GO

INSERT INTO Cuentas(DNI_Cu, Limitecuenta_Cu, SaldoCuenta_Cu)
SELECT 12345678, 150000, 120000 UNION
SELECT 12345678, 400000, 250000 UNION
SELECT 47654321, 700000, 300450 UNION
SELECT 34001923, 1000000, 567005 UNION
SELECT 29008710, 350000, 15000 UNION
SELECT 30406887, 500000, 340897 UNION
SELECT 30406887, 250000, 10000
GO

INSERT INTO Facturas(CodCuentaCliente_Fa, TotalFactura_Fa, FechaFactura_Fa)
SELECT 100000, 100000, 16-10-2024 UNION
SELECT 100001, 5000, 04-10-2024 UNION
SELECT 100002, 15000, 01-10-2024 UNION
SELECT 100003, 65000, 07-10-2024 UNION
SELECT 100004, 23500, 10-10-2024
GO

INSERT INTO DetalleFacturas(CodFactura_DF, CodProveedor_DF, CodArticulo_DF, Cantidad_DF, PrecioUnitario_DF)
SELECT 10001, 1000, 1, 2, 30000 UNION
SELECT 10002, 1000, 1, 1, 10000 UNION
SELECT 10003, 1002, 3, 3, 1000 UNION
SELECT 10004, 1001, 2, 4, 2000 UNION
SELECT 10005, 1002, 3, 2, 1200 UNION
SELECT 10001, 1004, 5, 1, 10000 UNION
SELECT 10001, 1004, 6, 2, 1200
GO

/*Realice un procedimiento almacenado que devuelva los artículos mayores de 
una determinada cantidad en stock.*/

CREATE PROCEDURE Punto1
@STOCK int
AS
SELECT CodArticulo_art AS Articulo, Stock_art AS Stock
FROM Articulos
WHERE Stock_art > @stock
GO

EXEC Punto1 @STOCK=100
GO

/*Informe la razón social del proveedor, el artículo y la inversión hasta el 
momento en stock (stock * precio unitario) de un artículo determinado. Cree 
procedimiento almacenado. */
CREATE PROCEDURE Punto2
@CODARTICULO char(8)
AS
SELECT Proveedores.RazonSocial_prov AS RazonSocial, Articulos.Descripción_art AS Articulo, 
Articulos.Stock_art*Articulos.PrecioUnitario_art AS Inversion
FROM Proveedores
INNER JOIN Articulos
ON Articulos.CodProveedor_art = Proveedores.CodProveedor_prov
WHERE Articulos.CodArticulo_art = @CODARTICULO
GO

EXEC Punto2 @CODARTICULO='2'
GO

/*Informe nombre y apellido en un solo campo llamado “nombre completo” de 
los clientes que realizaron una compra de una cantidad mayor a 100 unidades 
de un artículo. Cree procedimiento almacenado.*/
CREATE PROCEDURE Punto3
@ARTICULO char(8)
AS
SELECT Clientes.Nombre_Cli + Clientes.Apellido_Cli AS NombreCompleto
FROM Clientes
INNER JOIN Cuentas ON Clientes.DNI_Cli = Cuentas.DNI_Cu
INNER JOIN Facturas ON Cuentas.CodCuenta_Cu = Facturas.CodCuentaCliente_Fa
INNER JOIN DetalleFacturas ON Facturas.CodFactura_Fa = DetalleFacturas.CodFactura_DF
WHERE DetalleFacturas.CodArticulo_DF = @ARTICULO
GO

EXEC Punto3 @ARTICULO = '2'
GO

/*Crear un procedimiento almacenado con cualquier nombre y cualquier 
selección de cualquier tabla y elimínelo desde una consulta utilizando la 
sentencia correspondiente.*/
CREATE PROCEDURE Punto4
@CUALQUIERA int
AS
SELECT Articulos.CodArticulo_art AS Articulo
FROM Articulos
GO

DROP PROCEDURE Punto4
GO

/*Crear una tabla llamada “TablaDePrueba” con tres campos nchar de 8 no 
nulos: Dni, nombre y apellido. El campo Dni será clave */
CREATE TABLE TablaDePrueba
(
DNI_tp nchar (8) NOT NULL,
Nombre nchar(8) NOT NULL,
Apellido nchar (8) NOT NULL,
CONSTRAINT PK_TABLADEPRUEBA PRIMARY KEY (DNI_tp)
)
GO

/*Insertar un registro en la tabla anterior con Dni = 12345, nombre = Ariel y 
apellido = Herrera*/
INSERT INTO TablaDePrueba(DNI_tp, Nombre, Apellido)
VALUES('12345', 'Ariel', 'Herrera')
GO

/*----------------------------------Anexo 2---------------------------------------------
Utilizando la misma base de datos, agregue dos tablas para registrar pedidos de 
artículos que se realicen a los proveedores, donde se almacene la cantidad, la 
fecha, el estado y otros datos que considere necesarios.*/

CREATE TABLE PedidosProv
(
CodPedido_PP int IDENTITY(1000,1) NOT NULL,
CodProveedor_PP int NOT NULL,
TotalPedido_PP money NOT NULL DEFAULT 0 CHECK (TotalPedido_PP >=0),
FechaPedido_PP datetime NOT NULL,
CONSTRAINT PK_PedidosProv PRIMARY KEY (CodPedido_PP),
CONSTRAINT FK_PedidosProv_Proveedores FOREIGN KEY (CodProveedor_PP) REFERENCES Proveedores(CodProveedor_prov)
)
GO

CREATE TABLE DetallePedidos
(
CodPedido_DP int NOT NULL,
CodProveedor_DP int NOT NULL,
CodArticulo_DP int NOT NULL,
Cantidad_DP int NOT NULL CHECK (Cantidad_DP >=1),
PrecioUnitario_DP money NOT NULL CHECK (PrecioUnitario_DP >=0),
CONSTRAINT PK_DetallePedidos PRIMARY KEY (CodPedido_DP, CodProveedor_DP, CodArticulo_DP),
CONSTRAINT FK_DetallePedidos_PedidosProv FOREIGN KEY (CodPedido_DP) REFERENCES PedidosProv(CodPedido_PP),
CONSTRAINT FK_DetallePedidos_Articulos FOREIGN KEY (CodProveedor_DP, CodArticulo_DP) REFERENCES Articulos(CodProveedor_art, CodArticulo_art)
)
GO

/*Cargue las tablas con datos*/
INSERT INTO PedidosProv(CodProveedor_PP, TotalPedido_PP, FechaPedido_PP)
SELECT 1000, 10000, '2024/05/16' UNION
SELECT 1001, 23000, '2024-05-04' UNION
SELECT 1002, 2000, '2024-05-01' UNION
SELECT 1003, 55000, '2024-05-07' UNION
SELECT 1004, 5500, '2024-05-10'
GO

INSERT INTO DetallePedidos(CodPedido_DP, CodProveedor_DP, CodArticulo_DP, Cantidad_DP, PrecioUnitario_DP)
SELECT 1004, 1000, 1, 1000, 30000 UNION
SELECT 1005, 1001, 2, 500, 1200 UNION
SELECT 1006, 1002, 3, 1300, 2000 UNION
SELECT 1007, 1003, 4, 750, 10000 UNION
SELECT 1008, 1004, 5, 180, 10000
GO

/*Realice una actualización del stock de un determinado artículo a una cantidad 
cualquiera desde una consulta*/
UPDATE Articulos SET Stock_art=2000 WHERE  CodArticulo_art=1
GO

/*Marque un determinado pedido como cumplido*/
ALTER TABLE PedidosProv
ADD EstadoPedido_PP VARCHAR(11) NOT NULL DEFAULT 'NoCumplido' CHECK (EstadoPedido_PP = 'NoCumplido' OR EstadoPedido_PP = 'Cumplido')
GO

UPDATE PedidosProv SET EstadoPedido_PP='Cumplido' WHERE CodPedido_PP=1004
GO

/*----------------------------------Anexo 3---------------------------------------------
 Informe las tres primeras letras de la descripción de un artículo y su cantidad en stock.
*/

CREATE PROCEDURE Punto1_3
@ARTICULO CHAR(8)
AS
SELECT left((SELECT Articulos.Descripción_art FROM Articulos WHERE Articulos.CodArticulo_art = @ARTICULO), 3)
GO

EXEC Punto1_3 @ARTICULO = '2'
GO

/*Consulte la existencia de la tabla pedidos, si no existiera créela.*/
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE
TABLE_NAME='PedidosProv')
BEGIN
 CREATE TABLE PedidosProv
(
CodPedido_PP int IDENTITY(1000,1) NOT NULL,
CodProveedor_PP int NOT NULL,
TotalPedido_PP money NOT NULL DEFAULT 0 CHECK (TotalPedido_PP >=0),
FechaPedido_PP varchar(20) NOT NULL,
CONSTRAINT PK_PedidosProv PRIMARY KEY (CodPedido_PP),
CONSTRAINT FK_PedidosProv_Proveedores FOREIGN KEY (CodProveedor_PP) REFERENCES Proveedores(CodProveedor_prov)
)
END
GO

/*Cree un procedimiento almacenado que introduzca un registro en la tabla pedidos de 
cualquier artículo con la fecha del momento de la registración.*/
CREATE PROCEDURE AgregarRegistro
@COPROVEEDOR int,
@TOTALPEDIDO money
AS
BEGIN
INSERT INTO PedidosProv (CodProveedor_PP, TotalPedido_PP, FechaPedido_PP)
VALUES (@COPROVEEDOR, @TOTALPEDIDO, GETDATE());
END
GO

EXEC AgregarRegistro @COPROVEEDOR = 1004, @TOTALPEDIDO = 10000;
GO

/*Realice una consulta que informe todos los proveedores con razón social en mayúscula y 
los contactos en minúsculas. */

SELECT CodProveedor_prov AS Codigo, UPPER(RazonSocial_prov), LOWER(Contacto_prov)
FROM Proveedores

/* Crear un trigger en la tabla Detalle de ventas o Detalle de Facturas llamado SUMATOTAL 
que por cada artículo agregado al detalle multiplique el precio unitario por la cantidad y 
sume el resultado al total en la tabla Facturas o Ventas*/
CREATE TRIGGER SUMATOTAL
ON DetalleFacturas
AFTER INSERT
AS
BEGIN
SET NOCOUNT ON;
UPDATE Facturas SET TotalFactura_Fa = TotalFactura_Fa + (SELECT Cantidad_DF * PrecioUnitario_DF FROM inserted)
WHERE CodFactura_Fa = (SELECT CodFactura_DF FROM inserted)
END

INSERT INTO DetalleFacturas (CodFactura_DF, CodProveedor_DF, CodArticulo_DF, Cantidad_DF, PrecioUnitario_DF)
SELECT 10001, 1002, 3, 3, 1000
GO

/*Crear un trigger en la tabla Detalle de ventas o Detalle de Facturas llamado BAJASTOCK 
que por cada artículo agregado al detalle descuente la cantidad en la tabla correspondiente 
que lleve el stock*/
DROP TRIGGER BAJASTOCK
GO

CREATE TRIGGER BAJASTOCK
ON DetalleFacturas
AFTER INSERT
AS
BEGIN
SET NOCOUNT ON;

UPDATE Articulos
SET Stock_art = Stock_art - i.Cantidad_DF
FROM Articulos a
JOIN inserted i ON a.CodArticulo_art = i.CodArticulo_DF;
END
GO

INSERT INTO DetalleFacturas (CodFactura_DF, CodProveedor_DF, CodArticulo_DF, Cantidad_DF, PrecioUnitario_DF)
VALUES (10003, 1000, 1, 5, 3000);
GO
