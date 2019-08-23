--güncel tarihi getirme 
select GETDATE()

--Doðumgünü bugün olan çalýþanlarýn ad soyad doðumtarihini listeleyin.

--iþletim sisteminin diline baðlý olarak tarih formatý tr için g-a-y avrupa ve amerika için a-g-y
select MONTH(getdate())
select year(getdate())
select day(getdate())

select FirstName as 'Ad',LastName as 'Soyad',BirthDate as 'Doðum Tarihi' 
	from Employees where month(BirthDate)=month(getdate()) and day(BirthDate)=day(getdate())


--Datepart() bir tarih bilgisinden istediðimiz kýsmý elde etmemizi saðlar.

select FirstName,LastName,DATEPART(yy,BirthDate) from Employees 
	where DATEPART(yy,BirthDate)=1985
select FirstName,LastName,DATEPART(DY,BirthDate) from Employees 
select FirstName,LastName,DATEPART(M,BirthDate) from Employees 
select FirstName,LastName,DATEPART(DW,BirthDate) from Employees 