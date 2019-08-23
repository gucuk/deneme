--Join
/*Tablolar� birbirlerine ba�lama i�lemi
select
<tablo1adi>.<kolonadi>
from <tablo1Adi> inner join <tablo2Adi> on <tablo1adi>.<kolonAdi>=<tablo2adi>.<kolonAdi> */

select o.OrderID,o.ShipAddress,o.Freight,e.FirstName,e.LastName from Orders o 
inner join Employees e on o.EmployeeID=e.EmployeeID --orders �n i�ine employess tablosunu eklemi� olduk

--Kategori ad�,tedarik�i ad� ve �r�n ad�n� getiren sorguyu yaz�n�z
select p.ProductName,s.CompanyName,c.CategoryName from Products p 
	inner join Suppliers s on p.SupplierID=s.SupplierID 
	inner join Categories c on p.CategoryID=c.CategoryID

--federal shipping ile ta��nm�� ve nancy nin �zerine kay�tl� olan sipari�lerin �al��an �d �al��an ad� ve soyad�n�,�irket ad�,sipari� �d,sipari� tarihi ve kargo �cretini getiren sorgu.
select e.EmployeeID,(e.FirstName+' '+e.LastName) as '�al��an Ad� Soyad�',s.CompanyName,o.OrderID,o.OrderDate,o.Freight from Orders o 
	inner join Shippers s on o.ShipVia=s.ShipperID 
	inner join Employees e on e.EmployeeID=o.EmployeeID 
	where s.CompanyName='federal shipping' and e.FirstName='nancy'

--en �ok �r�n al�nan tedarik�iyi alm�� olunan �r�n miktar�na g�re listeleyin.
select s.CompanyName,sum(p.UnitsInStock) from Suppliers s 
	inner join Products p on p.SupplierID=s.SupplierID 
	group by s.CompanyName 
	order by 2 desc

--hangi �lkelere ne kadarl�k sat�� yap�lm��t�r?
select o.ShipCountry,round(sum(UnitPrice*Quantity*(1-discount)),3) 'Toplam Sat��' from [Order Details] od 
	inner join Orders o on o.OrderID=od.OrderID
	group by ShipCountry order by 2 desc 

--en �ok kar etmi� oldu�umuz ilk 3 �lke
select top 3 o.ShipCountry,round(sum(UnitPrice*Quantity*(1-discount)),3) 'Toplam Sat��' from [Order Details] od 
	inner join Orders o on o.OrderID=od.OrderID
	group by ShipCountry order by 2 desc 

--her bir �r�nden toplam ne kadrl�k sat�� yap�lm��t�r ve o �r�n hangi kategoride
select p.ProductName '�r�n Ad�',round(sum(od.UnitPrice*od.Quantity*(1-od.Discount)),3) 'Toplam Sat��',c.CategoryName 'Kategori Ad�' from Products p inner join [Order Details] od on od.ProductID=p.ProductID
	inner join Categories c on c.CategoryID=p.CategoryID 
	group by p.ProductName,CategoryName

--hangi personel hangi kategoriden toplamda ka� adet �r�n sat��� yapm��t�r 
select (e.FirstName+' '+e.LastName) 'Ad Soyad',c.CategoryName 'kategori',sum(Quantity) 'toplam adet' from Employees e inner join Orders o on e.EmployeeID=o.EmployeeID
inner join [Order Details] od on od.OrderID=o.OrderID 
inner join Products p on p.ProductID=od.ProductID 
inner join Categories c on c.CategoryID=p.CategoryID
group by c.CategoryName,e.FirstName,e.LastName order by 3 desc

--hangi personel hangi kategoriden toplamda ka� adet �r�n sat��� yapm��t�r ilk 3 kim 
select top 3 (e.FirstName+' '+e.LastName) 'Ad Soyad',c.CategoryName 'kategori',sum(Quantity) 'toplam adet' from Employees e inner join Orders o on e.EmployeeID=o.EmployeeID
inner join [Order Details] od on od.OrderID=o.OrderID 
inner join Products p on p.ProductID=od.ProductID 
inner join Categories c on c.CategoryID=p.CategoryID
group by c.CategoryName,e.FirstName,e.LastName order by 3 desc

