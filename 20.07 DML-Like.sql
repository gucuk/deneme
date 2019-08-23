--Like 

--ürün adýnda i harfi geçen ürünlerimi listeleyin
select * from Products where ProductName like '%i%' --% like iþlemlerinde hepsini temsil edere yüzde iþaretleri sýnýrlandýrma saðlar. burada öncesi ve sonrasý önemli deðil içinde i olanlarý getir anlamýna gelir. 

-- Çalýþanlarýmdan adý n harfi ile baþlayanlarý listele.
select * from Employees where FirstName like 'n%'

--3. karakteri a olmayan ürünleri listeleyin 
--I.YOl
select * from Products where ProductName not like '__a%'
--II.YOl
select * from Products where ProductName like '__[^a]%'

--3.karakteri a olmayan ve ikinci karakteri c olan ürünleri listele
select * from Products where ProductName like '_c[^a]%'
select * from Products where ProductName like '_c%' and ProductName not like '__a%'

--ürün adýnda _ karakteri olan ürünleri listeleyin.

select * from Products where ProductName like '%[_]%'

--genel müdür kim?
select * from Employees where ReportsTo is NULL

--'Dumon' ya da 'Alfki' CustomerID lerine sahip olan müþteriler tarafýndan alýnmýþ olan, 1 nolu personelin onaylandýðý,3 nolu kargo firmasý tarafýndan taþýnmýþ ve ShipRegion null olan sipariþleri getirin.
select * from Orders where CustomerID in ('dumon','alfki') and EmployeeID=1 and ShipVia=3 and ShipRegion is null 

--Japoncayý akýcý bir þekilde konuþan personelim kimdir?
select * from Employees where Notes like '%fluent%japanese%'

--Ülkesi ingiltere olmayan adý a ile baþlayan soyadý r ile biten doðum tarihi 1980 den önce olan çalýþan kimdir?
select * from Employees where Country<>'UK' 
and FirstName like 'a%'
and LastName like '%r' 
and Year(BirthDate)<1980








