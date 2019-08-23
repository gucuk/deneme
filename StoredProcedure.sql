--Stored Procedure (Sakl� Yordamlar)

/*
	Sakl� yordamlar sql serve�n tablo objelerinden sonra en �nemli objelerinden birisidir. Sp daha �nce yazm�� oldu�unuz komutlar�n kaps�llendi�i, server tarafl� saklanan bir sql server objesidir.

		SP;
			-functionlar gibi parametre alabilirler,
			-tablo d�nd�rebilirler,
			-insert,update,delete i�lemleri i�in kullan�labilirler.
*/

create procedure UrunleriGetir
as
select * from Products

/*
	sp ler view ya da tablolar gibi �a�r�lmazlar yani select sorgusu ile �al��mazlar. O y�zden olu�turulan sp'ler execute edilmelidir.
*/

execute UrunleriGetir

--------------------------------------------------------------------------

--T�m kategoriler ile bu kategorilere ait �r�nleri getiren sp yaz�n.
create proc UrunlerveKategoriler
as
select p.ProductName,c.CategoryName from Categories c join Products p on c.CategoryID=p.CategoryID


exec UrunlerveKategoriler
-----------------------------------------------------------------------

--Kategorisine g�re �r�nleri getiren sp.
alter proc KategoriyeGoreUrun
@id int
as
	begin
			select p.ProductName,c.CategoryName,c.CategoryID from Categories c join Products p on c.CategoryID=p.CategoryID where c.CategoryID=@id
	end

exec KategoriyeGoreUrun 2
----------------------------------------------------------------------------

--Ad�na ve soyad�na g�re �al��anlar� listeleyen sp.
create proc Calisanlar
@ad nvarchar(10),
@soyad nvarchar(20)
as
	select * from Employees where FirstName=@ad and LastName=@soyad

exec Calisanlar andrew,fuller
------------------------------------------------------------------------------

--�r�n ekleyen sp yaz�n.
create proc UrunEkle
@urunAdi nvarchar(20),
@fiyat money,
@stok smallint
as
insert into Products(ProductName,UnitPrice,UnitsInStock) values (@urunAdi,@fiyat,@stok) 


exec UrunEkle 'Armut',10,100

-----------------------------------------------
alter proc UrunEkle
@urunAdi nvarchar(20),
@fiyat money,
@stok smallint
as
--karar yap�s� olarak a���da if-else blo�u kulland�k. if blo�u i�erisine tan�mlam�� kodlar () i�erisinde yazm�� oldu�umuz ko�ul ger�ekle�irse (true d�nerse) print 'bu �r�n daha �nce eklenmi�' blo�u �al��acak, e�er true olarak ger�ekle�mezse (false) o zaman else blo�u devreye girecektir.

--exists() fonksiyonu i�erisine tan�mlam�� odu�umuz sorgunun hali haz�rda olup olmad���n� kontrol eder.
if(exists(select * from Products where ProductName=@urunAdi))
	begin
			
			print 'bu �r�n daha �nce eklenmi�'



	end
else
	begin
			insert into Products(ProductName,UnitPrice,UnitsInStock) values (@urunAdi,@fiyat,@stok) 
	end



exec UrunEkle 'Kola',4,500

select * from Products

------------------------------------------------------------------------------

--m��teriler tablosuna yeni m��teri ekleyen sp yaz�n.

alter proc MusteriEkle
@musteriId nchar(5),
@sirketAdi nvarchar(40),
@kisi nvarchar(30)='Belirtilmedi',
@adres nvarchar(100)='Belirtilmedi'
as
	insert into Customers(CustomerID,CompanyName,ContactName,Address) values (@musteriId,@sirketAdi,@kisi,@adres)
exec MusteriEkle 'BLGDM','Bilge Adam'

select * from Customers




--�dev: B�t�n s�n�f 17.08 tarihine kadar 5 adet veritaban�
											--blog
												--blog veritaban� i�erisinde en az 5 adet blog eklensin insert komutu kullanarak ve ayn� zamanda sp olu�turularak eklensin.
											--eticaret
												--5 adet �r�n bu �r�nlerin dahil oldu�u 5 adet kategori
											--sinema
												
											--ek�is�zl�k
											--k�t�phane


