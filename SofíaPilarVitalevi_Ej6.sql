USE master
GO

CREATE DATABASE Ejercicio6_corregido
GO

USE Ejercicio6_corregido
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
CodProveedor_prov char(5) NOT NULL,
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
CodProveedor_art char(5) NOT NULL,
CodArticulo_art char(8) NOT NULL,
Descripción_art varchar(50) NULL,
Srock_art int NOT NULL,
PrecioUnitario money NOT NULL,
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
CodCuenta_Cu char(10) NOT NULL,
DNI_Cu char(8) NOT NULL,
Limitecuenta_Cu money NOT NULL,
SaldoCuenta_Cu money NOT NULL,
CONSTRAINT PK_Cuentas PRIMARY KEY (CodCuenta_Cu),
CONSTRAINT FK_Cuentas_Clientes FOREIGN KEY (DNI_Cu) REFERENCES Clientes(DNI_Cli),
CONSTRAINT UK_Cuentas_DNI UNIQUE (DNI_Cu)
)
GO

ALTER TABLE Cuentas
DROP CONSTRAINT UK_Cuentas_DNI

CREATE Table Facturas
(
CodFactura_Fa char(6) NOT NULL,
CodCuentaCliente_Fa char(10) NOT NULL,
TotalFactura_Fa money NOT NULL,
FechaFactura_Fa date NOT NULL,
CONSTRAINT PK_Facturas PRIMARY KEY (CodFactura_Fa),
CONSTRAINT FK_Facturas_Cuentas FOREIGN KEY (CodCuentaCliente_Fa) REFERENCES Cuentas(CodCuenta_Cu)
)
GO

CREATE Table Facturas
(
CodFactura_Fa char(6) NOT NULL,
CodCuentaCliente_Fa char(10) NOT NULL,
TotalFactura_Fa money NULL,
FechaFactura_Fa varchar(10) NOT NULL,
CONSTRAINT PK_Facturas PRIMARY KEY (CodFactura_Fa),
CONSTRAINT FK_Facturas_Cuentas FOREIGN KEY (CodCuentaCliente_Fa) REFERENCES Cuentas(CodCuenta_Cu)
)
GO

CREATE Table DetalleFacturas
(
CodFactura_DF char(6) NOT NULL,
CodProveedor_DF char(5) NOT NULL,
CodArticulo_DF char(8) NOT NULL,
Cantidad_DF int NOT NULL,
PrecioUnitario_DF money NOT NULL,
CONSTRAINT PK_DetalleFacturas PRIMARY KEY (CodFactura_DF, CodProveedor_DF, CodArticulo_DF),
CONSTRAINT FK_DetalleFacturas_Articulos FOREIGN KEY (CodProveedor_DF, CodArticulo_DF) REFERENCES Articulos(CodProveedor_art, CodArticulo_art),
CONSTRAINT FK_DetalleFacturas_Facturas FOREIGN KEY (CodFactura_DF) REFERENCES Facturas(CodFactura_Fa)
)
GO

INSERT INTO Proveedores(CodProveedor_prov, RazonSocial_prov, Direccion_prov, Ciudad_prov, 
Provincia_prov, CUIT_prov, Telefono_prov, Contacto_prov, Web_prov, Email_prov)
SELECT 00001, 'Patricios Cars', NULL, 'CABA', 'BsAs', 1234567890, NULL, NULL, NULL, NULL UNION
SELECT 00002, 'Cinemark papia', NULL, 'CORRIENTES', 'CORRIENTES', 54203948657, NULL, NULL, NULL, NULL UNION
SELECT 00003, 'Pastelería Marta', NULL, 'La Plata', 'BsAs', 48263947152, NULL, NULL, NULL, NULL UNION
SELECT 00004, 'Ferretería Claudio', NULL, 'Tigre', 'BsAs', 94827361832, NULL, NULL, NULL, NULL
GO

INSERT INTO Articulos(CodProveedor_art, CodArticulo_art, Descripción_art, Srock_art, PrecioUnitario)
SELECT 00001, 00001223, 'Aceite 15w40 autos', 45, 30000 UNION
SELECT 00001, 00001224, 'Cubre Volante Rosa Peluche', 23, 10000 UNION
SELECT 00003, 00156000, 'Lapicera Bic Negra', 300, 1200 UNION
SELECT 00003, 00003458, 'Agenda 2025 Rosa', 45, 9800 UNION
SELECT 00003, 00000341, 'Afiche verde 1mx1m', 100, 1000 UNION
SELECT 00002, 12300000, 'Balde de pochoclos grande', 1000, 2000 
GO

INSERT INTO Clientes(DNI_Cli, Nombre_Cli, Apellido_Cli, Telefono_Cli)
SELECT 12345678, 'Carmina', 'Sanchez', 112345678 UNION
SELECT 47654321, 'Daniel', 'Perez', 118745867 UNION
SELECT 34001923, 'Marcela', 'Iglesias', 1100876433 UNION
SELECT 29008710, 'Tobías', 'Carrizo', 1189002301 UNION
SELECT 30406887, 'Alejandro', 'Zempla', 1190765340 
GO

INSERT INTO Cuentas(CodCuenta_Cu, DNI_Cu, Limitecuenta_Cu, SaldoCuenta_Cu)
SELECT 0001234567, 12345678, 150000, 120000 UNION
SELECT 0001238942, 12345678, 400000, 250000 UNION
SELECT 0000481734, 47654321, 700000, 300450 UNION
SELECT 0000089123, 34001923, 1000000, 567005 UNION
SELECT 0004502394, 29008710, 350000, 15000 UNION
SELECT 0000891638, 30406887, 500000, 340897 UNION
SELECT 0000891639, 30406887, 250000, 10000
GO

INSERT INTO Facturas(CodFactura_Fa, CodCuentaCliente_Fa, TotalFactura_Fa, FechaFactura_Fa)
SELECT 000123, 0001234567, NULL, 16-10-2024 UNION
SELECT 000124, 0001238942, NULL, 04-10-2024 UNION
SELECT 000345, 0004502394, NULL, 01-10-2024 UNION
SELECT 000450, 0004502394, NULL, 07-10-2024 UNION
SELECT 000700, 0000891638, NULL, 10-10-2024
GO

INSERT INTO DetalleFacturas(CodFactura_DF, CodProveedor_DF, CodArticulo_DF, Cantidad_DF, PrecioUnitario_DF)
SELECT 000123, 00001, 00001223, 2, 30000 UNION
SELECT 000123, 00001, 00001224, 1, 10000 UNION
SELECT 000345, 00003, 00000341, 3, 1000 UNION
SELECT 000450, 00002, 12300000, 4, 2000 UNION
SELECT 000124, 00003, 00156000, 2, 1200 UNION
SELECT 000700, 00003, 00003458, 1, 10000 UNION
SELECT 000700, 00003, 00156000, 2, 1200
GO

/*Realice un procedimiento almacenado que devuelva los artículos mayores de 
una determinada cantidad en stock.*/

CREATE PROCEDURE Punto1
@STOCK int
AS
SELECT CodArticulo_art AS Articulo, Srock_art AS Stock
FROM Articulos
WHERE Srock_art > @stock
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
Articulos.Srock_art*Articulos.PrecioUnitario AS Inversion
FROM Proveedores
INNER JOIN Articulos
ON Articulos.CodProveedor_art = Proveedores.CodProveedor_prov
WHERE Articulos.CodArticulo_art = @CODARTICULO
GO

EXEC Punto2 @CODARTICULO='00156000'
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

EXEC Punto3 @ARTICULO = '00156000'
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