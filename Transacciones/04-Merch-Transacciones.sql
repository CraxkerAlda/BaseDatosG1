--MERGE INTO <target table> AS TGT
--USING <SOURCE TABLE> AS SRC  
--  ON <merge predicate>
--WHEN MATCHED [AND <predicate>] -- two clauses allowed:  
--  THEN <action> -- one with UPDATE one with DELETE
--WHEN NOT MATCHED [BY TARGET] [AND <predicate>] -- one clause allowed:  
--  THEN INSERT... –- if indicated, action must be INSERT
--WHEN NOT MATCHED BY SOURCE [AND <predicate>] -- two clauses allowed:  
--  THEN <action>; -- one with UPDATE one with DELETE

Create database mergeEscuelita
go

use mergeEscuelita
go

drop table StudentsC1

CREATE TABLE StudentsC1(
    StudentID       INT
    ,StudentName    VARCHAR(50)
    ,StudentStatus  BIT
);
go


INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(1,'Axel Romero',1)
INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(2,'Sofía Mora',1)
INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(3,'Rogelio Rojas',0)
INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(4,'Mariana Rosas',1)
INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(5,'Roman Zavaleta',1)
go


CREATE TABLE StudentsC2(
    StudentID       INT
    ,StudentName    VARCHAR(50)
    ,StudentStatus  BIT
);
go


select * from StudentsC1
select * from StudentsC2

select *
from StudentsC1 as c1
inner join StudentsC2 as c2
on c1.StudentID = c2.StudentID


select c1.StudentID, c1.StudentName, c1.StudentStatus
from StudentsC1 as c1
left join StudentsC2 as c2
on c1.StudentID = c2.StudentID
where c2.StudentID is null


select c1.StudentID, c1.StudentName, c1.StudentStatus
from StudentsC1 as c1
inner join StudentsC2 as c2
on c1.StudentID = c2.StudentID


insert into StudentsC2 
values (1, 'Axel Romero',0)
go

truncate table StudentsC2
go

--------------------------------------------Store Procedure----------------------------------------------
--Store Procedure que agregara y actualiza los registros nuevos y registros modificados de 
--la tabla studentc1 a studentc2 Utilizando consultas con left join e innner join 


create or alter proc spu_carga_delta_student1_student1
--Parametros 
as
begin
--Programacion del STore
	begin transaction
	begin try
	--Procedimiento a ejecutar de manera exitosaInsertar nuevos registros de la tabla STudentsc1 a Studentsc2
	INSERT into StudentsC2 (StudentID, StudentName, StudentStatus)
	select c1.StudentID, c1.StudentName, c1.StudentStatus
	from StudentsC1 as c1
	left join StudentsC2 as c2
	on c1.StudentID = c2.StudentID
	where c2.StudentID is null;

	--Se actualizan los registrios que han tenido algun cambio en la tabla Source(StudentsC1) 
	--y se cambian en la tabla Target(StudentC2)
	UPDATE c2
	set c2.studentName = c1.studentName,
		c2.studentStatus = c1.studentStatus
	from StudentsC1 as c1
	inner join StudentsC2 as c2
	on c1.StudentID = c2.StudentID

	--Confirmar la transaccion
	commit transaction;

	end try
	begin catch
		rollback transaction
		declare @mensaError Varchar(100);
		set @mensaError = ERROR_MESSAGE();
		print @mensaError;
	end catch
end;
go

exec spu_carga_delta_student1_student1
go


select * from StudentsC2

select c1.StudentID, c1.StudentName, c1.StudentStatus
from StudentsC1 as c1
left join StudentsC2 as c2
on c1.StudentID = c2.StudentID
where c2.StudentID is null
go

select * from StudentsC1
select * from StudentsC2

update StudentsC1
set StudentName = 'Axel Ramero'
where StudentID = 1;
go

update StudentsC1
set StudentStatus = 1
where StudentID = 3;
go

update StudentsC1
set StudentStatus = 0
where StudentID in (1,4,5);
go

insert into StudentsC1
values (6, 'Monico Hernandez', 0);

select @@VERSION  
go


create or alter proc spu_carga_delta_student1_student1_merge
--Parametros 
as
begin
--Programacion del STore
	--programacion de sp
begin transaction;
begin try 
	merge into StudentsC2 as TGT
	using (
	select studentid, studentname, studentstatus
	from StudentsC1
	) as SRC
	on (
		TGT.studentid = SRC.studentid
	)

	--Para actualizar 
	when matched then
	update 
	set TGT.studentname = SRC.studentname,
		TGT.studentstatus = SRC.studentstatus
		--Para insertar 
		when not matched then
		Insert (studentid, studentname, studentstatus)
		values(SRC.studentid, SRC.studentname, SRC.studentstatus);
	
		--Eliminar 
		

	--Confirmar la transaccion
	commit transaction;

	end try
	begin catch
		rollback transaction
		declare @mensaError Varchar(100);
		set @mensaError = ERROR_MESSAGE();
		print @mensaError;
	end catch
end;
go


exec spu_carga_delta_student1_student1_merge
go

