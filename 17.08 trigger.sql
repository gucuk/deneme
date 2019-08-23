--Trigger(Tetikleyici)
	--bir tablo �zerinde Insert, Delete ve Update i�lemlerinden biri yap�ld���nda otomatik olarak devreye girmesini istedi�imiz i�lemlerimiz varsa bunu trigger kullanarak ger�ekle�tirebiliriz. 
	--Triggerler otomatik olarak tetiklenirler. Biz kendimiz istedi�imiz zaman tetikleyemeyiz. Triggerlar di�er yap�lardan farkl� olarak �al��aca�� zaman� kendisi belirler.
	--Triggerlar After ve instead of(yerine) olmak �zere ikiye ayr�l�r.

select * from Products
--En sonda bulunan discontinued kolonu ba�l� buludu�u veriyi silmek yerine veriyi saklamak i�in kullan�l�yor. Bu y�zden �rne�in Chai �r�n�n� silmek istendi�inde delete komutu yerine update komutu �al��t�rarak Discontinued kolonun de�erini 0 yerine 1 yap�larak silinmi� gibi g�sterebiliriz.

--Product tablosunda delete i�lemi g�nderildi�inde bunu yerine update i�lemi yapan trigger
create trigger DeleteProduct
on Products
instead of delete 
as
	--deleted
	--inserted
	declare @id int 
	select @id=ProductID from deleted
	update Products set Discontinued=1 where ProductID=@id
	--Kullan�m�
		select * from Products
		delete Products where ProductID=1

--after trigger:Tablo �zerinde belirli bir i�lemden sonra ba�ka bir i�lem yapmak i�in kullan�l�r.
select * from [Order Details]
select * from Products

--order details tablosunda kay�t girildi�inde sat�lan �r�n adedi kadar o �r�n�n sto�unda d��en trigger ya
create trigger StoktanDus
on [Order Details] 
after insert 
as
	declare @id int 
	declare @quantity smallint

	select @id=ProductID,@quantity=Quantity from inserted
	update Products set UnitsInStock-=@quantity where ProductID=@id

--Kullan�m
insert [Order Details] values (10248,1,5,10,0)

--Order details tablosunda bir kay�t silindi�inde product tablosundaki stok miktar�na silinen miktar� tekrar g�ncelleme yapt�ran trigger yaz.
alter trigger StokGuncelle
on [Order Details]
after delete 
as
	declare @id int
	declare @quantity smallint
	select @id=ProductID,@quantity=Quantity from deleted
	update Products set UnitsInStock=UnitsInStock+@quantity where ProductID=@id 

	delete from [Order Details] where OrderID=10248 and UnitPrice=5 and Quantity=10 
	select * from [Order Details]
	select * from Products

--yeni bir �al��an eklendi�inde �al��an bilgileri g�ncellendi�inde ve �al��an i�ten ayr�ld���nda bilgilendirme yapan trigger � yaz�n�z
create trigger CalisanDurumBilgilendirme
on Employees 
after delete,update,insert
as
	if exists(select * from inserted) and exists(select * from deleted)
		print '�al��an bilgisi g�ncellendi'
	
	else if exists(select * from inserted)
		print '��e yeni biri al�nd�'

	else 
		print '�al��an i�ten ayr�ld�'

insert Employees(FirstName,LastName,BirthDate) values ('Fatih','G�nalp','07-05-1985')

update Employees set HireDate=17-08-2019 where EmployeeID=11
delete Employees where EmployeeID=11
select * from Employees
----------------------------------------------------------------------------------------------------------------------------
--Personeller tablosunda bir kay�t silindi�inde silinen kayd�n ad�, soyad� ba�ka bir tabloya eklensin.
create table SilinenPersoneller(
ID int primary key identity(1,1) not null,
Isim nvarchar(50),
Soyisim nvarchar(50)
)

alter trigger SilinenPersonelTablo
on Employees
after delete 
as
	declare @id int
	declare @ad nvarchar(50)
	declare @soyad nvarchar(50)
		select @id=EmployeeID,@ad=FirstName,@soyad=LastName from deleted 
		insert SilinenPersoneller(Isim,Soyisim,SilinmeTarihi) values (@ad,@soyad,Getdate())

		delete Employees where EmployeeID=12
		select * from SilinenPersoneller

alter table SilinenPersoneller add SilinmeTarihi date











