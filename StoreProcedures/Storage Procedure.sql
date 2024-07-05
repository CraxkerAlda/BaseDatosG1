use NORTHWND; 

--Store procedures
Create PROCEDURE sp_prueba_g1
as 
begin
    PRINT 'Hola Mundo';
end 

--Ejecutar un store procedure
EXEC sp_prueba_g1

--Declaración de variables
declare @n int
declare @i int

set @n = 5
set @i = 1

print ('El valor de n es:' + cast(@n as VARCHAR))
print ('El valor de i es:' + cast(@i as VARCHAR))



create DATABASE prueba_sp;
use prueba_sp;

create proc sp_uno
as 
begin 
declare @n int
declare @i int

set @n = 5
set @i = 1

print ('El valor de n es:' + cast(@n as VARCHAR))
print ('El valor de i es:' + cast(@i as VARCHAR))
end 

--Ejecutar 10 veces sp_uno solamente si el sentinela es 1

DECLARE @n as int = 10, @i int = 1

while @i <= @n 
begin
    PRINT(@i);
    set @i += 1;
END


--Ejercico básico Store Procedure
create procedure sp_2
as 
BEGIN
DECLARE @n as int = 10, @i int = 1
while @i <= @n 
begin
    PRINT(@i);
    set @i += 1;
end
end

EXEC sp_2

--store procedure con parametros dpe entrada

create proc sp_3

@n int -- parametro de entrada
as 
begin 
DECLARE @i int =1

if @n > 0
begin 
    while @i <= @n 
    begin
        PRINT(@i);
        set @i += 1;
    end
    end    
else 
BEGIN
    PRINT 'El valor de n debe ser mayor a 0 '
end
end

EXEC sp_3
exec sp_3 @n=23

-- Seleccionar de la base de datos notrhwind todas las ordenes de compra para un año determinado
use NORTHWND;

create or alter proc sp_ordenes_anio
    @datepart int 
as 
begin 
    SELECT OrderDate 
    from Orders 
    where YEAR(OrderDate) = @datepart;
end 
go 
EXEC sp_ordenes_anio @datepart= 1996;


---Crear un sp, que muestre el total de ventas ($) para cada cliente por un rango de años

create proc sp_total_ventas
    @dato int
AS
begin 
    SELECT c.CustomerID, c.CompanyName as 'Nombre Cliente', sum(od.UnitPrice * od.Quantity) as 'TotalVentas'
    from Orders as o
    inner join Customers as c 
    on o.CustomerID = c.CustomerID
    inner join [Order Details] as od 
    on o.OrderID = od.OrderID
    WHERE YEAR(o.OrderDate) = @dato
    GROUP by c.CustomerID, c.CompanyName
    order by TotalVentas DESC;
END

exec sp_total_ventas @dato = 1996;
