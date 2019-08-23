--bir sipariþin hangi çalýþan tarafýndan hangi müþteriye hangi kategorideki üründen hangi fiyatta kaç adet satýldýðýný listeleyiniz.
select (e.FirstName+' '+e.LastName) 'Çalýþan',cust.CompanyName 'Müþteri',c.CategoryName 'Kategori', od.UnitPrice 'Fiyat',od.Quantity 'Adet' from Orders o
inner join Employees e on e.EmployeeID=o.EmployeeID
inner join Customers cust on cust.CustomerID=o.CustomerID
inner join [Order Details] od on od.OrderID=o.OrderID
inner join Products p on p.ProductID=od.ProductID
inner join Categories c on c.CategoryID=p.CategoryID


--stoktaki hangi tedarikçiden ortalama kaç ürün var? çoktan aza doðru sýrala
select s.CompanyName,p.ProductName,AVG(UnitsInStock) 'Ortalama Ürün Sayýsý' from Products p
inner join Suppliers s on p.SupplierID=s.SupplierID 
group by s.CompanyName,p.ProductName order by 3 desc

--Çalýþanlarým en fazla hangi ürünleri satmýþtýr?kiþi bazýnda bir rapor listeleyin.
select (e.FirstName+' '+e.LastName) 'Çalýþan',p.ProductName 'Ürün Adý',od.Quantity 'Ürün Adedi',sum(od.Quantity*od.UnitPrice*(1-od.Discount)) 'Ürünün Toplam Satýþ fiyatý ' from Employees e
inner join Orders o on o.EmployeeID=e.EmployeeID
inner join [Order Details] od on od.OrderID=o.OrderID
inner join Products p on p.ProductID=od.ProductID
group by e.FirstName,e.LastName,p.ProductName,od.Quantity order by 4 desc





