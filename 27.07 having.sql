--having :sorgu sonucu gelen sonu� k�mesi �zerinde aggregate fonksiyonlar�na ba�l� olacak �ekilde bir filtreleme i�lemleri yapacaksak where yerine having komutunu kullan�r�z.

--her bir sipari�teki toplam �r�n say�s� 200 den az olanlar� �oktan aza do�ru s�ralay�n�z.
select orderID,sum(Quantity) from [Order Details]
group by OrderID having sum(Quantity)<200 


