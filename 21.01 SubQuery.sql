--SubQuery alt sorgu
--fiyat� ortalama fiyat�n alt�nda olan �r�nleri listele
select * from Products where UnitPrice<(select avg(UnitPrice) from Products)

--�r�nlerin tedarik�i isimlerini listele.
select *,
(select CompanyName from Suppliers where Suppliers.SupplierID=Products.SupplierID) as 'Tedarik�i'
from Products


--�r�nler tablosunu tedarik�i ad�,category ad� ,�r�n ad� fiyat� ve stok bilgileri ile listeleyin.
select ProductName,UnitPrice,UnitsInStock,
	(select CategoryName from Categories where Products.CategoryID=Categories.CategoryID) as 'Kategori',
	(select CompanyName from Suppliers where Suppliers.SupplierID=Products.SupplierID) as 'Tedarik�i'
from Products


--Sat��lar tablosunu m��teri ad� personel ad� ve soyad� ile birlikte listeleyin.
select *,
(select CompanyName from Customers where Orders.CustomerID=Customers.CustomerID) as 'M��teri Ad�',
(select (FirstName+' '+LastName) from Employees where Employees.EmployeeID=Orders.EmployeeID) as 'Personel Ad� ve Soyad�'
from Orders

-------------------------------------------------------------------------------------------------------------------------------------
--�r�nler ile birlikte �r�n�n toplam sat�� adet bilgisini listeleyin.
select *,
(select sum(Quantity) from [Order Details] where [Order Details].ProductID=Products.ProductID) as 'Toplam Sat�� Adedi'
from Products

--Yukar�da ki sorgunun tablolar�n k�salt�lm�� isimleriyle yaz�lm�� hali
select *,
(select sum(Quantity) from [Order Details] as od where od.ProductID=p.ProductID) as 'Toplam Sat�� Adedi'
from Products as p order by [Toplam Sat�� Adedi] desc
-------------------------------------------------------------------------------------------------------------------------------------

--Yap�lan sat��lar� max sat�� fiyat� ile listeleyin.
select *,
(select max(UnitPrice) from [Order Details] as od where o.OrderID=od.OrderID ) as 'Max Sat�� Fiyat�'
from Orders as o


--�r�nlerle birlikte �r�ne uygulanan max indirim y�zdesi bilgisini listeleyin.
select *,
(select max(Discount) from [Order Details] as od where od.ProductID=p.ProductID) as 'Max �ndirim Oran�'
from Products as p


--Ad� Janet olan personelin yapt��� sat��lar� listeleyin
select  * from Orders o where EmployeeID=(select EmployeeID from Employees where FirstName='Janet')