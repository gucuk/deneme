--Like 

--�r�n ad�nda i harfi ge�en �r�nlerimi listeleyin
select * from Products where ProductName like '%i%' --% like i�lemlerinde hepsini temsil edere y�zde i�aretleri s�n�rland�rma sa�lar. burada �ncesi ve sonras� �nemli de�il i�inde i olanlar� getir anlam�na gelir. 

-- �al��anlar�mdan ad� n harfi ile ba�layanlar� listele.
select * from Employees where FirstName like 'n%'

--3. karakteri a olmayan �r�nleri listeleyin 
--I.YOl
select * from Products where ProductName not like '__a%'
--II.YOl
select * from Products where ProductName like '__[^a]%'

--3.karakteri a olmayan ve ikinci karakteri c olan �r�nleri listele
select * from Products where ProductName like '_c[^a]%'
select * from Products where ProductName like '_c%' and ProductName not like '__a%'

--�r�n ad�nda _ karakteri olan �r�nleri listeleyin.

select * from Products where ProductName like '%[_]%'

--genel m�d�r kim?
select * from Employees where ReportsTo is NULL

--'Dumon' ya da 'Alfki' CustomerID lerine sahip olan m��teriler taraf�ndan al�nm�� olan, 1 nolu personelin onayland���,3 nolu kargo firmas� taraf�ndan ta��nm�� ve ShipRegion null olan sipari�leri getirin.
select * from Orders where CustomerID in ('dumon','alfki') and EmployeeID=1 and ShipVia=3 and ShipRegion is null 

--Japoncay� ak�c� bir �ekilde konu�an personelim kimdir?
select * from Employees where Notes like '%fluent%japanese%'

--�lkesi ingiltere olmayan ad� a ile ba�layan soyad� r ile biten do�um tarihi 1980 den �nce olan �al��an kimdir?
select * from Employees where Country<>'UK' 
and FirstName like 'a%'
and LastName like '%r' 
and Year(BirthDate)<1980








