--Stored Procedure (Saklý Yordamlar)

/*
	Saklý yordamlar sql serveýn tablo objelerinden sonra en önemli objelerinden birisidir. Sp daha önce yazmýþ olduðunuz komutlarýn kapsüllendiði, server taraflý saklanan bir sql server objesidir.

		SP;
			-functionlar gibi parametre alabilirler,
			-tablo döndürebilirler,
			-insert,update,delete iþlemleri için kullanýlabilirler.
*/

create procedure UrunleriGetir
as
select * from Products

/*
	sp ler view ya da tablolar gibi çaðrýlmazlar yani select sorgusu ile çalýþmazlar. O yüzden oluþturulan sp'ler execute edilmelidir.
*/

execute UrunleriGetir

--------------------------------------------------------------------------

--Tüm kategoriler ile bu kategorilere ait ürünleri getiren sp yazýn.
create proc UrunlerveKategoriler
as
select p.ProductName,c.CategoryName from Categories c join Products p on c.CategoryID=p.CategoryID


exec UrunlerveKategoriler
-----------------------------------------------------------------------

--Kategorisine göre ürünleri getiren sp.
alter proc KategoriyeGoreUrun
@id int
as
	begin
			select p.ProductName,c.CategoryName,c.CategoryID from Categories c join Products p on c.CategoryID=p.CategoryID where c.CategoryID=@id
	end

exec KategoriyeGoreUrun 2
----------------------------------------------------------------------------

--Adýna ve soyadýna göre çalýþanlarý listeleyen sp.
create proc Calisanlar
@ad nvarchar(10),
@soyad nvarchar(20)
as
	select * from Employees where FirstName=@ad and LastName=@soyad

exec Calisanlar andrew,fuller
------------------------------------------------------------------------------

--Ürün ekleyen sp yazýn.
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
--karar yapýsý olarak aþðýda if-else bloðu kullandýk. if bloðu içerisine tanýmlamýþ kodlar () içerisinde yazmýþ olduðumuz koþul gerçekleþirse (true dönerse) print 'bu ürün daha önce eklenmiþ' bloðu çalýþacak, eðer true olarak gerçekleþmezse (false) o zaman else bloðu devreye girecektir.

--exists() fonksiyonu içerisine tanýmlamýþ oduðumuz sorgunun hali hazýrda olup olmadýðýný kontrol eder.
if(exists(select * from Products where ProductName=@urunAdi))
	begin
			
			print 'bu ürün daha önce eklenmiþ'



	end
else
	begin
			insert into Products(ProductName,UnitPrice,UnitsInStock) values (@urunAdi,@fiyat,@stok) 
	end



exec UrunEkle 'Kola',4,500

select * from Products

------------------------------------------------------------------------------

--müþteriler tablosuna yeni müþteri ekleyen sp yazýn.

alter proc MusteriEkle
@musteriId nchar(5),
@sirketAdi nvarchar(40),
@kisi nvarchar(30)='Belirtilmedi',
@adres nvarchar(100)='Belirtilmedi'
as
	insert into Customers(CustomerID,CompanyName,ContactName,Address) values (@musteriId,@sirketAdi,@kisi,@adres)
exec MusteriEkle 'BLGDM','Bilge Adam'

select * from Customers




--Ödev: Bütün sýnýf 17.08 tarihine kadar 5 adet veritabaný
											--blog
												--blog veritabaný içerisinde en az 5 adet blog eklensin insert komutu kullanarak ve ayný zamanda sp oluþturularak eklensin.
											--eticaret
												--5 adet ürün bu ürünlerin dahil olduðu 5 adet kategori
											--sinema
												
											--ekþisözlük
											--kütüphane


