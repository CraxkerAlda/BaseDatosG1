use northwnd;
go

select o.OrderID, o.OrderDate, c.CompanyName, 
c.City, od.Quantity, od.UnitPrice
from Orders as o
inner join [Order Details] as od
on o.OrderID = od.OrderID
inner join Customers as c
on c.CustomerID = o.CustomerID
where c.City in ('San Cristóbal', 'México D.F.') --In es igual a Or
-----------------------------------------------------------

select c.CompanyName, COUNT(o.OrderID) as [Numero Ordenes]
from Orders as o
inner join [Order Details] as od
on o.OrderID = od.OrderID
inner join Customers as c
on c.CustomerID = o.CustomerID
where c.City in ('San Cristóbal', 'México D.F.')
group by c.CompanyName
having COUNT(*) > 18;


--Obtener los nombre de los producto y sus categorias donde el precio promedio de los productos
-- en la misma categoria sea mayor a 20

select p.ProductName, c.CategoryName, 
avg(p.UnitPrice) as 'Promedio'
from Products as p
left join Categories as c
on p.CategoryID = c.CategoryID
where c.CategoryID is not null
group by  p.ProductName, c.CategoryName
having avg(p.UnitPrice) > 20
order by c.CategoryName asc


--Mostrar registros donde el maximo del precio unitario sea mayor a 40

select p.ProductName, c.CategoryName, 
avg(p.UnitPrice) as 'Promedio'
from Products as p
left join Categories as c
on p.CategoryID = c.CategoryID
where c.CategoryID is not null
group by  p.ProductName, c.CategoryName
having max(p.UnitPrice) > 200
order by c.CategoryName asc