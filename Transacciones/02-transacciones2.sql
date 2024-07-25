--Ejercicio 2: Insertar una venta 

create or alter proc spu_Agregar_Venta
	@CustomerID nchar(5),
	@EmployeeID int,
	@OrderDate datetime,
	@RequiredDate datetime,
	@ShippedDate datetime,
	@ShipVia int,
	@Freight money = NULL,
	@ShipName nvarchar(40) = NULL, 
	@ShipAddress nvarchar(60) = NULL,
	@ShipCity nvarchar(15) = NULL,
	@ShipRegion nvarchar(15) = NULL,
	@ShipPostalCode nvarchar(10) = NULL,
	@ShipCountry nvarchar(15) = NULL,
	@ProductID int,
	@Quantity smallint,
	@Discount real = 0
as 
begin 
	BEGIN TRANSACTION;
	BEGIN TRY;
	INSERT INTO [dbo].[Orders]
           ([CustomerID]
           ,[EmployeeID]
           ,[OrderDate]
           ,[RequiredDate]
           ,[ShippedDate]
           ,[ShipVia]
           ,[Freight]
           ,[ShipName]
           ,[ShipAddress]
           ,[ShipCity]
           ,[ShipRegion]
           ,[ShipPostalCode]
           ,[ShipCountry])
     VALUES
           (@CustomerID,
			@EmployeeID,
			@OrderDate ,
			@RequiredDate,
			@ShippedDate,
			@ShipVia,
			@Freight,
			@ShipName, 
			@ShipAddress ,
			@ShipCity,
			@ShipRegion,
			@ShipPostalCode,
			@ShipCountry);

			--Obtener el id insertado en orders
			Declare @orderid int;
			set @orderid = SCOPE_IDENTITY();

			--Obtener el precio del producto
			declare @precioVenta money
			select @precioVenta = UnitPrice from products
			where ProductID = @ProductID;

			--INsertar en OrdersDetails
			INSERT INTO [dbo].[Order Details]
           ([ProductID]
           ,[UnitPrice]
           ,[Quantity]
           ,[Discount])
		VALUES
           (@ProductID,
            @precioVenta,
            @Quantity,
            @Discount);

		--Actualizar la tabla products en un campo
		update Products
		set UnitsInStock = UnitsInStock - @Quantity
		where ProductID = @ProductID

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

exec spu_Agregar_Venta 



