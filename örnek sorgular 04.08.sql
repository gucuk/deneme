--Stokta hangi tedarikçiden ortalama kaç ürün vardır?çoktan aza doğru listeleyin.
select s.CompanyName,p.ProductName,avg(p.UnitsInStock) 'Ortalama Stok' from Products p​
join Suppliers s on s.SupplierID=p.SupplierID group by s.CompanyName,p.ProductName order by 3 desc​
​
​
--250'den fazla sipariş taşımış olan kargo firmalarının adlarını telefon numaralarını ve taşıdıkları sipariş sayılarını listeleyin.​
select s.CompanyName,s.Phone,count(o.OrderID) 'Toplam Sipariş' from Products p ​
join  [Order Details] od on od.ProductID=p.ProductID​
join Orders o on o.OrderID=od.OrderID​
join Shippers s on s.ShipperID=o.ShipVia group by s.CompanyName,s.Phone having count(o.OrderID)>250​
​
--dışarıdan girilen isim soyisim ve şirket adı ile bir mail adresi oluşturan fonksiyonu yazın.​
go​
alter function mail(@ad nvarchar(20),@soyad nvarchar(20),@sirket nvarchar(20)) returns nvarchar(100)​
as​
begin ​
​
return​
@ad+@soyad+'@'+@sirket+'.com'​
​
end​
select dbo.mail('zeynep','gucuk','bilgeadam') as MAIL​
​
​
--CategoryID'si 5 olan ve Nancy tarafından satılmış ürünlerin toplam satış miktarını(para) ürün bazında gösteren fonksiyonu yaz.​
​
alter function TopSatis2(@catgid int,@ad nvarchar(20)) returns table​
as​
​
return​
select c.CategoryName as Kategori,e.FirstName as Ad,p.ProductName,SUM(od.UnitPrice*od.Quantity*(1-od.Discount)) as 'Toplam'​
 from Employees e ​
join Orders o on o.EmployeeID=e.EmployeeID​
join [Order Details] od on od.OrderID=o.OrderID​
join Products p on p.ProductID=od.ProductID​
join Categories c on c.CategoryID=p.CategoryID ​
where c.CategoryID=@catgid and e.FirstName=@ad group by c.CategoryName,e.FirstName,p.ProductName​
​
select * from TopSatis2(5,'nancy')
-----hocanın notları

--Örnek Sorgular

--Stokta hangi tedarikçiden ortalama kaç ürün vardır? Çoktan aza doğru listeleyin.
select s.CompanyName,p.ProductName,AVG(p.UnitsInStock) from Suppliers s 
inner join Products p on p.SupplierID=s.SupplierID group by s.CompanyName, p.ProductName


--250'den fazla sipariş taşımış olan kargo firmalarının adlarını, telefon numaralarını ve taşıdıkları sipariş sayılarını listeleyin.
select s.CompanyName,s.Phone,count(o.OrderID) as 'Toplam Sayısı' from Orders o
join Shippers s on s.ShipperID=o.ShipVia group by s.CompanyName,s.Phone having count(o.OrderID)>250


--dışarıdan girilen isim, soyisim ve şirket adı ile bir mail adresi oluşturan fonksiyonu yazın.

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

select dbo.MailOlustur('fatih','günalp','bilgeadam')

--CategoryID'si 5 olan ve Nancy tarafından satılmış ürünlerin toplam satış miktarını (para bazında) ürün bazında gösteren fonksiyonu yazın.

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