--Transaction(i�lem)
	--birden fazla i�lemin ard arda yap�ld��� durumlarda e�er par�ay� olu�turan i�lemlerden hernhangi birinde sorun olu�tu�unda t�m i�lemi iptal etmeye yarar ve belirtilen i�lemi geri al�r.

select * from Categories
insert into Categories(CategoryName,Description) values ('Yemekler','S�cak ve So�uk Yemekler')	
begin tran
delete from Categories where CategoryID=9
rollback tran

-- bir banka havalesi i�leminde havale emri verildi�inde arka tarafta e�er bir sorun olu�ursa havale i�lemi ger�ekle�meyecektir. Bu durumda havale i�lemi s�ras�nda kesilen tutar kar�� tarafa yat�r�lmad��� i�in tutar kaybolacakt�r. Bu gibi durumlarda transaction kullan�lmal�d�r. Yani herhangi bir sorun olu�tu�unda i�lem geri al�nmal�d�r.

create database BilgeBankDB
go
use BilgeBankDB
create table Hesaplar (
ID int primary key identity(1,1) not null,
HesapAdi nvarchar(50),
Bakiye money
)
insert Hesaplar values ('Ersin',1000),('Eda',500)

select * from Hesaplar
--Havale i�lemi yapan sp yaz.
alter proc Havale
@gonderenHesap nvarchar(50),
@aliciHesap nvarchar(50),
@havaleMiktari money
as
	begin try
update Hesaplar set Bakiye=bakiye-@havaleMiktari where HesapAdi=@gonderenHesap
	declare @hata int=5/0
update Hesaplar set Bakiye=bakiye+@havaleMiktari where HesapAdi=@aliciHesap
end try
begin catch
print 'Hata meydana geldi'
end catch
--hocan�n yazd���
update Hesaplar set Bakiye-=@havaleMiktari where HesapAdi=@gonderenHesap
update Hesaplar set Bakiye+=@havaleMiktari where HesapAdi=@aliciHesap
exec Havale 'Ersin','Eda',500

-----------------------------------------------------------------
alter proc Havale
@gonderenHesap nvarchar(50),
@aliciHesap nvarchar(50),
@havaleMiktari money
as
	begin try
	begin tran
update Hesaplar set Bakiye=bakiye-@havaleMiktari where HesapAdi=@gonderenHesap
	declare @hata int=5/0
update Hesaplar set Bakiye=bakiye+@havaleMiktari where HesapAdi=@aliciHesap
commit tran
end try
begin catch
rollback tran
	print 'Hata meydana geldi'
end catch

select * from Hesaplar
exec Havale 'Eda','Ersin',1000