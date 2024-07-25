use NORTHWND;
go

--Crear un  sp que reciba como parametro de entrada el nombre de una tabla
--visualice todossus registros 

select * from products
go

create or alter proc spu_mostrar_datos_tabla
@nomTab varchar(100)
as
begin
	--SQL Dinamico
	declare @sql nvarchar(max);
	set @sql = 'select * from ' + @nomTab
	exec(@sql)
end;
go

exec spu_mostrar_datos_tabla 'Employees'
exec spu_mostrar_datos_tabla 'Products'
go

--Segunda forma
create or alter proc spu_mostrar_datos_tabla
@nomTab varchar(100)
as
begin
	--SQL Dinamico
	declare @sql nvarchar(max);
	set @sql = 'select * from ' + @nomTab
	exec sp_executesql @sql
end;
go

exec spu_mostrar_datos_tabla 'Employees'
exec spu_mostrar_datos_tabla 'Products'
go