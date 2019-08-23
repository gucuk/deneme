
--�rnek Sorgular

--Stokta hangi tedarik�iden ortalama ka� �r�n vard�r? �oktan aza do�ru listeleyin.
select s.CompanyName,p.ProductName,AVG(p.UnitsInStock) from Suppliers s 
inner join Products p on p.SupplierID=s.SupplierID group by s.CompanyName, p.ProductName


--250'den fazla sipari� ta��m�� olan kargo firmalar�n�n adlar�n�, telefon numaralar�n� ve ta��d�klar� sipari� say�lar�n� listeleyin.
select s.CompanyName,s.Phone,count(o.OrderID) as 'Toplam Say�s�' from Orders o
join Shippers s on s.ShipperID=o.ShipVia group by s.CompanyName,s.Phone having count(o.OrderID)>250


--d��ar�dan girilen isim, soyisim ve �irket ad� ile bir mail adresi olu�turan fonksiyonu yaz�n.

create function MailOlustur(
@ad nvarchar(20),
@soyad nvarchar(20),
@sirket nvarchar(20)
)
returns nvarchar(100)
as
	begin
			return @ad+'.'+@soyad+'@'+@sirket+'.com'
	end

select dbo.MailOlustur('fatih','g�nalp','bilgeadam')

--CategoryID'si 5 olan ve Nancy taraf�ndan sat�lm�� �r�nlerin toplam sat�� miktar�n� (para baz�nda) �r�n baz�nda g�steren fonksiyonu yaz�n.

create function SatislariGetir(
@cid int,
@employeeName nvarchar(20)
)
returns table
	as
	return
		select e.FirstName,c.CategoryID,p.ProductID,p.ProductName,od.Quantity, ROUND(SUM(od.UnitPrice*od.Quantity*(1-discount)),2) as ToplamFiyat from Employees e
		join Orders o on o.EmployeeID=e.EmployeeID
		join [Order Details] od on od.OrderID=o.OrderID
		join Products p on p.ProductID=od.ProductID
		join Categories c on c.CategoryID=p.CategoryID
		where @cid=c.CategoryID and e.FirstName=@employeeName group by e.FirstName, c.CategoryID, p.ProductID,p.ProductName,od.Quantity

		select * from SatislariGetir(5,'nancy')
----------------------------------------------------------------