/*
	UDF-User Defined Function
	*Geriye tek bir deðer döndürürler.Genellikle matematiksel iþlemlerde kullanýlýr.
	*Fonksiyolan geriye tek bir deðer veya tablo döndürebilirler.
	*View lerden en büyük farký parametre alan yapýlarý saðlayabilir.
	*Deðer döndüren fonksiyonlara Scalar Function, Tablo döndüren fonksiyonlara da Table Value Function denir.
	Scalar Functions
	*Returns <tip>
*/
create function Topla(@sayi1 int,@sayi2 int) returns int
as
	begin 
			return @sayi1+@sayi2
	end

select dbo.Topla(5,3) as ToplamSonuc

--KDV oranýný hesaplayan fonksiyonu tanýmla ve tanýmladýðýnýz bu fonksiyonu sorguda kullanýn.
alter function KDVHesaplama(@fiyat money) returns money
as 
	begin 
		return @fiyat*1.18
	end
--fonksiyonu çaðýrma ve sorguda kullanma:
select ProductName,UnitPrice 'KDV Hariç Fiyat',dbo.KDVHesaplama(UnitPrice) 'KDV Dahil Fiyat' from Products

--Kiþilerin yaþlarýný hesaplayan fonk yaz.
alter function yas(@dogum datetime) returns int
as
	begin	
		return year(getdate())-year(@dogum)
	end

select FirstName,LastName,dbo.yas(BirthDate) 'Yaþ' from Employees

create function yas2(@dogum datetime) returns int
as
	begin
		return datediff(yy,@dogum,getdate())
	end
select FirstName,LastName,dbo.yas2(BirthDate) 'Yaþ' from Employees

create function YasHesapla(@dogumTarihi datetime) returns int
as
	begin
		declare @yas int
		select @yas=datediff(yy,@dogumTarihi,getdate())
		return @yas
	end
select FirstName,LastName,dbo.YasHesapla(BirthDate) 'Yaþ' from Employees

/*Table Value Functions
	*Scalar fonksiyonlar gibi dýþarýdan parametre alabilirler,
	*Fonksiyon kullanýmlarýnda schema ismi kullanmaya gerek yoktur.
	*geriye tablo döndüren fonksiyonlarda begin end kullanýlmaz.
*/
--Çalýþan bilgilerini getiren fonksiyon
create function CalisanBilgileri(@employeeID int) returns table
return
	select * from Employees where EmployeeID=@employeeID

select * from CalisanBilgileri(5)

--isminin baþ harfine göre çalýþan listeleyen fonk. yaz.
alter function BasHarfCalisan(@harf nvarchar) returns table
return 
	select * from Employees where FirstName like @harf+'%'
select * from BasHarfCalisan('a')

--isminin baþ harfine göre çalýþan listeleyen fonk. yaz.
alter function BasHarfCalisan2(@harf nvarchar(1)) returns table
return 
	select * from Employees where left(FirstName,1)=@harf
select * from BasHarfCalisan2('ahmet')

--girilen categoryýd ye göre ve girilen çalýþan ismine göre satýlmýþ ürünlerin topla satýþ fiyatýný gösteren fnk yaz. 2 nolu kategoriden andrew ne kadar satýþ yapmýþ onu gösteren 