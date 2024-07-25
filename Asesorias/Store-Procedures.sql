--Store procedures

create table empleados (
	idempleado int identity(1,1),
	nombre varchar(20) not null,
	apellido1 varchar(20)not null,
	apellido2 varchar(20),
	salario money not null
);
go

create or alter proc spu_agregar_empleado 
@nombre1 varchar(20),
@apellido1 varchar(20),
@apellido2 varchar(20),
@salario money 
as
begin 
insert into empleado (nombre,apellido1, apellido2, salario)
values (@nombre, @apellido1, @apellido2, @salario)
end
go

--Ejecucion de Store Procedure
exec spu_agregar_empleado 'Cesar', 'Augusto', 'Cabrera', 5000;
go


--Segundo ejercicio SP
--Realizar un SP que muestre el total de las compras hechas por cada uno de mis clientes
use NORTHWND;
go

create or alter proc spu_consultar_comprasClientes
@anioInicial int,
@anioFinal int
as
begin
select c.CompanyName as 'Cliente', sum(od.Quantity * od.UnitPrice) as total
from Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID
inner join [Order Details] as od
on o.OrderID = od.OrderID
inner join Products as p
on od.ProductID = p.ProductID
where YEAR(o.OrderDate) between @anioInicial and @anioFinal
group by CompanyName 
end
go

exec spu_consultar_comprasClientes 1996,1997
go



select c.CompanyName as 'Cliente', sum(od.Quantity * od.UnitPrice) as total
from Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID
inner join [Order Details] as od
on o.OrderID = od.OrderID
inner join Products as p
on od.ProductID = p.ProductID
group by CompanyName



--Calcular dias meses añios

select DATEDIFF (DAY, GETDATE(), Fechacontratacion)
from empleados
