
use NORTHWND;

--Vista (Objeto de la base de datos - SQL-LDD)

drop view vista_ventas;


create or alter view vista_ventas
as

SELECT c.CustomerID as 'ClaveCliente',
c.CompanyName as 'Cliente',
CONCAT(e.FirstName, ' ', e.LastName) as 'Nombre',
o.OrderDate as 'Fechadelaorden', DATEPART(YEAR, o.OrderDate) as 'Añodecompra',
DATENAME(mm, o.OrderDate) as 'MesdeCompra',
DATEPART(QUARTER, o.OrderDate) as 'Trimestre',
UPPER(p.ProductName) as 'NombredelProducto',
od.Quantity as 'CantidadVendida',
od.UnitPrice as 'PreciodeVenta',
p.SupplierID as 'ProveedorId'
from 
Orders as o
INNER JOIN Customers as C
on o.CustomerID = c.CustomerID
inner join Employees as e 
on e.EmployeeID = o.EmployeeID
INNER join [Order Details] as od 
on od.OrderID = o.OrderID
inner join Products as p 
on p.ProductID = od.ProductID
SELECT ClaveCliente, Nombre, NombredelProducto,Fechadelaorden, 
(CantidadVendida * PreciodeVenta) as 'Importe'
from vista_ventas
WHERE NombredelProducto = 'CHAI'
and (CantidadVendida * PreciodeVenta) > 600
AND DATEPART(YEAR, Fechadelaorden) = 1996

--inner join con la tabla suppliers
SELECT * from 
vista_ventas as vv 
inner join Suppliers as s 
on s.SupplierID = vv.ProveedorId;


-- consultas con Case
SELECT ProductName, UnitPrice, UnitsInStock, Discontinued,
Disponibilidad =case Discontinued
when 0 then 'No disponible' 
when 1 then 'Disponible'
else 'No existente'
end 
from Products 

SELECT ProductName, UnitsInStock, UnitPrice,
case 
when UnitPrice >= 1 and UnitPrice <18 then 'Producto Barato'
when UnitPrice >= 18 and UnitPrice <=50 then 'Producto medio Barato'
when UnitPrice BETWEEN 51 and 100 then 'Producto Caro'
else 'Carisiímo'
end as 'Categoria Precios '
from Products
where ProductID in (29, 38)



use AdventureWorks2019;

select BusinessEntityID,
SalariedFlag
from  HumanResources.Employee
order by 
case SalariedFlag
when 1 then BusinessEntityID
end DESC,
case 
when SalariedFlag = 0 then BusinessEntityID
end ASC;

select BusinessEntityID,
LastName, TerritoryName,
CountryRegionName
from Sales.vSalesPerson
where TerritoryName is not NULL
order by 
case CountryRegionName
when 'United States' then TerritoryName
else CountryRegionName
end desc;


--Funcion IS NULL
select v.AccountNumber,
v.Name,
ISNULL(v.PurchasingWebServiceURL, 'NO URL') as 'PurchasWebServicesURL'
from Purchasing.Vendor as v;

select v.AccountNumber,
v.Name,
case 
when v.PurchasingWebServiceURL IS NULL then 'NO URL'
end
as 'PurchasWebServicesURL'
from Purchasing.Vendor as v;



--
use AdventureWorks2019;

--Funcion IIF
SELECT iif (1 = 1, 'VERDADERO', 'FALSO') as 'Resultado'

create VIEW vista_genero 
as
SELECT e.LoginID, e.JobTitle, iif(e.Gender = 'F', 'MUJER', 'Hombre') as 'Sexo'
from HumanResources.Employee as e;

select lower(JobTitle) as 'Titulo' 
from vista_genero
WHERE Sexo = 'Mujer' 


--Merge

SELECT OBJECT_ID(N'tempdb..#StudentsC1')

IF OBJECT_ID (N'tempdb..#StudentsC1') is not NULL
begin
    drop table #StudentsC1;
end

CREATE TABLE #StudentsC1(
    StudentID       INT
    ,StudentName    VARCHAR(50)
    ,StudentStatus  BIT
);

INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(1,'Axel Romero',1)
INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(2,'Sofía Mora',1)
INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(3,'Rogelio Rojas',0)
INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(4,'Mariana Rosas',1)
INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(5,'Roman Zavaleta',1)


IF OBJECT_ID(N'tempdb..#StudentsC2') is not NULL
begin
drop table #StudentsC2
END


CREATE TABLE #StudentsC2(
    StudentID       INT
    ,StudentName    VARCHAR(50)
    ,StudentStatus  BIT
);


INSERT INTO #StudentsC2(StudentID, StudentName, StudentStatus) VALUES(1,'Axel Romero Rendón',1)
INSERT INTO #StudentsC2(StudentID, StudentName, StudentStatus) VALUES(2,'Sofía Mora Ríos',0)
INSERT INTO #StudentsC2(StudentID, StudentName, StudentStatus) VALUES(6,'Mario Gonzalez Pae',1)
INSERT INTO #StudentsC2(StudentID, StudentName, StudentStatus) VALUES(7,'Alberto García Morales',1)

select * from #StudentsC1
SELECT * from #StudentsC2

SELECT * from 
#StudentsC1 as s1
INNER join #StudentsC2 as s2
on s1.StudentID = s2.StudentID

insert into #StudentsC2(StudentID, StudentName, StudentStatus)
SELECT s1.StudentID, s1.StudentName, s1.StudentStatus 
from 
#StudentsC1 as s1
LEFT join #StudentsC2 as s2
on s1.StudentID = s2.StudentID
WHERE s2.StudentID is NULL

SELECT * from 
#StudentsC1 as s1
RIGHT join #StudentsC2 as s2
on s1.StudentID = s2.StudentID


UPDATE s2
set s2.StudentName = s1.StudentName,
    s2.StudentStatus = s1.StudentStatus
from 
#StudentsC1 as s1
INNER join #StudentsC2 as s2
on s1.StudentID = s2.StudentID
