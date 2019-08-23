--Aggregate (Toplam Fonksiyonlarý,Gruplama Fonksiyonlarý)
/* 
Aggregate Fonksiyonlar select ifadesiyle kullanýlan geriye tek hücre olarak sonuç döndüren fonksiyonlardýr. Bütün deðerlerin toplam sonucu verir.
	1-count() toplam satýr adedini sayan fonk. geriye tek satýr ve tek sütun olarak döner.
	2-sum() toplama iþlemi
	3-avg() ortalama
	4-Min()
	5-Max()
*/
select * from Employees
--Count toplam satýr adedi
--employes tablosunda toplam kaç kayýt vardýr?
select count(*) as 'Toplam Kayýt' from Employees

--çalýþanlarýmýn þehirlerinin toplam sayýsý
select count(distinct City) from Employees

--sum()
--Employeýd sütunun toplamýný gösterin
select sum(EmployeeID) from Employees
select count(employeeID) from Employees

--çalýþanlarýn yaþlarý toplamý
--I.YOl
select sum((year(getdate())- year(birthdate))) as 'Yaþ Toplamý' from Employees
--II.Yol
select Sum(DATEDIFF(yy,BirthDate,GETDATE())) from Employees

--AVG
--Çalýþanlarýn yaþlarýnýn ortalamasý nedir
select avg(datediff(yy,BirthDate,GETDATE())) as 'Yaþ Ortalamasý' from Employees

--Min()
--stoktaki en düþük fiyatlý ürünün fiyatýný getirin
select min(UnitPrice) as 'En düþük fiyatlý ürün' from Products

--Þu ana kadarki toplam hasýlatý getirin 
select sum((UnitPrice-(UnitPrice*Discount))*Quantity) as 'Hasýlat' from [Order Details]






