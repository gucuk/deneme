--RowSecurityDB veritabaný oluþturun 
create database RowSecurityDB
use RowSecurityDB
--3 adet kullanýcý ekleyin
create user fatih without login
create user zeynep without login
create user eda without login

--daha sonra öðrenci adýnda bir tablo oluþturun 
	--ýd,adi,vize,final,öðretmen
create table Ogrenci
(
	OgrenciID int primary key identity(1,1),
	Adi nvarchar(50),
	Soyadi  nvarchar(50),
	Vize smallint,
	Final smallint,
	Ogretmen  nvarchar(50)
)
--oluþturduðunuz tabloya oluþturduðumuz kullanýcýlar için select yetkisi verin
grant select on Ogrenci to fatih,zeynep,eda

--oluþturulan tabloya veri ekleyin
insert Ogrenci values ('Orta','va',60,70,'zeynep'),('tembel','ag',30,40,'eda')
--RLS yapabilmek için bir tane table valued function yazmamýz gereklidir.

create function fncRowLevelSecurity(
@kullanici nvarchar(50)) returns table
with schemabinding
as	
	return
		select 1 as UserRoLevel where @kullanici=USER_NAME();

--bu oluþturulan fonksiyondan sonra bir tane security policy objesi oluþturmanýz gerekiyor. Bu pbje dorgu esnasýnda devreye girerek fncRowLevelSecurity fonksiyonundan gelen deðere göre filtreleme yapacak.

create security policy RowFilterPolicy add filter predicate dbo.fncRowLevelSecurity(Ogretmen) on dbo.Ogrenci with(state=on)

--þimdi 3 kullanýcý ile sorgu çalýþtýralým
revert
exec as user='zeynep'
select * from Ogrenci
revert
exec as user='eda'
select * from Ogrenci

--filtrelemeyi pasif hale getirmek için
alter security policy RowFilterPolicy
with (state=off)

--filtrelemeyi aktif hale getirmek için
alter security policy RowFilterPolicy
with (state=on)