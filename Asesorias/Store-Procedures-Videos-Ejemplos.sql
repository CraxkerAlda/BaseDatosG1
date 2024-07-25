create database bodega;
go
 
use bodega
go

create table producto (
idprod char(7) primary key not null,
descripcion varchar(25),
existencia int,
precio decimal (10,2),
preciov decimal(10,2),
ganacia as preciov-precio,
check (preciov>precio)
);
go

create table pedido (
idpedido char(7),
idprod char(7),
cantidad int,
foreign key (idprod) references producto(idprod)
)
go

insert into producto values ('P1', 'Coca.Cola', 10, 5, 10)
insert into pedido values ('PD1','P1',5)
go

--Crear un SP que ingrese valores en la tabla Productos y debera verificar que
--el codigo y nombre del producto no exista para poder insertarlo, en caso que ya exista
--enviar un mensaje que diga 'ESTE PRODUCTO YA HA SIDO INGRESADO'

create or alter proc spu_insertar_product
@idProduc char(7),
@descrip char(7),
@existencia int,
@prec decimal (10,2),
@precv decimal (10,2)
as
begin
	declare @total int ---Contador de resultados

	select @total=COUNT(idprod) 
	from producto
	where idprod = @idProduc or descripcion = @descrip

	if(@total<1)--NO se encontraron resultados
	begin
		insert into producto 
		values (@idProduc,@descrip,@existencia,@prec,@precv)
	end
else
	begin
		print 'Este Producto ya ha sido insertado'
	end
end
go 

exec spu_insertar_product 'P2', 'Pecsi', 15, 20 ,30
go

select * from producto
go

--Ejercicio 2
-- Crear un SP que permita realizar un pedido en la tabla PEDIDO, este precedimiento
--debera verificar si el codigo del producto ingresado existe en la tabla PRODUCTO en 
-- caso de que no se encuentre debar mostrar un mensaje 'Este producto no existe ' ademas
--si la cantidad a pedir del prodcuto es mayor a la existencia del producto debera mostar
-- 'Existencia del producto insuficiente', En caso de que la cantidad a pedir sea menor o igual
--debera modificar actualizar wl valor de la exuiatencia del prodcutco


create or alter proc spu_insertar_pedido
@idpedido char(7),
@idproc char(7),
@cantidad int
as
begin
declare @total int 
declare @exist int
declare @nuevaCant int

select @total=COUNT(idpedido)  
from pedido
where idpedido = @idpedido

if(@total<1)
	begin
	select @total=COUNT(idprod)
	from producto
	where idprod = @idpedido
	if(@total>=1)
		begin 
			select @exist = existencia
			from producto
			where idprod = @idpedido
			set @nuevaCant = @exist-@cantidad
			if(@nuevaCant>=0)
				begin 
					insert into pedido
					values(@idpedido, @idproc, @cantidad)
					update producto
					set
					existencia = @nuevaCant 
					where idprod = idprod
				end
			else 
				begin
					print 'EXISTENCIA DEL PRODUCTO INSUFICIENTE'
				end
			end
		else 
			begin
				print 'Este producto no existe'
			end
	end
else 
	begin
		print 'Ya existe un pedido con ese ID'
	end
end
go 

exec spu_insertar_pedido 'PD1', 'P3', 20
go




use NORTHWND;
go

--Vistas
--Mostrar el código de producto, el nombre del producto y el precio por unidad
--de todos los productos de la empresa

create view v_productos_
as
select ProductID as 'ID', ProductName, UnitPrice 
from Products
go

--Mostrar el promedio de los precios unitarios de las categorias: Produce y Confections
create view promedios_Ejem
as
select AVG(p.UnitPrice), c.CategoryName 
from Products as p
inner join Categories as c
on c.CategoryID = p.CategoryID
where p.CategoryID in
(select CategoryID from Categories 
where CategoryName = 'Produce' or CategoryName = 'Confections')
group by c.CategoryName
go


--Crear un SP que calcule y muestre la edad de un empleado y mostrar si ya esta jubilado 
-- o le faltan años para jubilarse con un case

create or alter proc spu_anios_empleado
@idempl int
as
begin
declare  @total int
if(@total>=1)
	begin
		select (CAST(DATEDIFF(dd, BirthDate, Getdate())/365.25 as int))
		as edad,
		case
		when (CAST(DATEDIFF(dd, BirthDate, Getdate())/365.25 as int)) > 70 then 'Jubilado'
		when (CAST(DATEDIFF(dd, BirthDate, Getdate())/365.25 as int)) > 60 then 'Por retirase'
		when (CAST(DATEDIFF(dd, BirthDate, Getdate())/365.25 as int)) <= 60 then 'Flatan años' 
		end as 'estado'
		from Employees
		where EmployeeID = @idempl
end
else
	begin
		print 'El empleado con codigo' + convert(varchar(50), @idempl) + 'no existe'
	end
end
go

exec spu_anios_empleado 1


