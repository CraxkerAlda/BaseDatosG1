--Consultas avanzadas 
--Como se hace un diagrama en Azure Tarea

SELECT c.CategoryName as 'Nombre de Categoria', 
P.ProductName as 'Nombre Producto', 
P.UnitPrice as 'Precio', 
P.UnitsInStock as 'Existencia'
FROM
Categories as C
inner join Products as P
on C.CategoryID = P.CategoryID
where CategoryName in ('Beverages', 'Produce')

USE NORTHWND;

--Seleccionar todas las ordenes que fueroon emitidas por los 
--empleados Nancy Davolio, Anne Dodsworth y Andrew Fuller

SELECT * FROM Orders
WHERE EmployeeID = 1 
or EmployeeID = 2
or EmployeeID =9 

SELECT * FROM Orders
WHERE EmployeeID in (1,2,9);

--Seleccionar todas las ordenes dividiendolo la fecha de orden en, año, mes y dias
SELECT OrderDate as 'Fecha de orden',
YEAR(OrderDate) as 'Año'
FROM Orders

SELECT OrderDate as 'Fecha de orden',
YEAR(OrderDate) as 'Año'
FROM Orders

--Seleccionar todos los nombres de los empleados
SELECT concat(FirstName, ' ', LastName) as 'Nombre completo'
from Employees

--Seleccionar todos los productos donde la existencia sea mayor o igual a 40
-- y el precio sea menor a 19

SELECT ProductName as 'Nombre Producto',
UnitPrice as 'Precio',
UnitsInStock as 'Existencia'
FROM Products
where UnitsInStock >= 40
and UnitPrice < 19;

--Seleccionar todas las ordenes realizadas de Abril a Agosto de 1996
SELECT OrderDate, CustomerID, EmployeeID, OrderID 
FROM Orders
WHERE OrderDate >= '1996-04-01' AND OrderDate <= '1996-08-31'

SELECT OrderDate, CustomerID, EmployeeID, OrderID 
FROM Orders
WHERE OrderDate BETWEEN '1996-04-01' and '1996-08-31'

--Seleccionar todas las ordenes entre 1996 y 1998
SELECT OrderDate, CustomerID, EmployeeID, OrderID 
FROM Orders
WHERE OrderDate BETWEEN '1996-01-01' and '1998-12-31'

SELECT * from Orders
WHERE YEAR(OrderDate) BETWEEN '1996' and '1998'


--Seleccionar todas las ordenes de 1996 y 1999
SELECT * from Orders
WHERE YEAR(OrderDate) in ('1996', '1999')


--Seleccionar todos los productos que comiencen por  C
SELECT * FROM Products
where ProductName LIKE 'c%';

--Seleccionar todos los productos que terminen con s
SELECT * FROM Products
WHERE ProductName LIKE '%s'

--seleccionar los productos que contengan la palabra no
SELECT * FROM Products
WHERE ProductName LIKE '%no%'

--Seleccionas todos los productos que contengan las letras a o n
SELECT * FROM Products
WHERE ProductName LIKE '%a%' or ProductName LIKE '%n%';

--Seleccionar todos los productos que comiencen entre la letra a y n
SELECT * FROM Products
WHERE ProductName LIKE 'a%' or ProductName LIKE 'n%';

SELECT * FROM Products
WHERE ProductName LIKE '[A-N]%'

--Seleccionar todas las ordenes que fueroon emitidas por los 
--empleados Nancy Davolio, Anne Dodsworth y Andrew Fuller haciendo un inner join

SELECT o.OrderID as 'Numero de Orden',
o.OrderDate as 'Fecha de Orden',
CONCAT(FirstName, ' ', LastName) as 'Nombre empeado'
from 
Employees as e
INNER JOIN
Orders AS o 
on o.EmployeeID = e.EmployeeID;

create DATABASE pruebaxyz;
use pruebaxyz;

--Crear las tablas mediante una consulta con cero registros

SELECT top 0 *
into pruebaxyz.dbo.products2
from NORTHWND.dbo.Products;

SELECT * from products2

-- Agregar un constraint a la tabla products2
alter table products2 
add CONSTRAINT pk_products2
PRIMARY KEY(productid)

drop constraint 

--Llenar una tabla a partir de una consulta

INSERT into pruebaxyz.dbo.products2(ProductName, SupplierID,
CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder,
ReorderLevel, Discontinued)
SELECT ProductName, SupplierID,
CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder,
ReorderLevel, Discontinued 
FROM NORTHWND.dbo.Products;

SELECT * FROM Products;


-- Ejercicio 1: Obtener el nombre del cliente y el nombre del empleado
-- del representante de ventas de cada pedido.

-- Nombre cliente (Customers)
-- Nombre del Empleado (Employees)
-- Pedidos (Orders)

USE NORTHWND;

SELECT o.customersId, o.Employees, o.Ordersid, o.orderdate 
FROM 
orders as 0;

SELECT c.CompanyName as 'Nombre cliente',
CONCAT(e.FirstName, ' ', e.LastName) as 'Nombre del Empleado',
o.OrderDate, o.OrderID
from Customers as c
INNER join 
Orders as o
on o.CustomerID = c.CustomerID
INNER join Employees as e
on o.EmployeeID = e.EmployeeID
INNER join [Order Details] as od
on od.OrderID = o.OrderID
WHERE YEAR(OrderDate) in ('1996', '1998');


