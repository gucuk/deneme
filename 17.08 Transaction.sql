--Transaction(iþlem)
	--birden fazla iþlemin ard arda yapýldýðý durumlarda eðer parçayý oluþturan iþlemlerden hernhangi birinde sorun oluþtuðunda tüm iþlemi iptal etmeye yarar ve belirtilen iþlemi geri alýr.

select * from Categories
insert into Categories(CategoryName,Description) values ('Yemekler','Sýcak ve Soðuk Yemekler')	
begin tran
delete from Categories where CategoryID=9
rollback tran

-- bir banka havalesi iþleminde havale emri verildiðinde arka tarafta eðer bir sorun oluþursa havale iþlemi gerçekleþmeyecektir. Bu durumda havale iþlemi sýrasýnda kesilen tutar karþý tarafa yatýrýlmadýðý için tutar kaybolacaktýr. Bu gibi durumlarda transaction kullanýlmalýdýr. Yani herhangi bir sorun oluþtuðunda iþlem geri alýnmalýdýr.

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
--Havale iþlemi yapan sp yaz.
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
--hocanýn yazdýðý
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