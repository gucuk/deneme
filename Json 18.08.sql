--Json (Javascript Object Notation)

--native json : Sql server 2016 ile gelen �zelliktir. Ger�ek veriyi json olarak g�rmemizi sa�lar. Sorumuzun sonucuna for json auto ve json path komutlar�m�z� ekledi�imzide veri json a �evrilecektir.

create database NativeJsonDB
use NativeJsonDB
create table Kullanicilar
(
	ID int primary key identity(1,1),
	Adi nvarchar(50),
	Soyadi nvarchar(50),
	KullaniciAdi nvarchar(50),
	Sifre nvarchar(50),
	KayitTarihi datetime default(getdate()),
	Yasi int
)
  alter table Kullanicilar add Email nvarchar(50)

  insert Kullanicilar(Adi,Soyadi,KullaniciAdi,Sifre,Email,Yasi) 
	values 
	('Ersin','Ko�','ersin','1234','ersin@e.com',33),
	('Fatih','G�nalp','fatih','1234','fatih.gunalp@bilgeadam.com',34),
	('Zeynep','Demircio�lu','zeynep','1234','zeyep@z.com',22)

--Bu b�l�mde sonu� result seti table de�il de texy olarak de�i�tirirsek verileri daha okunur g�r�r�z. result ser in table yerine text gelmesini istiyorsak sa� t�k => result to => result to text yapabiliriz.
	
	select 
	Adi as 'Kullanici.Isim',
	Soyadi as 'Kullanici.Soyad',
	Email as 'Kullanici.Email'
	from Kullanicilar for json auto

--for json auto ve for json path aras�ndaki fark.
select 
Adi as 'Kullanici.Isim',
Soyadi as 'Kullanici.Soyad',
Yasi as 'Kullanici.Yasi'
from Kullanicilar for json path

--json fonksiyonlar�
--1_OpenJson :Parametre olarak verilen json datay� tablo olarak bize d�nd�r�r.
	--parametre olarak verilen json datan�n format�na uygunlu�unu kontrol eder ve 1 veya 0 d�nd�r�r.

	select * from OpenJson('{"Ad�":"Fatih","Soyad�":"G�nalp","Yas":"34"}')