--Seeccionar cuantas ordenes se han realizado en 1996 y 1998
SELECT COUNT(*) as 'Total de Ordenes'
from Customers as c
INNER join 
Orders as o
on o.CustomerID = c.CustomerID
INNER join Employees as e
on o.EmployeeID = e.EmployeeID
INNER join [Order Details] as od
on od.OrderID = o.OrderID
WHERE YEAR(OrderDate) in ('1996', '1998');

--Ejercicio 2: Mostrar el nombre del producto, el nombre del proveedor y el precio unitario de cada producto.

select p.ProductName as 'Nombre Producto',
s.CompanyName as 'Nombre del precio',
p.UnitPrice as 'Precio Unitario'
from Products as p
INNER join Suppliers as s
on p.SupplierID = p.SupplierID



--Ejercicio 3: Listar el nombre del cliente, el ID del pedido y la fecha del pedido para cada pedido.
SELECT c.CompanyName as 'Nombre del cliente',
o.OrderID as 'ID Pedido',
o.OrderDate as 'Fecha Pedido'
from Customers as c 
inner join Orders as o 
on c.CustomerID = o.CustomerID

--Ejercicio 4: Obtener el nombre del empleado, el título del cargo y el departamento del empleado para cada empleado.
SELECT e.FirstName as 'nombre',
e.TitleOfCourtesy as 'cargo',
e.Title as 'departamento' 
from Employees as e

--Ejercicio 5: Mostrar el nombre del proveedor, el nombre del contacto y el teléfono del contacto para cada proveedor.
SELECT s.CompanyName,
s.ContactName,
s.Phone
from Suppliers as s

--Ejercicio 6: Listar el nombre del producto, la categoría del producto y el nombre del proveedor para cada producto.
SELECT p.ProductName,
c.CategoryName,
s.CompanyName
from Products as p 
INNER join Categories as c 
on p.CategoryID = c.CategoryID
INNER join Suppliers as s 
on p.SupplierID = s.SupplierID

--Ejercicio 7: Obtener el nombre del cliente, el ID del pedido, el nombre del producto y la cantidad del producto para cada detalle del pedido.
SELECT c.CompanyName,
o.OrderID,
p.ProductName,
od.Quantity
from Customers as c 
inner join Orders as o 
on c.CustomerID = o.CustomerID
INNER join [Order Details] as od 
on o.OrderID = od.OrderID
INNER join Products as p 
on od.ProductID = p.ProductID

--Ejercicio 8: Obtener el nombre del empleado, el nombre del territorio y la región del territorio para cada empleado que tiene asignado un territorio.
SELECT e.FirstName ,
t.TerritoryDescription,
r.RegionDescription
from Employees as e
INNER join EmployeeTerritories as et 
on e.EmployeeID = et.EmployeeID
INNER join Territories as t 
on et.TerritoryID = t.TerritoryID
INNER join Region as r 
on t.RegionID = r.RegionID

--Ejercicio 9: Mostrar el nombre del cliente, el nombre del transportista y el nombre del país del transportista para cada pedido enviado por un transportista.
SELECT c.CompanyName,
o.ShipName,
o.ShipCountry
from Customers as c
INNER join Orders as o 
on c.CustomerID = o.CustomerID

--Ejercicio 10: Obtener el nombre del producto, el nombre de la categoría y la descripción de la categoría para cada producto que pertenece a una categoría.
SELECT p.ProductName,
c.CategoryName,
c.[Description]
from Products as p
INNER join Categories as c 
on p.CategoryID = c.CategoryID

--Ejercicio 11: Selecconar el total de ordenes hechas por cada uno de los proveedores
SELECT s.CompanyName as 'Proveedor', COUNT(*) as 'NUmero de ordenes'
from Suppliers as s
INNER join Products as p 
on s.SupplierID = p.SupplierID
INNER join [Order Details] as od
on od.ProductID = p.ProductID
GROUP BY CompanyName;

--Ejercicio 12: Seleccionar el total de dinero que he vendido por proveedor del primer trismestre de 1996

SELECT s.CompanyName as 'Proveedor', sum(od.UnitPrice * od.Quantity) as 'Total de ventas'
from Suppliers as s 
INNER JOIN Products as p 
on s.SupplierID = p.SupplierID
INNER join [Order Details] as od
on od.ProductID = p.ProductID
INNER join Orders as o 
on o.OrderID = od.OrderID
where o.OrderDate BETWEEN '1996-09-01' and '1996-12-31'
GROUP by s.CompanyName
ORDER by 'Total de ventas' DESC


--Ejercicio 13: Seleccionar el total de dinero vendido por categoria

SELECT c.CategoryName as 'Categoria', sum(UnitPrice) as 'Precio'
from Categories as c
INNER join Products as p 
on p.CategoryID = c.CategoryID
GROUP by CategoryName;

SELECT c.CategoryName,
sum(od.Quantity * od.UnitPrice) as 'Total de ventas'
from [Order Details] as od
INNER join Products as p 
on od.ProductID = p.ProductID
INNER JOIN Categories as c 
on c.CategoryID = p.CategoryID
GROUP by c.CategoryName
ORDER by 2 DESC

--Ejercicio 14: Seleccionar el total de dinero vendido por categoria y dentro por producto 

SELECT c.CategoryName as 'Nombre de la categoria',
p.ProductName as 'Producto',
SUM(od.Quantity * od.UnitPrice) as 'Total'
FROM [Order Details] as [od]
INNER join Products as p 
on od.ProductID = p.ProductID
INNER JOIN Categories as c 
on c.CategoryID = p.CategoryID
GROUP by c.CategoryName, p.ProductName
ORDER by 1 ASC;


