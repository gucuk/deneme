select ProductName,UnitPrice from Products

--�al��anlar tablosunda �al��anlara ait ad soyad g�rev ve do�umtarihi bilgilerini listele
select FirstName as 'Ad',LastName as 'Soyad',Title as 'G�rev',BirthDate 'Do�um Tarihi'  from Employees --se�mek istedi�imiz s�tunlar� aralar�na virg�l koyarak belirtiyoruz. S�tun isimlerinin intellisense men�s� ile gelmesi i�in select ifadesinden sonra from <tablo_Adi> yazman�z gerekmektedir.
--�al��anlar�m�n �ehirlerini listele
select City as '�ehir' from Employees

select distinct City from Employees -- sat�r tekrar�ndan kurtulmak i�in distinct kullan�yoruz


select TitleOfCourtesy,FirstName,LastName from Employees


select TitleOfCourtesy as 'Unvan',(FirstName+' '+LastName) as 'Ad Soyad' from Employees -- + ile metinleri birle�tirebiliyorum parantez i�ine alarak. Birle�tirdi�imiz tip say�sal olsayd� toplama i�lemi yapacakt�.


--Tedarik�ilerimin �irket adlar�n� listeleyin.
select CompanyName as 'Tedarik�iler' from Suppliers

--Kargo firmalar�n�n tel no ile listeleyin.
select CompanyName,Phone from Shippers

--�r�nlerimi sadee �r�n ad�,fiyat ve stok Bilgileri ile listeleyin.
select ProductName as '�r�n Ad�',UnitPrice as '�r�n Fiyat�',UnitsInStock as 'Stok Bilgileri'  from Products

--Sipari�lerimi sipari� numaras� ve adetleri ile listeleyin.
select OrderID as 'Sipari� Numaras�',Quantity as 'Miktar' from [Order Details]

select * from Products

