--Json (Javascript Object Notation)

--native json : Sql server 2016 ile gelen özelliktir. Gerçek veriyi json olarak görmemizi saðlar. Sorumuzun sonucuna for json auto ve json path komutlarýmýzý eklediðimzide veri json a çevrilecektir.

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
	('Ersin','Koç','ersin','1234','ersin@e.com',33),
	('Fatih','Günalp','fatih','1234','fatih.gunalp@bilgeadam.com',34),
	('Zeynep','Demircioðlu','zeynep','1234','zeyep@z.com',22)

--Bu bölümde sonuç result seti table deðil de texy olarak deðiþtirirsek verileri daha okunur görürüz. result ser in table yerine text gelmesini istiyorsak sað týk => result to => result to text yapabiliriz.
	
	select 
	Adi as 'Kullanici.Isim',
	Soyadi as 'Kullanici.Soyad',
	Email as 'Kullanici.Email'
	from Kullanicilar for json auto

--for json auto ve for json path arasýndaki fark.
select 
Adi as 'Kullanici.Isim',
Soyadi as 'Kullanici.Soyad',
Yasi as 'Kullanici.Yasi'
from Kullanicilar for json path

--json fonksiyonlarý
--1_OpenJson :Parametre olarak verilen json datayý tablo olarak bize döndürür.
	--parametre olarak verilen json datanýn formatýna uygunluðunu kontrol eder ve 1 veya 0 döndürür.

	select * from OpenJson('{"Adý":"Fatih","Soyadý":"Günalp","Yas":"34"}')