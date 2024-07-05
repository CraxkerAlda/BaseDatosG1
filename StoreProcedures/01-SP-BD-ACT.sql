create database etlempresa;
 
use NORTHWND;
select * from Customers

create table Cliente (
	clienteid int not null identity (1,1),
	clientebk nchar(5) not null,
	empresa nvarchar(40) not null,
	ciudad nvarchar(15) not null,
	region nvarchar (15) not null,
	pais nvarchar(15) not null,
	constraint pk_cliente
	primary key (clienteid)
);

select * from Cliente

select CustomerID, UPPER(CompanyName) as 'Nombre', UPPER(City) as 'Ciudad', ISNULL(Region, 'SIN REGION') as Region,UPPER(Country) as 'Pais'
from NORTHWND.dbo.Customers as nc

--Cargar registros tabla Cliente
create proc sp_etl_carga_cliente
as
begin
insert into etlempresa.dbo.Cliente
select CustomerID, UPPER(CompanyName) as 'Nombre', UPPER(City) as 'Ciudad', 
ISNULL(nc.Region, 'SIN REGION') as Region,UPPER(Country) as 'Pais' 
from NORTHWND.dbo.Customers as nc
left join etlempresa.dbo.Cliente etle
on nc.CustomerID = etle.clientebk
where etle.clientebk is null;
update cl
set
cl.Empresa = UPPER(c.CompanyName),
cl.Ciudad = upper(c.City),
cl.Pais = upper(c.Country),
cl.Region = upper(isnull(c.Region, 'Sin region'))
from NORTHWND.dbo.Customers as c
inner join etlempresa.dbo.Cliente as cl
on c.CustomerID = cl.clientebk
end


--Añadir o cambiar un registro
select * from NORTHWND.dbo.Customers
where CustomerID = 'CLIB1'

update NORTHWND.dbo.Customers
set CompanyName = 'pepsi'
where CustomerID = 'CLIB1'

truncate table etlempresa.dbo.Cliente
select * from NORTHWND.dbo.Products

drop table Producto;

--Tabla Producto
create table Producto (
	productoid int not null identity(1,1),
	productobk int not null,
	nombreProducto nchar(40) not null,
	categoria int not null,
	precio money not null,
	existencia smallint not null,
	descontinuado bit not null,
	constraint pk_producto
	primary key(productoid)
);

select * from Producto

select np.ProductID as 'productoid', np.ProductName as 'nombreProducto', np.CategoryID as 'categoria',
np.UnitPrice as 'precio', np.UnitsInStock as 'existencia', np.Discontinued as 'descontinuado'
from NORTHWND.dbo.Products as np
left join etlempresa.dbo.Producto as etlp
on np.CategoryID = etlp.productobk


select pl.categoria, p.CategoryID, 
pl.descontinuado, p.Discontinued, 
pl.existencia, p.UnitsInStock, 
pl.nombreProducto, p.ProductName,
pl.precio, p.UnitPrice
from NORTHWND.dbo.Products as p
inner join etlempresa.dbo.Producto as pl
on p.ProductID = pl.productobk
go

--Cargar registros tabla Producto o Storage Procedure
create or alter proc sp_etl_carga_producto
as 
begin 
insert into etlempresa.dbo.Producto
select np.ProductID as 'productoid', np.ProductName as 'nombreProducto', np.CategoryID as 'categoria',
np.UnitPrice as 'precio', np.UnitsInStock as 'existencia', np.Discontinued as 'descontinuado'
from NORTHWND.dbo.Products as np
left join etlempresa.dbo.Producto as etlp
on np.CategoryID = etlp.productobk
update pl
set 
pl.categoria = p.CategoryID, 
pl.descontinuado =p.Discontinued, 
pl.existencia = p.UnitsInStock, 
pl.nombreProducto = p.ProductName,
pl.precio = p.UnitPrice
from etlempresa.dbo.Producto as pl
left join NORTHWND.dbo.Products as p
on p.ProductID = pl.productobk
end;
go

exec sp_etl_carga_producto
select * from Producto


--Tabla empleado
create table Empleado (
	empleadoid int not null identity(1,1),
	empleadobk nchar(5) not null, 
	nombreCompleto nvarchar(30) not null,
	ciudad nvarchar(15) not null,
	region nvarchar(15) not null,
	pais nvarchar(15) not null,
	constraint pk_empleado
	primary key(empleadoid)
);
go

select * from NORTHWND.dbo.Employees

