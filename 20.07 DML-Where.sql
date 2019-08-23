-- Where: Filtreleme ��lemleri
--Product tablosunda sadece ProductID si 1 olan� listeleyin.
select * from Products where ProductID=1

--�r�n fiyat� 30 dan b�y�k olan �r�nleri listele 

Select * from Products where UnitPrice>30

--Category ID si 5 olan category leri listele
Select * from Categories where CategoryID=5

--Fiyat� 10 ile 40 aras�ndaki �r�nleri listele
--I.Yol 
select * from Products where UnitPrice>=10 and UnitPrice>=40

--II. Yol
select * from Products where UnitPrice between 10 and 40 --�r�n fiyat� 10 ve 40 olanlar� listeler

--fitay� 10 olmayan �r�nler
select * from Products where UnitPrice<>10
select * from Products where UnitPrice!=10

--CategoryID is 5 olmayan �r�nlerin adlar�n� ve category�d lerini listeleyim
select ProductName as '�r�n Ad�',CategoryID as 'Kategori ID' from Products where CategoryID!=5




