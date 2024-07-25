use BDEJEMPLO2;
go

--Realizar un SP que realice un pedido:
-- 1.- Debe verificar si hay suficiente stock, si lo hay debe actualizar el stock
-- y regresar el mensaje "Se inserto correctamente"
--2.- Si el stock no es suficiente debe regresar un mensaje de "No existe el suficiente stock"

create or alter proc spu_realizar_pedido
@numpedido int,
@fecha date,
@cliente int,
@repre int,
@fab char(3),
@prod char(5),
@cantidad int,
@mensaje nvarchar(50) output
as
begin

declare @stock int
declare @precio money

select @stock = Stock, @precio = Precio
from Productos
where Id_fab = @fab
and Id_producto = @prod;

if(@stock >= @cantidad)
begin
	insert into Pedidos
	values (@numpedido,@fecha,@cliente,@repre, @fab, @prod, @cantidad,
	(@cantidad*@precio))

	update Productos
	set Stock = Stock - @cantidad
	where Id_fab = @fab and
	Id_producto = @prod

	set @mensaje = 'Se inserto correctamente'
end
else
	begin
		set @mensaje = 'No existe suficiente stock'
	end
end
go

declare @salida nvarchar(50)
declare @fecha date
set @fecha = (select GETDATE())

exec spu_realizar_pedido @numpedido = 11307, @fecha = @fecha, @cliente =2108,
@repre = 106, @fab = 'REI', @prod = '2A44L', @cantidad = 20, @mensaje = @salida output
print @salida
go

select * from Productos
select * from Pedidos
select * from Clientes
