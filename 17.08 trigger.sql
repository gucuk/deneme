--Trigger(Tetikleyici)
	--bir tablo üzerinde Insert, Delete ve Update iþlemlerinden biri yapýldýðýnda otomatik olarak devreye girmesini istediðimiz iþlemlerimiz varsa bunu trigger kullanarak gerçekleþtirebiliriz. 
	--Triggerler otomatik olarak tetiklenirler. Biz kendimiz istediðimiz zaman tetikleyemeyiz. Triggerlar diðer yapýlardan farklý olarak çalýþacaðý zamaný kendisi belirler.
	--Triggerlar After ve instead of(yerine) olmak üzere ikiye ayrýlýr.

select * from Products
--En sonda bulunan discontinued kolonu baðlý buluduðu veriyi silmek yerine veriyi saklamak için kullanýlýyor. Bu yüzden örneðin Chai ürününü silmek istendiðinde delete komutu yerine update komutu çalýþtýrarak Discontinued kolonun deðerini 0 yerine 1 yapýlarak silinmiþ gibi gösterebiliriz.

--Product tablosunda delete iþlemi gönderildiðinde bunu yerine update iþlemi yapan trigger
create trigger DeleteProduct
on Products
instead of delete 
as
	--deleted
	--inserted
	declare @id int 
	select @id=ProductID from deleted
	update Products set Discontinued=1 where ProductID=@id
	--Kullanýmý
		select * from Products
		delete Products where ProductID=1

--after trigger:Tablo üzerinde belirli bir iþlemden sonra baþka bir iþlem yapmak için kullanýlýr.
select * from [Order Details]
select * from Products

--order details tablosunda kayýt girildiðinde satýlan ürün adedi kadar o ürünün stoðunda düþen trigger ya
create trigger StoktanDus
on [Order Details] 
after insert 
as
	declare @id int 
	declare @quantity smallint

	select @id=ProductID,@quantity=Quantity from inserted
	update Products set UnitsInStock-=@quantity where ProductID=@id

--Kullaným
insert [Order Details] values (10248,1,5,10,0)

--Order details tablosunda bir kayýt silindiðinde product tablosundaki stok miktarýna silinen miktarý tekrar güncelleme yaptýran trigger yaz.
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

--yeni bir çalýþan eklendiðinde çalýþan bilgileri güncellendiðinde ve çalýþan iþten ayrýldýðýnda bilgilendirme yapan trigger ý yazýnýz
create trigger CalisanDurumBilgilendirme
on Employees 
after delete,update,insert
as
	if exists(select * from inserted) and exists(select * from deleted)
		print 'Çalýþan bilgisi güncellendi'
	
	else if exists(select * from inserted)
		print 'Ýþe yeni biri alýndý'

	else 
		print 'Çalýþan iþten ayrýldý'

insert Employees(FirstName,LastName,BirthDate) values ('Fatih','Günalp','07-05-1985')

update Employees set HireDate=17-08-2019 where EmployeeID=11
delete Employees where EmployeeID=11
select * from Employees
----------------------------------------------------------------------------------------------------------------------------
--Personeller tablosunda bir kayýt silindiðinde silinen kaydýn adý, soyadý baþka bir tabloya eklensin.
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











