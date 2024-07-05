
use NORTHWND;

--Lenguaje SQL LMD
--Seleccionar todos los productos
select * from Products

--Seleccionas todas las categorias de productos
select * from Categories;

--seleccionar los proveedores
select * from Suppliers;

--seleccionar los clientes
select * from Customers;

--seleccionar los empleados
select * from Employees;

--seleccionar todos las paqueterias
select * from Shippers;

--seleccionar todas las ordenes
select * from Orders;

--seleccionar todos los detalles de ordenes
select * from [Order Details]

--Consultas Simples

--Proyeccion
select ProductID, ProductName, UnitsInStock, UnitPrice 
FROM Products;

--Alias de columna 
select ProductID AS NumeroProducto, ProductName AS 'Nombre Producto', UnitsInStock existencia, UnitPrice AS 'Precio' 
FROM Products;

--Alias de tablas

SELECT * from 
Products AS P, Categories AS c
WHERE c.CategoryID = P.CategoryID

--Campo Calculado
--sleccionar todos los procutis mostrando el id del prodcuto
--el nombre del producto, el precio y el importe 
select*, (UnitPrice * UnitsInStock) AS 'Importe' from Products;

select ProductID, ProductName, UnitsInStock, UnitPrice,
(UnitPrice * UnitsInStock) AS 'Importe' 
from Products;


select ProductID AS 'Numero Producto', 
ProductName AS 'Nombre del Producto', 
UnitsInStock AS 'Existencia', 
UnitPrice AS 'Precio',
(UnitPrice * UnitsInStock) AS 'Importe' 
from Products;

--Seleccionar las primeras 10 ordenes 
SELECT top 10 * from Orders;

-- Seleccionar todos los clie,ntes ordenados de forma ascendente por el país 
SELECT CustomerID as 'Numero de cliente',
CompanyName as 'Nombre del cliente', 
[address] as 'Direccion', 
City as 'Ciudad', 
Country as 'Pais' 
from Customers
ORDER by Country;

SELECT CustomerID as 'Numero de cliente',
CompanyName as 'Nombre del cliente', 
[address] as 'Direccion', 
City as 'Ciudad', 
Country as 'Pais' 
from Customers
ORDER by Country ASC;

SELECT CustomerID as 'Numero de cliente',
CompanyName as 'Nombre del cliente', 
[address] as 'Direccion', 
City as 'Ciudad', 
Country as 'Pais' 
from Customers
ORDER by 5 ASC;

--Seleccionar por alias
SELECT CustomerID as 'Numero de cliente',
CompanyName as 'Nombre del cliente', 
[address] as 'Direccion', 
City as 'Ciudad', 
Country as 'Pais' 
from Customers
ORDER by 'Pais' ASC;


--Seleccionar todos los clientes ordenados por pais de forma descendente 

SELECT CustomerID as 'Numero de cliente',
CompanyName as 'Nombre del cliente', 
[address] as 'Direccion', 
City as 'Ciudad', 
Country as 'Pais' 
from Customers
ORDER by Country;

SELECT CustomerID as 'Numero de cliente',
CompanyName as 'Nombre del cliente', 
[address] as 'Direccion', 
City as 'Ciudad', 
Country as 'Pais' 
from Customers
ORDER by Country DESC;

SELECT CustomerID as 'Numero de cliente',
CompanyName as 'Nombre del cliente', 
[address] as 'Direccion', 
City as 'Ciudad', 
Country as 'Pais' 
from Customers
ORDER by 5 DESC;

SELECT CustomerID as 'Numero de cliente',
CompanyName as 'Nombre del cliente', 
[address] as 'Direccion', 
City as 'Ciudad', 
Country as 'Pais' 
from Customers
ORDER by 'Pais' DESC;

--Selecciona todos los clientes ordenados de forma ascendente por pais y 
--dentro de cada pais ordenado por ciudad ordenado por forma descendente 

SELECT CustomerID, CompanyName, Country, City 
from Customers
ORDEr by Country, City desc 

--Operadores relacionales 
--(<,>, <=, ==, <>)

--Seleccionar los paises a los cuales se les ha enviado las ordenes 
SELECT * FROM Orders

SELECT distinct ShipCountry FROM Orders
ORDER by 1

--Seleccionar todas las ordenes enviadas a francia
SELECT * from Orders
where ShipCountry = 'France';

--Seleccionar todas las ordenes realizadas a Francia mostrando,
--el numero de orden, cliente al que se vendio, empleado que la realizo,
--el pais al que se envio, la ciudad a la que se envio 
select OrderID as 'Numeor de orden',
CustomerID as 'Cliente',
EmployeeID as 'Empleado',
ShipCountry as 'Pais',
ShipCity as 'Ciudad'
from Orders
where ShipCountry = 'France'

--Seleccionar las ordendes en dodne no se ha asignado una region de envio 
select OrderID as 'Numeor de orden',
CustomerID as 'Cliente',
EmployeeID as 'Empleado',
ShipCountry as 'Pais',
ShipCity as 'Ciudad',
ShipRegion as 'Region'
from Orders
where ShipRegion is NULL;

--seleccionar las ordenes en donde se ha asigando las ordenes de envio 
select OrderID as 'Numeor de orden',
CustomerID as 'Cliente',
EmployeeID as 'Empleado',
ShipCountry as 'Pais',
ShipCity as 'Ciudad',
ShipRegion as 'Region'
from Orders
where ShipRegion is not null;

--Seleccionar los productos con un precio mayor a 50 dolares
SELECT ProductName as 'Nombre del Producto',
UnitPrice as 'Precio'
FROM Products
where UnitPrice > 50;

--Seleccionar los empleados contratados despues del primero de enero de 1990
SELECT * from Employees
WHERE HireDate > '1990-01-01'

--Seleccionar los clientes que sean de alemania
select * FROM Customers
where Country = 'Germany'

--Mostrar los productos con una cantidad menor o igual a 100
select * from Products
where UnitsInStock <= 100

--Seleccionar todas las ordenes realizadas antes del primero de enero 
SELECT * from Orders
WHERE OrderDate < '1998-01-01'

--Seleccionas todas las ordenes realizadas por el empleado fuller
SELECT * From Orders
where EmployeeID = 2

--Seleccionar todas las ordenes, mostrando el nuemro de orden, 
--cliente y la fecha orden dividida en año, mes y dia 
SELECT OrderID, CustomerID, OrderDate, YEAR(OrderDate) as 'Años',
MONTH(OrderDate) as 'Mes', DAY(OrderDate) as 'Día'
From Orders

--Operadores Logicos 
--Seleccionar los productos con un precio mayor a 50 y con una cantidad menor o igual a 100
SELECT * FROM Products
WHERE UnitPrice > 50 and UnitsInStock <= 100

--Seleccionar todas las ordenes para francia y alemania 
SELECT * FROM Orders
where ShipCountry = 'France' or ShipCountry ='Germany'

SELECT * FROM Orders
WHERE ShipCountry in ('France', 'Germany')

--Seleccionar todas las ordenes para francia, alemania y mexico
SELECT * from Orders
WHERE ShipCountry in ('France', 'Germany', 'Mexico')
ORDER by ShipCountry DESC

