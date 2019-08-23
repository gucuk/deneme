--Aggregate (Toplam Fonksiyonlar�,Gruplama Fonksiyonlar�)
/* 
Aggregate Fonksiyonlar select ifadesiyle kullan�lan geriye tek h�cre olarak sonu� d�nd�ren fonksiyonlard�r. B�t�n de�erlerin toplam sonucu verir.
	1-count() toplam sat�r adedini sayan fonk. geriye tek sat�r ve tek s�tun olarak d�ner.
	2-sum() toplama i�lemi
	3-avg() ortalama
	4-Min()
	5-Max()
*/
select * from Employees
--Count toplam sat�r adedi
--employes tablosunda toplam ka� kay�t vard�r?
select count(*) as 'Toplam Kay�t' from Employees

--�al��anlar�m�n �ehirlerinin toplam say�s�
select count(distinct City) from Employees

--sum()
--Employe�d s�tunun toplam�n� g�sterin
select sum(EmployeeID) from Employees
select count(employeeID) from Employees

--�al��anlar�n ya�lar� toplam�
--I.YOl
select sum((year(getdate())- year(birthdate))) as 'Ya� Toplam�' from Employees
--II.Yol
select Sum(DATEDIFF(yy,BirthDate,GETDATE())) from Employees

--AVG
--�al��anlar�n ya�lar�n�n ortalamas� nedir
select avg(datediff(yy,BirthDate,GETDATE())) as 'Ya� Ortalamas�' from Employees

--Min()
--stoktaki en d���k fiyatl� �r�n�n fiyat�n� getirin
select min(UnitPrice) as 'En d���k fiyatl� �r�n' from Products

--�u ana kadarki toplam has�lat� getirin 
select sum((UnitPrice-(UnitPrice*Discount))*Quantity) as 'Has�lat' from [Order Details]






