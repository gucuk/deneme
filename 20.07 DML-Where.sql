-- Where: Filtreleme Ýþlemleri
--Product tablosunda sadece ProductID si 1 olaný listeleyin.
select * from Products where ProductID=1

--Ürün fiyatý 30 dan büyük olan ürünleri listele 

Select * from Products where UnitPrice>30

--Category ID si 5 olan category leri listele
Select * from Categories where CategoryID=5

--Fiyatý 10 ile 40 arasýndaki ürünleri listele
--I.Yol 
select * from Products where UnitPrice>=10 and UnitPrice>=40

--II. Yol
select * from Products where UnitPrice between 10 and 40 --ürün fiyatý 10 ve 40 olanlarý listeler

--fitayý 10 olmayan ürünler
select * from Products where UnitPrice<>10
select * from Products where UnitPrice!=10

--CategoryID is 5 olmayan ürünlerin adlarýný ve categoryýd lerini listeleyim
select ProductName as 'Ürün Adý',CategoryID as 'Kategori ID' from Products where CategoryID!=5




