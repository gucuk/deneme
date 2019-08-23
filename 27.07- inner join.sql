--Join
/*Tablolarý birbirlerine baðlama iþlemi
select
<tablo1adi>.<kolonadi>
from <tablo1Adi> inner join <tablo2Adi> on <tablo1adi>.<kolonAdi>=<tablo2adi>.<kolonAdi> */

select o.OrderID,o.ShipAddress,o.Freight,e.FirstName,e.LastName from Orders o 
inner join Employees e on o.EmployeeID=e.EmployeeID --orders ýn içine employess tablosunu eklemiþ olduk

--Kategori adý,tedarikçi adý ve ürün adýný getiren sorguyu yazýnýz
select p.ProductName,s.CompanyName,c.CategoryName from Products p 
	inner join Suppliers s on p.SupplierID=s.SupplierID 
	inner join Categories c on p.CategoryID=c.CategoryID

--federal shipping ile taþýnmýþ ve nancy nin üzerine kayýtlý olan sipariþlerin çalýþan ýd çalýþan adý ve soyadýný,þirket adý,sipariþ ýd,sipariþ tarihi ve kargo ücretini getiren sorgu.
select e.EmployeeID,(e.FirstName+' '+e.LastName) as 'Çalýþan Adý Soyadý',s.CompanyName,o.OrderID,o.OrderDate,o.Freight from Orders o 
	inner join Shippers s on o.ShipVia=s.ShipperID 
	inner join Employees e on e.EmployeeID=o.EmployeeID 
	where s.CompanyName='federal shipping' and e.FirstName='nancy'

--en çok ürün alýnan tedarikçiyi almýþ olunan ürün miktarýna göre listeleyin.
select s.CompanyName,sum(p.UnitsInStock) from Suppliers s 
	inner join Products p on p.SupplierID=s.SupplierID 
	group by s.CompanyName 
	order by 2 desc

--hangi ülkelere ne kadarlýk satýþ yapýlmýþtýr?
select o.ShipCountry,round(sum(UnitPrice*Quantity*(1-discount)),3) 'Toplam Satýþ' from [Order Details] od 
	inner join Orders o on o.OrderID=od.OrderID
	group by ShipCountry order by 2 desc 

--en çok kar etmiþ olduðumuz ilk 3 ülke
select top 3 o.ShipCountry,round(sum(UnitPrice*Quantity*(1-discount)),3) 'Toplam Satýþ' from [Order Details] od 
	inner join Orders o on o.OrderID=od.OrderID
	group by ShipCountry order by 2 desc 

--her bir üründen toplam ne kadrlýk satýþ yapýlmýþtýr ve o ürün hangi kategoride
select p.ProductName 'Ürün Adý',round(sum(od.UnitPrice*od.Quantity*(1-od.Discount)),3) 'Toplam Satýþ',c.CategoryName 'Kategori Adý' from Products p inner join [Order Details] od on od.ProductID=p.ProductID
	inner join Categories c on c.CategoryID=p.CategoryID 
	group by p.ProductName,CategoryName

--hangi personel hangi kategoriden toplamda kaç adet ürün satýþý yapmýþtýr 
select (e.FirstName+' '+e.LastName) 'Ad Soyad',c.CategoryName 'kategori',sum(Quantity) 'toplam adet' from Employees e inner join Orders o on e.EmployeeID=o.EmployeeID
inner join [Order Details] od on od.OrderID=o.OrderID 
inner join Products p on p.ProductID=od.ProductID 
inner join Categories c on c.CategoryID=p.CategoryID
group by c.CategoryName,e.FirstName,e.LastName order by 3 desc

--hangi personel hangi kategoriden toplamda kaç adet ürün satýþý yapmýþtýr ilk 3 kim 
select top 3 (e.FirstName+' '+e.LastName) 'Ad Soyad',c.CategoryName 'kategori',sum(Quantity) 'toplam adet' from Employees e inner join Orders o on e.EmployeeID=o.EmployeeID
inner join [Order Details] od on od.OrderID=o.OrderID 
inner join Products p on p.ProductID=od.ProductID 
inner join Categories c on c.CategoryID=p.CategoryID
group by c.CategoryName,e.FirstName,e.LastName order by 3 desc

