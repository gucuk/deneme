--SubQuery
select *,
(select CompanyName from Suppliers s where s.SupplierID=p.SupplierID) as 'Tedarikçi Adý'
from Products p

--Speedy Express olan Nakliyesi bugüne kadar toplam kaç ürün taþýmýþtýr?
select SUM(Quantity) from [Order Details] where OrderID in
	(select OrderID from Orders where ShipVia in
	(select ShipperID from Shippers where CompanyName='Speedy Express'))


--ürün adý chai olan ürünün toplam satýþ tutarýný listeleyin.
select round(sum(Quantity*UnitPrice*(1-Discount)),2) as 'Toplam Satýþ' 
	from [Order Details] 
	where ProductID=(select ProductID from Products where ProductName='chai') 

--ýd si anton olan müþteri hangi kategorilerden ürün satýn almýþtýr?
select CategoryName from Categories where CategoryID in(
select CategoryID from Products where ProductID in(
select ProductID from [Order Details] where OrderID in(
select OrderID from Orders where CustomerID=(select CustomerID from Customers where CustomerID='anton'))))

--




