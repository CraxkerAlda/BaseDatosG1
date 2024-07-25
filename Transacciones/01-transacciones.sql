
use NORTHWND;
go

--Transaccion: En SQLServer son fundamentales para asegurar la consistencia y la integridad 
--de los datos en una Base de datos

--Una transaccion es una unidad de trabajo que se eecuta de manera 
--completamente exitiosa o no se ejecuta en absoluto

--Sigue el principio ACID: 
--
--

---
---
--
--

select * from categories;
go

--delete from Categories
--where CategoryID in (10,12)

begin transaction;

insert into Categories(CategoryName, Description)
values ('Los remediales', 'Estara muy bien');
go

delete from Categories
where CategoryID = 8;
go

rollback transaction; --cerrar transaction

commit transaction;


Create database prueba_transacciones;
go

use prueba_transacciones;
go

create table empleado (
	emplid int not null,
	nombre varchar(30) not null,
	salario money not null,
	constraint pk_empeado
	primary key(emplid),
	constraint chk_salario 
	check(salario >0.0 and salario <50000)
);
go



create or alter proc spu_agregar_empleado 
--Parametros de entrada
@emplid int,
@nombre varchar(30),
@salario money
as 
	begin
		begin try
			begin transaction 

			--Inserta en la tabla empleados
			insert into empleado (emplid, nombre, salario)
			values (@emplid, @nombre, @salario);

			--Se confirma la transaccion si todo va bien 
			commit transaction;
		end try
		begin catch
			rollback transaction;

			--Obtener el error
			declare @MensajeError nvarchar(4000);
			set @MensajeError = ERROR_MESSAGE();

			print @MensajeError;
		end catch;
	end;
go

exec spu_agregar_empleado 1,'Monico', 21000.0;
go

exec spu_agregar_empleado 3,'Torivio', -60000.0;
go

select * from empleado