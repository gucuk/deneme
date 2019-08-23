--RowSecurityDB veritaban� olu�turun 
create database RowSecurityDB
use RowSecurityDB
--3 adet kullan�c� ekleyin
create user fatih without login
create user zeynep without login
create user eda without login

--daha sonra ��renci ad�nda bir tablo olu�turun 
	--�d,adi,vize,final,��retmen
create table Ogrenci
(
	OgrenciID int primary key identity(1,1),
	Adi nvarchar(50),
	Soyadi  nvarchar(50),
	Vize smallint,
	Final smallint,
	Ogretmen  nvarchar(50)
)
--olu�turdu�unuz tabloya olu�turdu�umuz kullan�c�lar i�in select yetkisi verin
grant select on Ogrenci to fatih,zeynep,eda

--olu�turulan tabloya veri ekleyin
insert Ogrenci values ('Orta','va',60,70,'zeynep'),('tembel','ag',30,40,'eda')
--RLS yapabilmek i�in bir tane table valued function yazmam�z gereklidir.

create function fncRowLevelSecurity(
@kullanici nvarchar(50)) returns table
with schemabinding
as	
	return
		select 1 as UserRoLevel where @kullanici=USER_NAME();

--bu olu�turulan fonksiyondan sonra bir tane security policy objesi olu�turman�z gerekiyor. Bu pbje dorgu esnas�nda devreye girerek fncRowLevelSecurity fonksiyonundan gelen de�ere g�re filtreleme yapacak.

create security policy RowFilterPolicy add filter predicate dbo.fncRowLevelSecurity(Ogretmen) on dbo.Ogrenci with(state=on)

--�imdi 3 kullan�c� ile sorgu �al��t�ral�m
revert
exec as user='zeynep'
select * from Ogrenci
revert
exec as user='eda'
select * from Ogrenci

--filtrelemeyi pasif hale getirmek i�in
alter security policy RowFilterPolicy
with (state=off)

--filtrelemeyi aktif hale getirmek i�in
alter security policy RowFilterPolicy
with (state=on)