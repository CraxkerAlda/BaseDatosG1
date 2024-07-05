DROP DATABASE pruebajoins


CREATE DATABASE pruebajoinsg1;

use pruebajoinsg1;

CREATE table proveedor (
    provid int not null IDENTITY (1,1),
    nombre VARCHAR(50) not null,
    limite_credito money not null,
    CONSTRAINT pk_proveedor
    PRIMARY key (provid),
    CONSTRAINT unico_combrepro
    UNIQUE(nombre)
)

create table productos (
    productid int not null IDENTITY(1,1),
    nombre VARCHAR(50) not null,
    precio money not null,
    existencia int not null,
    proveedor int,
    CONSTRAINT pk_producto
    PRIMARY key (productid),
    constraint unico_nombre_proveedor
    UNIQUE(nombre),
    constraint fk_proveedor_producto
    FOREIGN key (proveedor)
    REFERENCES proveedor(provid)
)

--Agregar registros a las ablas proveedor y producto

INSERT into proveedor (nombre, limite_credito)
VALUES
('Proveedor1', 5000),
('Proveedor2', 6778),
('Proveedor3', 6788),
('Proveedor4', 5677),
('Proveedor5', 6666);

SELECT * FROM proveedor

INSERT into productos (nombre, precio, existencia, proveedor)
VALUES
('Producto1', 56, 34, 1),
('Producto2', 56.56, 12, 1),
('Producto3', 45.6, 33, 2),
('Producto4', 22.34, 666, 3);

select * from productos

SELECT * from
proveedor as p 
INNER join productos as pr 
on pr.proveedor = p.provid


--Consulta co tablas deribadas
SELECT s.CompanyName as 'Proveedor', 
sum(od.UnitPrice * od.Quantity) as 'Total de ventas'
from (
    select companyname, suppliers from Suppliers
) as s 
INNER JOIN (
    select productid, supplierid from products
) as p 
on s.SupplierID = p.SupplierID
INNER join (
    select orderid, 
) as od
on od.ProductID = p.ProductID
INNER join (

) as o 
on o.OrderID = od.OrderID
where o.OrderDate BETWEEN '1996-09-01' and '1996-12-31'
GROUP by s.CompanyName
ORDER by 'Total de ventas' DESC



--- Consulta mas eficiente
use NORTHWND

select c.CategoryID, p.ProductName, p.UnitsInStock, p.Discontinued
FROM (
    select categoryname, categoryid from categories
) as c
INNER join 
(
    select productname, UnitsInStock, CategoryID, UnitPrice, Discontinued from Products
) as p 
on c.CategoryID = p.CategoryID


--Left Join
SELECT p.nombre
from 
proveedor as p left join productos as pr 
on pr.proveedor =p.provid


-- 1.-Crear dos tablas, una que se llame empleados y otra dmi_empleados