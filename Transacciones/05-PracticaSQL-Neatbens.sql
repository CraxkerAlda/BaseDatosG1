

select * from StudentsC1
select * from StudentsC2


truncate table StudentsC2
go

create or alter proc spu_limpiar_tabla
@nombreTabla nvarchar(50)
as 
begin
	declare @sql nvarchar(50)
	set @sql = 'Truncate table ' + @nombreTabla;
	exec(@sql)
end
go