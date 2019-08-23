--g�ncel tarihi getirme 
select GETDATE()

--Do�umg�n� bug�n olan �al��anlar�n ad soyad do�umtarihini listeleyin.

--i�letim sisteminin diline ba�l� olarak tarih format� tr i�in g-a-y avrupa ve amerika i�in a-g-y
select MONTH(getdate())
select year(getdate())
select day(getdate())

select FirstName as 'Ad',LastName as 'Soyad',BirthDate as 'Do�um Tarihi' 
	from Employees where month(BirthDate)=month(getdate()) and day(BirthDate)=day(getdate())


--Datepart() bir tarih bilgisinden istedi�imiz k�sm� elde etmemizi sa�lar.

select FirstName,LastName,DATEPART(yy,BirthDate) from Employees 
	where DATEPART(yy,BirthDate)=1985
select FirstName,LastName,DATEPART(DY,BirthDate) from Employees 
select FirstName,LastName,DATEPART(M,BirthDate) from Employees 
select FirstName,LastName,DATEPART(DW,BirthDate) from Employees 