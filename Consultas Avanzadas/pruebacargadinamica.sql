--PruebaCRagadinamica
drop database pruebacargadinamica;

create database pruebacargadinamica;

use pruebacargadinamica

SELECT * from employees

select top 0 EmployeeID, FirstName, LastName, [Address], HomePhone, Country
into pruebacargadinamica.dbo.empleado
from NORTHWND.dbo.employees

SELECT * from empleado

insert into pruebacargadinamica.dbo.empleado (FirstName, LastName, [Address], HomePhone, Country)
select FirstName, LastName, [Address], HomePhone, Country
from NORTHWND.dbo.Employees

--Crear tabla dim-empleado
SELECT EmployeeID as 'idempleado', CONCAT (FirstName,' ',LastName) as 'nombrecompleto', [Address] as 'dirreccion', HomePhone as 'telefono', country as 'continente' from empleado

SELECT EmployeeID as 'idempleado', CONCAT (FirstName,' ',LastName) as 'nombrecompleto', [Address] as 'dirreccion', HomePhone as 'telefono', country as 'continente'
into pruebacargadinamica.dbo.dim_empleado 
FROM pruebacargadinamica.dbo.empleado

SELECT * from dim_empleado

insert into empleado(FirstName, LastName, [Address], HomePhone, country)
values 
('Cristiano', 'Ronaldo', 'Calle 5 de febrerp', 7715423528301, 'POR')


TRUNCATE TABLE dim_empleado

DROP table dim_empleado

