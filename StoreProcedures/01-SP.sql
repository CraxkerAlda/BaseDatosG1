
--Declaracion de y uso de variables en transact-sql
use NORTHWND;

--Declaracion de una variable 
DECLARE @numeroCal int 
declare @calif decimal(10,2)

--Asignacion de variables
set @numeroCal = 10
if @numeroCal <= 0
begin 
set @numeroCal = 1
end 
declare @i = 1 
while(@i <= @numeroCal)
BEGIN
set @calif = @calif +10
set @i = @i +1
END
set @calif = @calif/@numeroCal
PRINT('El resultado es: ' + @calif)


----------------------------------------------------------------
--Parametros salido 
create or alter procedure calcular_area
 --Parametros de entrada
 @radio float,
 --Parametro de salida 
 @area float output
 as 
 begin 
	set @area = PI() * @radio * @radio
 end
 go

 declare @resp float
 exec calcular_area @radio = 22.3, @area = @resp output
 print ('El area es: ' + cast(@resp as varchar))
go

 ----------------------------
 use NORTHWND;

create or alter proc sp_obtenerdatosempleado
@numeroempleado int,
@fullname nvarchar(35) output
as
begin
	
  select CONCAT(FirstName, ' ', LastName)  as 'Nombre completo'
	from 
	Employees
	where EmployeeID = @numeroempleado;
end;
go

declare @nombrecompleto nvarchar(35)
exec sp_obtenerdatosempleado @numeroempleado = 10 , @fullname = @nombrecompleto output
print (@nombrecompleto)
go



CREATE OR ALTER PROCEDURE sp_obtenerdatosempleado_buscar
    @numeroEmpleado INT,
    @fullname NVARCHAR(35) OUTPUT
AS
BEGIN
    SELECT @fullname = CONCAT(FirstName, ' ', LastName)
    FROM Employees
    WHERE EmployeeID = @numeroEmpleado;
    IF @fullname IS NULL
    BEGIN
        SET @fullname = 'ID no existente';
    END
END;

DECLARE @fullname NVARCHAR(35);
EXEC sp_obtenerdatosempleado_buscar @numeroEmpleado = 2, @fullname = @fullname OUTPUT;
PRINT @fullname;



print @nombrecompleto

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

