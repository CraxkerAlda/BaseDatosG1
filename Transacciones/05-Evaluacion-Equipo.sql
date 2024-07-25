--Actualizar precios de un producto
--Realizar un sp que actualize el precio de un producto y que guarde esa actualizacion en una tabla de historicos
use NORTHWND;
go

drop table preciosHistoricos
go
drop proc spu_actualizar_precios
go

create table preciosHistoricos
(
    id int IDENTITY(1,1) not null,
	ProductID int,
    precioAnterior money,
    precioNuevo money,
    fechaModificacion date DEFAULT GETDATE()
);
GO

CREATE OR ALTER PROCEDURE spu_actualizar_precios
@Producto INT,
@nuevoPrecio MONEY
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @precioAnterior MONEY;

        SELECT @precioAnterior = UnitPrice
        FROM Products
        WHERE ProductID = @Producto;

        UPDATE Products 
        SET UnitPrice = @nuevoPrecio
        WHERE ProductID = @Producto;

        INSERT INTO preciosHistoricos (ProductID, precioAnterior, precioNuevo)
        VALUES (@Producto, @precioAnterior, @nuevoPrecio);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @mensajeError VARCHAR(100);
        SET @mensajeError = ERROR_MESSAGE();
        PRINT @mensajeError;
    END CATCH;
END
GO

exec spu_actualizar_precios 8,2000
go
exec spu_actualizar_precios 2,15
exec spu_actualizar_precios 3,10
exec spu_actualizar_precios 15,100
go



--realizar un sp que elimine una orden de compra completa, (Order, OrderDetails) y debe actualizar los unique in stock

create or alter proc spu_eliminar_orden
@ordenid int
as 
begin 
	BEGIN TRANSACTION;
	BEGIN TRY;
		update Products
		set UnitsInStock = UnitsInStock + od.Quantity
		from [Order Details] as od
		where od.OrderID = @ordenid

		delete from [Order Details]
		where OrderID = @ordenid

		delete from Orders
		where OrderID = @ordenid

		commit transaction;

	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		declare @mensajeError nvarchar(400);
		set @mensajeError = ERROR_MESSAGE();
		print @mensajeError;

	END CATCH;

END;
GO

exec spu_eliminar_orden 1025

select * from [Order Details]
select * from Orders
select * from Products


		