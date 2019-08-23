--KategoriID si 2 olan ürünlerin fiyatýný 3 yapýn
 update Products set UnitPrice=3 where CategoryID=2
 select * from Products where CategoryID=2
 
--kategoriIDsi 1 olan ürünlerin stok miktarýný 10 arttýrýn
update Products set UnitsInStock=UnitsInStock+10 where CategoryID=1
 select * from Products where CategoryID=1

--dýþarýdan gönderilen Id e göre çalýþaný getirin.
create function CalisanGetir(@ID int) returns table
as
return 
select * from Employees where EmployeeID=@ID
 
 select * from CalisanGetir(3)
