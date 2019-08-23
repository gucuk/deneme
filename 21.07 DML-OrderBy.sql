--S�ralama i�lemleri

--�al��anlar�mdan �al��an ID si 8 den k���k olanlar ve 2 den b�y�k olanlar� listeleyin
select * from Employees where EmployeeID<8 and EmployeeID>2 order by FirstName desc --ascending (artan)  descendig (azalan)
--�al��anlar tablosunu isim soyisim do�um tarihi olarak sorgulay�n ancak do�um tarihini artan s�ralama ile listeleyin
select FirstName,LastName,BirthDate from Employees order by BirthDate desc 

select FirstName,LastName,BirthDate from Employees order by 3 --sorguda yazd���n�z s�tunlar�n s�ras�na g�re s�ralama i�lemmi yapabilirsiniz.Burada ilk �nce 3. s�radaki kolona g�re yapt�k.

--�al��anlar�n isimlerini soyisimlerini ve ya�lar�n� getirin ya�lar�n� azdan �oka do�ru listeleyin.
select FirstName,LastName,(year(getdate())- Year(birthdate) ) as Ya� from Employees order by 3 
select FirstName,LastName,(DATEPART(yy,GETDATE())-datepart(yy,birthdate)) from Employees order by 3 

--Janet ile Robert aras�nda olanlar� azdan �oka do�ru listeleyiniz.
select * from Employees where FirstName between 'Janet' and 'Robert' order by FirstName


--�nvan� Mr. veya Dr. olanlar� listeleyin
select * from Employees where TitleOfCourtesy like 'Mr.' or TitleOfCourtesy like 'Dr.'
select * from Employees where TitleOfCourtesy='Mr.' or TitleOfCourtesy='Dr.'
select * from Employees where TitleOfCourtesy in ('dr.','mr.')
select * from Employees where TitleOfCourtesy like '_r.'

---1950,1955 ve 1960 y�llar�nda do�anlar� artan s�ralama ile listeleyin.
select * from Employees where year(BirthDate) in(1950,1955,1960) order by year(BirthDate)

--�al��anlar�m� unvanlar�na g�re listeleyin ancak unvanlar� ayn�ysa ya�lar�na g�re azalan listeleyin.
select firstname,lastname,TitleOfCourtesy,(Year(getdate())-year(birthdate)) as 'ya�' 
	from Employees order by TitleOfCourtesy,ya� desc


