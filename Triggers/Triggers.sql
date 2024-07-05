create database PruebatrigersG1;
go 

use PruebatrigersG1;
go 

drop table Empleado

create table Empleado (
	idempleado int not null primary key,
	nombreempleado varchar(30) not null, 
	apellido1 varchar (15) not null,
	apellido2 varchar (15),
	salario money not null
);
go

create or alter trigger tg_1
on Empleado
after insert 
as 
begin
	print 'Se ejecuto el trigger tg_1, en el evento insert'
end;
go

select * from Empleado

insert into Empleado 
values (1, 'Jose Luis', 'Herrera', 'Gallardo', 57500);
go

drop trigger tg_1;
go

create or alter trigger tg_2
on Empleado
after insert
as
begin
	select * from inserted;
	select * from deleted;
end;
go


create or alter trigger tg_3
on Empleado
after delete
as
begin
	select * from inserted;
	select * from deleted;
end;
go

create or alter trigger tg_4
on Empleado
after update 
as
begin
	select * from inserted;
	select * from deleted;
end;
go

insert into Empleado 
values (2, 'Rocio', 'Cruz', 'Cervantes', 80000);
go

delete Empleado 
where idempleado =2;

update Empleado
set salario = 1500,
nombreempleado = 'Osmar'
where idempleado = 1;
go

select * from Empleado;
go

create or alter trigger tg_5
on Empleado
after insert, delete 
as
begin
	if exists (select 1 from inserted)
	begin 
		print 'Se realizo un insert'
	end
	else if exists (select 1 from deleted) and 
	not exists (select 1 from inserted)
	begin
		print 'Se realizo un delete'
	end
end;
go

insert into Empleado 
values (2, 'Leslie', 'Jimenez', 'Nery', 100000);
go

delete from Empleado
where idempleado =2;
go


drop trigger tg_1;
go

drop trigger tg_2;
go

drop trigger tg_3;
go

drop trigger tg_4;
go

drop trigger tg_5;
go