select ne.EmployeeID as 'empleadoid', CONCAT(ne.FirstName, ' ', ne.LastName) as 'nombreCompleto',
ne.City as 'ciudad', ISNULL(ne.Region, 'SIN REGION') as 'region', ne.Country as 'pais'
from NORTHWND.dbo.Employees as ne
left join etlempresa.dbo.Empleado as etle
on ne.EmployeeID = etle.empleadoid
where etle.empleadobk is null
go


select el.ciudad, e.City,
el.nombreCompleto, CONCAT(e.FirstName, ' ', e.LastName),
el.pais, e.Country,
el.region, ISNULL(e.Region, 'SIN REGION')
from NORTHWND.dbo.Employees as e
inner join etlempresa.dbo.Empleado as el
on e.EmployeeID = el.empleadobk
go

create or alter proc sp_etl_carga_empleado
as 
begin
insert into etlempresa.dbo.Empleado
select ne.EmployeeID as 'empleadoid', CONCAT(ne.FirstName, ' ', ne.LastName) as 'nombreCompleto',
ne.City as 'ciudad', ISNULL(ne.Region, 'SIN REGION') as 'region', ne.Country as 'pais'
from NORTHWND.dbo.Employees as ne
left join etlempresa.dbo.Empleado as etle
on ne.EmployeeID = etle.empleadoid
where etle.empleadobk is null
update el
set 
el.ciudad = e.City,
el.nombreCompleto = CONCAT(e.FirstName, ' ', e.LastName),
el.pais = e.Country,
el.region = ISNULL(e.Region, 'SIN REGION')
from NORTHWND.dbo.Employees as e
inner join etlempresa.dbo.Empleado as el
on e.EmployeeID = el.empleadobk
end;
go

exec sp_etl_carga_empleado
select * from Empleado


--Tabla Proveedor
create table Proveedor (
	proveedorid int not null identity(1,1),
	proveedorbk nvarchar(5) not null,
	empresa nvarchar(40) not null,
	city nvarchar(15) not null,
	region nvarchar(15) not null,
	country nvarchar(15) not null,
	homePage ntext not null,
	constraint pk_proveedor
	primary key(proveedorid)
);

select * from NORTHWND.dbo.Suppliers

select ns.SupplierID as 'proveedorid', ns.CompanyName as 'empresa', ns.City, ISNULL(ns.Region, 'SIN REGION') as 'region',
ns.Country, ISNULL(ns.HomePage, 'Sin pagina Web') as 'homePage'
from NORTHWND.dbo.Suppliers as ns
left join etlempresa.dbo.Proveedor as etlp
on ns.SupplierID = etlp.proveedorid


select pl.city, s.City,
pl.country, s.Country,
pl.empresa, s.CompanyName,
pl.homePage, ISNULL(s.HomePage, 'Sin pagina Web'),
pl.region, ISNULL(s.Region, 'SIN REGION')
from NORTHWND.dbo.Suppliers as s
inner join etlempresa.dbo.Proveedor as pl
on s.SupplierID = pl.proveedorbk


create or alter proc sp_etl_carga_proveedor
as 
begin 
insert into etlempresa.dbo.Proveedor
select ns.SupplierID as 'proveedorid', ns.CompanyName as 'empresa', ns.City, ISNULL(ns.Region, 'SIN REGION') as 'region',
ns.Country, ISNULL(ns.HomePage, 'Sin pagina Web') as 'homePage'
from NORTHWND.dbo.Suppliers as ns
left join etlempresa.dbo.Proveedor as etlp
on ns.SupplierID = etlp.proveedorid
update pl
set
pl.city = s.City,
pl.country = s.Country,
pl.empresa = s.CompanyName,
pl.homePage = ISNULL(s.HomePage, 'Sin pagina Web'),
pl.region = ISNULL(s.Region, 'SIN REGION')
from NORTHWND.dbo.Suppliers as s
inner join etlempresa.dbo.Proveedor as pl
on s.SupplierID = pl.proveedorbk
end;

exec sp_etl_carga_proveedor;
select * from Proveedor

--Tabla Ventas 

create table Ventas (
	clienteid int not null,
	productoid int not null,
	empleadoid int not null,
	proveedorid int not null,
	cantidad int not null,
	precio int not null
	constraint fk_cliente_ventas
	foreign key(clienteid)
	references Cliente(clienteid),
	constraint fk_producto_ventas
	foreign key(productoid)
	references Producto(productoid),
	constraint fk_empleado_ventas
	foreign key(empleadoid)
	references Empleado(empleadoid),
	constraint fk_producto_ventas
	foreign key(proveedorid)
	references Proveedor(proveedorid)
);

