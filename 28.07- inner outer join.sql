--hangi çalýþan hangi çalýþana baðlý listeleyin
select calisan.FirstName,mudur.FirstName from Employees calisan 
inner join Employees mudur on calisan.ReportsTo=mudur.EmployeeID

--inner join baðlantýlarda NULL olmayan deðerleri getirir. Yani bir tarafta deðer varsa ve diðer tarafta null kayýtlar varsa nul kayýtlar getirilmez.

--outer join: verilen yöne göre kayýtlarý getirir. Örneðin sol taraftaki belirlersek sol taraftaki kayýtlarý getirir sað taraftaki kayýtlar null olabilir.

select (calisan.FirstName+' '+calisan.LastName) 'Çalýþan', (mudur.FirstName+' '+mudur.LastName) 'Müdür' from Employees calisan 
left outer join Employees mudur on calisan.ReportsTo=mudur.EmployeeID

--Çalýþanlarýmýn null olmayan kayýtlarýný listeleyin(ad soyad), müdürlerimin bütün kayýtlarýný getirin(null olabilir) ayný zamanda çalýþanlarýn yaþlarý.
select (calisan.FirstName+' '+calisan.LastName) 'Çalýþan',(mudur.FirstName+' '+mudur.LastName) 'Müdür',YEAR(GETDATE())-year(calisan.BirthDate) 'Yaþ' from Employees calisan left outer join Employees mudur on calisan.ReportsTo=mudur.EmployeeID order by Yaþ desc



