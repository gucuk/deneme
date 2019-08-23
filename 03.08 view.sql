select * from Products
--�r�nlerimi kategorisine g�re KDV dahil olarak listeleyin.
select ProductName,CategoryName,UnitPrice,ROUND((UnitPrice*0.08+UnitPrice),2) 'KDV Dahil Fiyat' from Products 
inner join Categories on Categories.CategoryID=Products.CategoryID 
group by ProductName,UnitPrice,CategoryName 

select ProductName,CategoryName,UnitPrice,SUM(UnitPrice*1.18) 'KDV Dahil Fiyat' from Products 
inner join Categories on Categories.CategoryID=Products.CategoryID 
group by ProductName,UnitPrice,CategoryName 

--KDV fiyat� 10 dan y�ksek olanlar� listeleyin.
select ProductName,CategoryName,UnitPrice,SUM(UnitPrice*1.18) 'KDV Dahil Fiyat' from Products 
inner join Categories on Categories.CategoryID=Products.CategoryID 
group by ProductName,UnitPrice,CategoryName having SUM(UnitPrice*1.18)>10 order by [KDV Dahil Fiyat]


--bir sipari�in hangi �al��an taraf�ndan hangi m��teriye hangi kategorideki �r�nden hangi fiyattan ka� adet sat�ld���n� listeleyin.
select (e.FirstName+' '+e.LastName) '�al��an',c.CompanyName 'M��teri',cat.CategoryName 'Kategori',p.ProductName '�r�n Ad�',od.UnitPrice '�r�n Fiyat�',od.Quantity '�r�n Adedi' from Customers c 
inner join Orders o on o.CustomerID=c.CustomerID
inner join Employees e on e.EmployeeID=o.EmployeeID
inner join [Order Details] od on od.OrderID=o.OrderID 
inner join Products p on p.ProductID=od.ProductID
inner join Categories cat on cat.CategoryID=p.CategoryID

--View: Sql server ortam�nda sanal tablo olarak kullan�lan ger�ek tablodan veriyi alarak �zetleyen tablolard�r. Anl�k de�il kal�c� olarak saklanan sql server objeleridir.

go
create view  vw_SatisRapolari 
as 
select (e.FirstName+' '+e.LastName) '�al��an',c.CompanyName 'M��teri',cat.CategoryName 'Kategori',p.ProductName '�r�n Ad�',od.UnitPrice '�r�n Fiyat�',od.Quantity '�r�n Adedi' from Customers c 
inner join Orders o on o.CustomerID=c.CustomerID
inner join Employees e on e.EmployeeID=o.EmployeeID
inner join [Order Details] od on od.OrderID=o.OrderID 
inner join Products p on p.ProductID=od.ProductID
inner join Categories cat on cat.CategoryID=p.CategoryID

select * from vw_SatisRapolari

--View ler genel olarak iki ama� i�in kullan�l�r.;
	--1-Karma��k sorgular� basitle�tirmek i�in,
	--2-Tablo eri�imlerini kullan�c� baz�nda k�s�tlayarak bu kullan�c�lar�n belirtilen tablolar�n belirtilen s�tunlar eri�mesini sa�lamak amac�yla kullan�l�r.

create view vw_Kategoriler
as
select CategoryName,Description from Categories

select * from vw_Kategoriler

--Kategoriler isimli viwe a bir de kategory ID dahil et 
alter view vw_Kategoriler
as 
(select CategoryID,CategoryName,Description from Categories)

select * from vw_Kategoriler
--�kisi ayn� g�revi yapar a�a��daki:
insert into vw_Kategoriler (CategoryName,Description) values ('Kozmetik','Kozmetik �r�nleri')
insert into vw_Kategoriler values('i�ecek','So�uk i�ecekler')

drop view vw_Kategoriler

--�al��an bilgilerinden ad soyad g�rev �ehir olanlar�na ait view olu�tur
alter view vw_CalisanBilgileri
as
select FirstName,LastName ,Title 'G�rev',City '�ehir' from Employees

select * from vw_CalisanBilgileri
--delete from employees select * from employees where employeID in(2010,2011) 2010 ve 2011 �d ye sahip �al��anlar� silecek
alter view vw_CalisanBilgileri
as
select (FirstName+' '+LastName) '�al��an',Title 'G�rev',City '�ehir' from Employees where City='London'--Art�k insert i�leminde where kriterine uygun kay�tlar�n get

--view �zerinden yeni bir personel ekleyin
insert into vw_CalisanBilgileri values ('zeynep.', 'G�c�k','m�d�r','�stanbul') 

--with check option 
alter view vw_CalisanBilgileri
as
select (FirstName+' '+LastName) '�al��an',Title 'G�rev',City '�ehir' from Employees where City='London'
with check option 
insert into vw_CalisanBilgileri values ('Zeynep','Demircio�lu','Student','London')

--view ile encryption kullan�m�
--View i olu�turan kodlar�n ba�kalar� taraf�ndan g�r�nt�lenmesini istemiyorsak bu kodlar� �ifreleyebiliriz.
--Ancak dikkat edilmesi gereken nokta,bu kodlar �ifrelendikten sonra biz de g�remeyiz bu nedenle kodlar� ayr� bir yerde saklaman�z gerekmektedir.
alter view vw_CalisanBilgileri
with encryption 
as
select (FirstName+' '+LastName) '�al��an',Title 'G�rev',City '�ehir' from Employees where City='London'











