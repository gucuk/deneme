--bir sipari�in hangi �al��an taraf�ndan hangi m��teriye hangi kategorideki �r�nden hangi fiyatta ka� adet sat�ld���n� listeleyiniz.
select (e.FirstName+' '+e.LastName) '�al��an',cust.CompanyName 'M��teri',c.CategoryName 'Kategori', od.UnitPrice 'Fiyat',od.Quantity 'Adet' from Orders o
inner join Employees e on e.EmployeeID=o.EmployeeID
inner join Customers cust on cust.CustomerID=o.CustomerID
inner join [Order Details] od on od.OrderID=o.OrderID
inner join Products p on p.ProductID=od.ProductID
inner join Categories c on c.CategoryID=p.CategoryID


--stoktaki hangi tedarik�iden ortalama ka� �r�n var? �oktan aza do�ru s�rala
select s.CompanyName,p.ProductName,AVG(UnitsInStock) 'Ortalama �r�n Say�s�' from Products p
inner join Suppliers s on p.SupplierID=s.SupplierID 
group by s.CompanyName,p.ProductName order by 3 desc

--�al��anlar�m en fazla hangi �r�nleri satm��t�r?ki�i baz�nda bir rapor listeleyin.
select (e.FirstName+' '+e.LastName) '�al��an',p.ProductName '�r�n Ad�',od.Quantity '�r�n Adedi',sum(od.Quantity*od.UnitPrice*(1-od.Discount)) '�r�n�n Toplam Sat�� fiyat� ' from Employees e
inner join Orders o on o.EmployeeID=e.EmployeeID
inner join [Order Details] od on od.OrderID=o.OrderID
inner join Products p on p.ProductID=od.ProductID
group by e.FirstName,e.LastName,p.ProductName,od.Quantity order by 4 desc





