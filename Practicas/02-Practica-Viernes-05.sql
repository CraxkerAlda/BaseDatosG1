--Crear un Storage P que reciba dos fechas y devuelva una lista de empleados (full name)
--que fueron contratados en esas fechas, hiredate

Use NORTHWND;
go

select * from Employees
go

select CONCAT(e.FirstName, ' ', e.LastName) as 'Empleado', 
e.HireDate as 'Fecha contrato'
from Employees as e
WHERE HireDate BETWEEN '1992-04-01' and '1992-05-01'
go

create or alter proc sp_fechacontrato_empl
@fechaUno date,
@fechaDos date
as
begin
select CONCAT(e.FirstName, ' ', e.LastName) as 'Empleado', 
e.HireDate as 'Fecha contrato'
from Employees as e
WHERE HireDate BETWEEN @fechaUno and @fechaDos
end
go

exec sp_fechacontrato_empl '1992-05-01', '1992-08-14'
go


--Procedimiento almacenado para actualizar el precio de un producto y registrar el cambio proceso
--1. Crear un sp llamado actualizar_precio_producto
--2. Crear una tabla que se llame cambio de precios, campos que tiene: Cambioid int identity primary key, productoid int not null todos, 
-- precioanterior money, precionuevo money, fechadecambio datetime (getdate())
--3. Debe de aceptar dos parametros producto a cambiar y el nuevo precio 
--4. el procedimiento debe actualizar el precio del procto de la tabla 
--5. El El procedimineto debe 


drop table cambioprecios
go

create table cambioprecios (
	cambioid int not null identity(1,1),
	productoid int not null,
	precioanterior money not null,
	precionuevo money not null,
	fechadecambio DATETIME DEFAULT GETDATE()
	constraint pk_cambioprecios
	primary key(cambioid)
);
go

select * from Products
go

create or alter proc sp_llenar_tb
as
begin
insert into cambioprecios (productoid, precioanterior)
select p.ProductID, p.UnitPrice
from Products as p
left join cambioprecios as c
on p.ProductID = c.productoid
WHERE c.productoid IS NULL;
update cp
SET 
cp.precioanterior = p.UnitPrice
FROM cambioprecios as cp
INNER JOIN Products as p 
ON cp.productoid = p.ProductID;
end
go


exec sp_llenar_tb
go

CREATE OR ALTER PROC sp_actualizar_precio_producto
    @productid INT,
    @nuevo_precio MONEY
as
begin
    DECLARE @precio_anterior MONEY;

    SELECT @precio_anterior = UnitPrice
    FROM Products
    WHERE ProductID = @productid;

    UPDATE Products
    SET UnitPrice = @nuevo_precio
    WHERE ProductID = @productid;

    INSERT INTO cambioprecios (productoid, precioanterior, precionuevo, fechadecambio)
    VALUES (@productid, @precio_anterior, @nuevo_precio, GETDATE());
    
END;
go 

exec sp_actualizar_precio_producto @productid = 1, @nuevo_precio = 5.00;

select * from cambioprecios

drop proc sp_actualizar_precio_producto