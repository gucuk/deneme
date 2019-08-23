select ProductName,UnitPrice from Products

--Çalýþanlar tablosunda çalýþanlara ait ad soyad görev ve doðumtarihi bilgilerini listele
select FirstName as 'Ad',LastName as 'Soyad',Title as 'Görev',BirthDate 'Doðum Tarihi'  from Employees --seçmek istediðimiz sütunlarý aralarýna virgül koyarak belirtiyoruz. Sütun isimlerinin intellisense menüsü ile gelmesi için select ifadesinden sonra from <tablo_Adi> yazmanýz gerekmektedir.
--Çalýþanlarýmýn þehirlerini listele
select City as 'Þehir' from Employees

select distinct City from Employees -- satýr tekrarýndan kurtulmak için distinct kullanýyoruz


select TitleOfCourtesy,FirstName,LastName from Employees


select TitleOfCourtesy as 'Unvan',(FirstName+' '+LastName) as 'Ad Soyad' from Employees -- + ile metinleri birleþtirebiliyorum parantez içine alarak. Birleþtirdiðimiz tip sayýsal olsaydý toplama iþlemi yapacaktý.


--Tedarikçilerimin þirket adlarýný listeleyin.
select CompanyName as 'Tedarikçiler' from Suppliers

--Kargo firmalarýnýn tel no ile listeleyin.
select CompanyName,Phone from Shippers

--Ürünlerimi sadee ürün adý,fiyat ve stok Bilgileri ile listeleyin.
select ProductName as 'Ürün Adý',UnitPrice as 'Ürün Fiyatý',UnitsInStock as 'Stok Bilgileri'  from Products

--Sipariþlerimi sipariþ numarasý ve adetleri ile listeleyin.
select OrderID as 'Sipariþ Numarasý',Quantity as 'Miktar' from [Order Details]

select * from Products

