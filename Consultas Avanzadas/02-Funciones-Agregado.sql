--Seleccionar le numero tortal de nombres de compra 

SELECT COUNT(*) as 'Numero de ordenes'FROM Orders

SELECT COUNT(*) from Customers


-- Count(campo)

SELECT Count(region) FROM Customers

--Seleccionar el maximo numero de productos pedido
select max(Quantity) as 'Cantidad'
from [order Details]

--Seleccionar el minimo numero de productos pedidos
select min(Quantity) as 'Cantidad'
from [order Details]

--Seleccionar el total de las cantidades de los pedidos pedidos
SELECT sum(UnitPrice) from [order Details]

--Seleccionar el total de dinero que he vendido 
SELECT sum(Quantity * od.UnitPrice) as total 
from [order Details] as od
INNER JOIN products as p
on od.productid = p.productid
where p.ProductName = 'Aniseed Syrup';

SELECT * from products 
WHERE productid = 3;

--Seleccionar el primedio de las ventas del producto 3
SELECT avg(Quantity * od.UnitPrice) as 'Promedio de Venta'
from [order Details] as od
INNER JOIN products as p
on od.productid = p.productid
where p.ProductName = 'Aniseed Syrup';

--- seleccionar le numero de productos por categoria 
SELECT sum(CategoryID), COUNT(*) as 'Numero de productos'
from products

select categoryid, COUNT(*) as 'Total de productos'
from products
group by categoryid

SELECT COUNT(*)
FROM Products

--Selecciopanr el numeor de productos por nombre de categoria
SELECT c.CategoryName, COUNT(productid) as 'Total de productos'
from categories as c
INNER JOIN products as p
on c.categoryid = p.categoryid
GROUP by c.CategoryName

SELECT c.CategoryName, COUNT(productid) as 'Total de productos'
from categories as c
INNER JOIN products as p
on c.categoryid = p.categoryid
where c.CategoryName in ('Beverages', 'Confections')
GROUP by c.CategoryName

