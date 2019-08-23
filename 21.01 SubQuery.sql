--SubQuery alt sorgu
--fiyatý ortalama fiyatýn altýnda olan ürünleri listele
select * from Products where UnitPrice<(select avg(UnitPrice) from Products)

--ürünlerin tedarikçi isimlerini listele.
select *,
(select CompanyName from Suppliers where Suppliers.SupplierID=Products.SupplierID) as 'Tedarikçi'
from Products


--Ürünler tablosunu tedarikçi adý,category adý ,ürün adý fiyatý ve stok bilgileri ile listeleyin.
select ProductName,UnitPrice,UnitsInStock,
	(select CategoryName from Categories where Products.CategoryID=Categories.CategoryID) as 'Kategori',
	(select CompanyName from Suppliers where Suppliers.SupplierID=Products.SupplierID) as 'Tedarikçi'
from Products


--Satýþlar tablosunu müþteri adý personel adý ve soyadý ile birlikte listeleyin.
select *,
(select CompanyName from Customers where Orders.CustomerID=Customers.CustomerID) as 'Müþteri Adý',
(select (FirstName+' '+LastName) from Employees where Employees.EmployeeID=Orders.EmployeeID) as 'Personel Adý ve Soyadý'
from Orders

-------------------------------------------------------------------------------------------------------------------------------------
--ürünler ile birlikte ürünün toplam satýþ adet bilgisini listeleyin.
select *,
(select sum(Quantity) from [Order Details] where [Order Details].ProductID=Products.ProductID) as 'Toplam Satýþ Adedi'
from Products

--Yukarýda ki sorgunun tablolarýn kýsaltýlmýþ isimleriyle yazýlmýþ hali
select *,
(select sum(Quantity) from [Order Details] as od where od.ProductID=p.ProductID) as 'Toplam Satýþ Adedi'
from Products as p order by [Toplam Satýþ Adedi] desc
-------------------------------------------------------------------------------------------------------------------------------------

--Yapýlan satýþlarý max satýþ fiyatý ile listeleyin.
select *,
(select max(UnitPrice) from [Order Details] as od where o.OrderID=od.OrderID ) as 'Max Satýþ Fiyatý'
from Orders as o


--Ürünlerle birlikte ürüne uygulanan max indirim yüzdesi bilgisini listeleyin.
select *,
(select max(Discount) from [Order Details] as od where od.ProductID=p.ProductID) as 'Max Ýndirim Oraný'
from Products as p


--Adý Janet olan personelin yaptýðý satýþlarý listeleyin
select  * from Orders o where EmployeeID=(select EmployeeID from Employees where FirstName='Janet')