--KategoriID si 2 olan �r�nlerin fiyat�n� 3 yap�n
 update Products set UnitPrice=3 where CategoryID=2
 select * from Products where CategoryID=2
 
--kategoriIDsi 1 olan �r�nlerin stok miktar�n� 10 artt�r�n
update Products set UnitsInStock=UnitsInStock+10 where CategoryID=1
 select * from Products where CategoryID=1

--d��ar�dan g�nderilen Id e g�re �al��an� getirin.
create function CalisanGetir(@ID int) returns table
as
return 
select * from Employees where EmployeeID=@ID
 
 select * from CalisanGetir(3)
