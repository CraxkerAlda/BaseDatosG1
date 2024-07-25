use AdventureWorks2019;
go 

--last name, firts name, contar numero de ordenes que hay y sumar el total, Total due sale.orderheard
--custumer, sales order geder, person slaes.saler orderhaer, sales.custumers, person.person

select * from Sales.SalesOrderHeader
select * from Sales.Customer
select * from Person.Person

go

create or alter proc usp_GetCustomerOrdersInfo 
@CustomerID int
as
begin
	declare @id varchar(50)

	select * 
	from Sales.SalesOrderHeader as soh
	inner join Sales.Customer as sc
	on sc.CustomerID = soh.CustomerID
	inner join Person.Person as pp
	on pp.PersonType = sc.PersonID

	IF @id IS NULL
    BEGIN
        SET @id = 'ID no existente';
    END
end
go


--Ejercicio 2

create table Sales.OrderHistory (
OrderID int,
CustumerID int,
OrderDate Datetime default getdate(),
TotalAmount money
);
go


DECLARE @precioAnterior MONEY;

        SELECT @precioAnterior = UnitPrice
        FROM Products
        WHERE ProductID = @Producto;

        UPDATE Products 
        SET UnitPrice = @nuevoPrecio
        WHERE ProductID = @Producto;

        INSERT INTO preciosHistoricos (ProductID, precioAnterior, precioNuevo)
        VALUES (@Producto, @precioAnterior, @nuevoPrecio);
		go

create or alter proc usp_CreateCustumerOrder
	@idcli int,
	@idprod int,
	@stock int,
	@precio money
as 
begin
	select * from 
	Sales.SalesOrderDetail as sod
	inner join Sales.SalesOrderHeader as soh
	on soh.SalesOrderID = sod.SalesOrderID
	inner join Sales.Customer as sc
	on sc.CustomerID = soh.CustomerID
end 
go

create or alter proc usp_CreateCustumerOrder
	@idcli int,
	@idprod int,
	@stock int,
	@precio money
as 
begin


	insert into Sales.OrderHistory
	values ()
end 
go



select * from Sales.SalesOrderHeader
select * from Sales.Customer
select * from Sales.SalesOrderDetail

