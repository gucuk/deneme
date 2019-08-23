--having :sorgu sonucu gelen sonuç kümesi üzerinde aggregate fonksiyonlarýna baðlý olacak þekilde bir filtreleme iþlemleri yapacaksak where yerine having komutunu kullanýrýz.

--her bir sipariþteki toplam ürün sayýsý 200 den az olanlarý çoktan aza doðru sýralayýnýz.
select orderID,sum(Quantity) from [Order Details]
group by OrderID having sum(Quantity)<200 


