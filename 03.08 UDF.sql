/*
	UDF-User Defined Function
	*Geriye tek bir de�er d�nd�r�rler.Genellikle matematiksel i�lemlerde kullan�l�r.
	*Fonksiyolan geriye tek bir de�er veya tablo d�nd�rebilirler.
	*View lerden en b�y�k fark� parametre alan yap�lar� sa�layabilir.
	*De�er d�nd�ren fonksiyonlara Scalar Function, Tablo d�nd�ren fonksiyonlara da Table Value Function denir.
	Scalar Functions
	*Returns <tip>
*/
create function Topla(@sayi1 int,@sayi2 int) returns int
as
	begin 
			return @sayi1+@sayi2
	end

select dbo.Topla(5,3) as ToplamSonuc

--KDV oran�n� hesaplayan fonksiyonu tan�mla ve tan�mlad���n�z bu fonksiyonu sorguda kullan�n.
alter function KDVHesaplama(@fiyat money) returns money
as 
	begin 
		return @fiyat*1.18
	end
--fonksiyonu �a��rma ve sorguda kullanma:
select ProductName,UnitPrice 'KDV Hari� Fiyat',dbo.KDVHesaplama(UnitPrice) 'KDV Dahil Fiyat' from Products

--Ki�ilerin ya�lar�n� hesaplayan fonk yaz.
alter function yas(@dogum datetime) returns int
as
	begin	
		return year(getdate())-year(@dogum)
	end

select FirstName,LastName,dbo.yas(BirthDate) 'Ya�' from Employees

create function yas2(@dogum datetime) returns int
as
	begin
		return datediff(yy,@dogum,getdate())
	end
select FirstName,LastName,dbo.yas2(BirthDate) 'Ya�' from Employees

create function YasHesapla(@dogumTarihi datetime) returns int
as
	begin
		declare @yas int
		select @yas=datediff(yy,@dogumTarihi,getdate())
		return @yas
	end
select FirstName,LastName,dbo.YasHesapla(BirthDate) 'Ya�' from Employees

/*Table Value Functions
	*Scalar fonksiyonlar gibi d��ar�dan parametre alabilirler,
	*Fonksiyon kullan�mlar�nda schema ismi kullanmaya gerek yoktur.
	*geriye tablo d�nd�ren fonksiyonlarda begin end kullan�lmaz.
*/
--�al��an bilgilerini getiren fonksiyon
create function CalisanBilgileri(@employeeID int) returns table
return
	select * from Employees where EmployeeID=@employeeID

select * from CalisanBilgileri(5)

--isminin ba� harfine g�re �al��an listeleyen fonk. yaz.
alter function BasHarfCalisan(@harf nvarchar) returns table
return 
	select * from Employees where FirstName like @harf+'%'
select * from BasHarfCalisan('a')

--isminin ba� harfine g�re �al��an listeleyen fonk. yaz.
alter function BasHarfCalisan2(@harf nvarchar(1)) returns table
return 
	select * from Employees where left(FirstName,1)=@harf
select * from BasHarfCalisan2('ahmet')

--girilen category�d ye g�re ve girilen �al��an ismine g�re sat�lm�� �r�nlerin topla sat�� fiyat�n� g�steren fnk yaz. 2 nolu kategoriden andrew ne kadar sat�� yapm�� onu g�steren 