--Sýralama iþlemleri

--Çalýþanlarýmdan çalýþan ID si 8 den küçük olanlar ve 2 den büyük olanlarý listeleyin
select * from Employees where EmployeeID<8 and EmployeeID>2 order by FirstName desc --ascending (artan)  descendig (azalan)
--Çalýþanlar tablosunu isim soyisim doðum tarihi olarak sorgulayýn ancak doðum tarihini artan sýralama ile listeleyin
select FirstName,LastName,BirthDate from Employees order by BirthDate desc 

select FirstName,LastName,BirthDate from Employees order by 3 --sorguda yazdýðýnýz sütunlarýn sýrasýna göre sýralama iþlemmi yapabilirsiniz.Burada ilk önce 3. sýradaki kolona göre yaptýk.

--çalýþanlarýn isimlerini soyisimlerini ve yaþlarýný getirin yaþlarýný azdan çoka doðru listeleyin.
select FirstName,LastName,(year(getdate())- Year(birthdate) ) as Yaþ from Employees order by 3 
select FirstName,LastName,(DATEPART(yy,GETDATE())-datepart(yy,birthdate)) from Employees order by 3 

--Janet ile Robert arasýnda olanlarý azdan çoka doðru listeleyiniz.
select * from Employees where FirstName between 'Janet' and 'Robert' order by FirstName


--ünvaný Mr. veya Dr. olanlarý listeleyin
select * from Employees where TitleOfCourtesy like 'Mr.' or TitleOfCourtesy like 'Dr.'
select * from Employees where TitleOfCourtesy='Mr.' or TitleOfCourtesy='Dr.'
select * from Employees where TitleOfCourtesy in ('dr.','mr.')
select * from Employees where TitleOfCourtesy like '_r.'

---1950,1955 ve 1960 yýllarýnda doðanlarý artan sýralama ile listeleyin.
select * from Employees where year(BirthDate) in(1950,1955,1960) order by year(BirthDate)

--Çalýþanlarýmý unvanlarýna göre listeleyin ancak unvanlarý aynýysa yaþlarýna göre azalan listeleyin.
select firstname,lastname,TitleOfCourtesy,(Year(getdate())-year(birthdate)) as 'yaþ' 
	from Employees order by TitleOfCourtesy,yaþ desc


