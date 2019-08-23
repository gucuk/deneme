--hangi �al��an hangi �al��ana ba�l� listeleyin
select calisan.FirstName,mudur.FirstName from Employees calisan 
inner join Employees mudur on calisan.ReportsTo=mudur.EmployeeID

--inner join ba�lant�larda NULL olmayan de�erleri getirir. Yani bir tarafta de�er varsa ve di�er tarafta null kay�tlar varsa nul kay�tlar getirilmez.

--outer join: verilen y�ne g�re kay�tlar� getirir. �rne�in sol taraftaki belirlersek sol taraftaki kay�tlar� getirir sa� taraftaki kay�tlar null olabilir.

select (calisan.FirstName+' '+calisan.LastName) '�al��an', (mudur.FirstName+' '+mudur.LastName) 'M�d�r' from Employees calisan 
left outer join Employees mudur on calisan.ReportsTo=mudur.EmployeeID

--�al��anlar�m�n null olmayan kay�tlar�n� listeleyin(ad soyad), m�d�rlerimin b�t�n kay�tlar�n� getirin(null olabilir) ayn� zamanda �al��anlar�n ya�lar�.
select (calisan.FirstName+' '+calisan.LastName) '�al��an',(mudur.FirstName+' '+mudur.LastName) 'M�d�r',YEAR(GETDATE())-year(calisan.BirthDate) 'Ya�' from Employees calisan left outer join Employees mudur on calisan.ReportsTo=mudur.EmployeeID order by Ya� desc



