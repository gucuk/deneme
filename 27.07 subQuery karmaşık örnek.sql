--SubQuery
select *,
(select CompanyName from Suppliers s where s.SupplierID=p.SupplierID) as 'Tedarik�i Ad�'
from Products p

--Speedy Express olan Nakliyesi bug�ne kadar toplam ka� �r�n ta��m��t�r?
select SUM(Quantity) from [Order Details] where OrderID in
	(select OrderID from Orders where ShipVia in
	(select ShipperID from Shippers where CompanyName='Speedy Express'))


--�r�n ad� chai olan �r�n�n toplam sat�� tutar�n� listeleyin.
select round(sum(Quantity*UnitPrice*(1-Discount)),2) as 'Toplam Sat��' 
	from [Order Details] 
	where ProductID=(select ProductID from Products where ProductName='chai') 

--�d si anton olan m��teri hangi kategorilerden �r�n sat�n alm��t�r?
select CategoryName from Categories where CategoryID in(
select CategoryID from Products where ProductID in(
select ProductID from [Order Details] where OrderID in(
select OrderID from Orders where CustomerID=(select CustomerID from Customers where CustomerID='anton'))))

--




