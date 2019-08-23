select * from Products
--ürünlerimi kategorisine göre KDV dahil olarak listeleyin.
select ProductName,CategoryName,UnitPrice,ROUND((UnitPrice*0.08+UnitPrice),2) 'KDV Dahil Fiyat' from Products 
inner join Categories on Categories.CategoryID=Products.CategoryID 
group by ProductName,UnitPrice,CategoryName 

select ProductName,CategoryName,UnitPrice,SUM(UnitPrice*1.18) 'KDV Dahil Fiyat' from Products 
inner join Categories on Categories.CategoryID=Products.CategoryID 
group by ProductName,UnitPrice,CategoryName 

--KDV fiyatý 10 dan yüksek olanlarý listeleyin.
select ProductName,CategoryName,UnitPrice,SUM(UnitPrice*1.18) 'KDV Dahil Fiyat' from Products 
inner join Categories on Categories.CategoryID=Products.CategoryID 
group by ProductName,UnitPrice,CategoryName having SUM(UnitPrice*1.18)>10 order by [KDV Dahil Fiyat]


--bir sipariþin hangi çalýþan tarafýndan hangi müþteriye hangi kategorideki üründen hangi fiyattan kaç adet satýldýðýný listeleyin.
select (e.FirstName+' '+e.LastName) 'Çalýþan',c.CompanyName 'Müþteri',cat.CategoryName 'Kategori',p.ProductName 'Ürün Adý',od.UnitPrice 'Ürün Fiyatý',od.Quantity 'Ürün Adedi' from Customers c 
inner join Orders o on o.CustomerID=c.CustomerID
inner join Employees e on e.EmployeeID=o.EmployeeID
inner join [Order Details] od on od.OrderID=o.OrderID 
inner join Products p on p.ProductID=od.ProductID
inner join Categories cat on cat.CategoryID=p.CategoryID

--View: Sql server ortamýnda sanal tablo olarak kullanýlan gerçek tablodan veriyi alarak özetleyen tablolardýr. Anlýk deðil kalýcý olarak saklanan sql server objeleridir.

go
create view  vw_SatisRapolari 
as 
select (e.FirstName+' '+e.LastName) 'Çalýþan',c.CompanyName 'Müþteri',cat.CategoryName 'Kategori',p.ProductName 'Ürün Adý',od.UnitPrice 'Ürün Fiyatý',od.Quantity 'Ürün Adedi' from Customers c 
inner join Orders o on o.CustomerID=c.CustomerID
inner join Employees e on e.EmployeeID=o.EmployeeID
inner join [Order Details] od on od.OrderID=o.OrderID 
inner join Products p on p.ProductID=od.ProductID
inner join Categories cat on cat.CategoryID=p.CategoryID

select * from vw_SatisRapolari

--View ler genel olarak iki amaç için kullanýlýr.;
	--1-Karmaþýk sorgularý basitleþtirmek için,
	--2-Tablo eriþimlerini kullanýcý bazýnda kýsýtlayarak bu kullanýcýlarýn belirtilen tablolarýn belirtilen sütunlar eriþmesini saðlamak amacýyla kullanýlýr.

create view vw_Kategoriler
as
select CategoryName,Description from Categories

select * from vw_Kategoriler

--Kategoriler isimli viwe a bir de kategory ID dahil et 
alter view vw_Kategoriler
as 
(select CategoryID,CategoryName,Description from Categories)

select * from vw_Kategoriler
--Ýkisi ayný görevi yapar aþaðýdaki:
insert into vw_Kategoriler (CategoryName,Description) values ('Kozmetik','Kozmetik Ürünleri')
insert into vw_Kategoriler values('içecek','Soðuk içecekler')

drop view vw_Kategoriler

--Çalýþan bilgilerinden ad soyad görev þehir olanlarýna ait view oluþtur
alter view vw_CalisanBilgileri
as
select FirstName,LastName ,Title 'Görev',City 'Þehir' from Employees

select * from vw_CalisanBilgileri
--delete from employees select * from employees where employeID in(2010,2011) 2010 ve 2011 ýd ye sahip çalýþanlarý silecek
alter view vw_CalisanBilgileri
as
select (FirstName+' '+LastName) 'Çalýþan',Title 'Görev',City 'Þehir' from Employees where City='London'--Artýk insert iþleminde where kriterine uygun kayýtlarýn get

--view üzerinden yeni bir personel ekleyin
insert into vw_CalisanBilgileri values ('zeynep.', 'Gücük','müdür','Ýstanbul') 

--with check option 
alter view vw_CalisanBilgileri
as
select (FirstName+' '+LastName) 'Çalýþan',Title 'Görev',City 'Þehir' from Employees where City='London'
with check option 
insert into vw_CalisanBilgileri values ('Zeynep','Demircioðlu','Student','London')

--view ile encryption kullanýmý
--View i oluþturan kodlarýn baþkalarý tarafýndan görüntülenmesini istemiyorsak bu kodlarý þifreleyebiliriz.
--Ancak dikkat edilmesi gereken nokta,bu kodlar þifrelendikten sonra biz de göremeyiz bu nedenle kodlarý ayrý bir yerde saklamanýz gerekmektedir.
alter view vw_CalisanBilgileri
with encryption 
as
select (FirstName+' '+LastName) 'Çalýþan',Title 'Görev',City 'Þehir' from Employees where City='London'











