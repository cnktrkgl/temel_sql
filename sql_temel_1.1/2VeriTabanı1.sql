-- Adý Burcu olan Ankaralý Müþterileri listeleyiniz
SELECT * FROM Müþteriler
WHERE (Adý = 'Burcu' AND il = 'Ankara')

-- Adý Ahmet olan müþteriler ile birlikte Burcu olan müþterileri de listeleyiniz
SELECT * FROM Müþteriler
WHERE (Adý = 'Ahmet' OR Adý = 'Burcu')

-- Fiyatý 10 TL den pahalý 20 TL den ucuz ürünleri listeleyiniz
--<---------0-----------10--------20-------> Fiyat
                        --------------->10<Fiyat
	    --Fiyat<20<---------------

SELECT * FROM Ürünler
WHERE BirimFiyat>10 AND BirimFiyat<20
ORDER BY BirimFiyat ASC

-- Stok Miktarý 10 dan az ve 20 den çok olan ürünleri listeleyiniz
--<---------0------------10-------------20-------------
--        <--------------               ------------->
SELECT * FROM Ürünler
WHERE StokMiktarý<10 OR StokMiktarý>20
ORDER BY StokMiktarý ASC

-- Adý Ertuðruldan büyük , Umuttan küçük olanlarýný listeleyiniz
-- Alfabetik
SELECT * FROM Müþteriler
WHERE Adý>'Ertuðrul' AND Adý<'Umut'
ORDER BY Adý ASC

-- Aralýk Sorgulamak için BETWEEN
-- Sýnýrlar dahildir!!!
SELECT * FROM TabloAdý
WHERE KolonAd BETWEEN küçðkdeðer AND büyükdeðer

-- Adý Ertuðruldan büyük , Umuttan küçük olanlarýný listeleyiniz
-- Alfabetik
-- Sýnýrlar dahil olsun
SELECT * FROM Müþteriler
WHERE Adý BETWEEN 'Ertuðlur'AND 'Umut'
ORDER BY Adý ASC

-- Fiyatý 10 TL den pahalý 20 TL den ucuz ürünleri listeleyiniz
-- Sýnýrlar dahil
SELECT * FROM Ürünler
WHERE BirimFiyat BETWEEN 10 AND 20
ORDER BY BirimFiyat ASC

-- Sadece Latince Adý Boþ NULL olan Ürünleri Listeleyiniz
SELECT * FROM Ürünler
WHERE LatinceAdý IS NULL

-- Latince Adý Boþ/NULL olmayan Ürünleri Listeleyiniz
SELECT * FROM Ürünler
WHERE LatinceAdý IS NOT NULL
-- Alternatif bir çözüm geldi(ASCII kodlama sistemiyle alakalý)(UNICORD dili)
SELECT * FROM Ürünler
WHERE LatinceAdý >'A'


-- Karakter katarlarý için iki joker:
% : Herhangi bir hece yerine joker, boþ karakter katarýda(karakter dizisi) olabilir.
_ : Herhangi bir harf yerine joker

-- Bu jokerler = denktir ile çalýþmazlar !!!
-- LIKE : gibi benzer operatörü ile çalýþýrlar.

-- Asý A harfi ile baþlayan Müþterileri listeleyelim
SELECT * FROM Müþteriler
WHERE Adý ='A%' -- ÇALIÞMAZ! Adý Tam olarak A% arar
-- O halde A ile baþlayan herhangi bir karakter katarý ile devam edenler BENZER/LIKE arayalý
SELECT * FROM Müþteriler
WHERE Adý LIKE'A%' -- ÇALIÞIR

-- Adý Er hecesi ile biten müþteriler :
SELECT * FROM Müþteriler
WHERE Adý LIKE'%er'

-- Adýnda er hecesi geçen müþterileri listeleyelim
-- er, solunda saðýnda yada arada bir yerlerde olabilir.
SELECT * FROM Müþteriler
WHERE Adý LIKE'%ER%'
ORDER BY Adý ASC

-- _ : tek bir harf joker
SELECT * FROM Müþteriler
WHERE Adý LÝKE 'AL%'

-- Bir müþteri arýyoruz adý üç harfli 
-- Al ile baþlýyor
-- Alper 5 harf
SELECT * FROM Müþteriler
WHERE Adý LIKE 'Al_'--_ tek harf
-- Es ile baþlayan müþteri
SELECT * FROM Müþteriler
WHERE Adý LIKE 'ES%'
-- Es ile baþlayan a ile biten 4 harfli müþteri adý
SELECT * FROM Müþteriler
WHERE Adý LIKE 'ES_a' --_ tek harf esin yok esra,esma var
-- Al ile baþlayan 5 harfli
SELECT * FROM Müþteriler
WHERE Adý LIKE 'AL___'

-- Müþterilerin Adlarý
-- A,B,C,Ç,D,E harfi ile baþlayanlarýn listesi
-- F;G,H,I,Ý,J ile baþlayanlar farklý bir liste
-- K,L,M,N,O,Ö,U ile baþ...
-- ...Alfabeden dilim çýkartýyoruz...
SELECT * FROM Müþteriler
WHERE Adý LIKE 'A%' OR Adý LIKE 'B%' OR Adý LIKE 'C%' OR Adý LIKE 'Ç%' OR Adý LIKE 'D%' OR Adý LIKE 'E%'
ORDER BY Adý ASC
-- Alfabeden Dilim Çýkartmanýn Kolayý Var
SELECT * FROM Müþteriler
WHERE Adý LIKE '[A-E]%'
ORDER BY Adý ASC
--
SELECT * FROM Müþteriler
WHERE Adý LIKE '[K_U]%'
ORDER BY Adý ASC

-- Adý KLMNOÖU harfleri ile baþlamayanlarý listelersek
SELECT * FROM Müþteriler
WHERE Adý NOT LIKE '[K-U]%'
ORDER BY Adý ASC

-- MS-SQL server dili Transact SQL : T-SQL
-- Ayný Çözüm þöylede olabilir:
SELECT * FROM Müþteriler
WHERE Adý LIKE '[^K-U]%'
ORDER BY Adý ASC
---------------------------------
-- Fiyatý 10,20,30,40,50,60 TL olan ürünleri listeleyiniz
SELECT * FROM Ürünler
WHERE BirimFiyat=10 OR BirimFiyat=20 OR BirimFiyat=30 OR BirimFiyat=40 OR BirimFiyat=50 OR BirimFiyat=60
ORDER BY BirimFiyat ASC
-- Kolay yolu : Alt sorgu Kullanmak :
-- Bir küme gösterip, bu kümenin içinde olanlarý listele  demek
SELECT * FROM Ürünler
WHERE BirimFiyat IN (10,20,30,40,50,60)
ORDER BY BirimFiyat ASC
-- Adý Adem, Ayþe, Gözde, Tolga, Ertuðrul, Turan olan müþterileri listeleyiniz
SELECT * FROM Müþteriler
WHERE Adý='Adem' OR Adý='Ayþe' OR Adý='Gözde' OR Adý='Tolga' OR Adý='Ertuðrul' OR Adý='Turan'
ORDER BY Adý ASC
-- Kolay yol
SELECT * FROM Müþteriler
WHERE Adý IN ('Adem','Ayþe','Gözde','Tolga','Ertuðrul','Turan')
ORDER BY Adý ASC

-- Bir kolondaki kayýtlardan sadece Farklý Olanlarý getirmek DISTINCT/FARKLI(Ayrý olanlarý getir anlamýnda)
SELECT il FROM Müþteriler
-- Sadece farklý illeri getirmek için
SELECT DISTINCT il FROM Müþteriler
ORDER BY il ASC
-- il ilçe çiftlerinden farklý olanlarý listeleyelim
SELECT DISTINCT ilçe, il FROM Müþteriler
ORDER BY il ASC, ilçe ASC
-- Ürünler tablosundaki fþyatlardan farklý olanlarý listeleyiniz
SELECT DISTINCT BirimFiyat FROM Ürünler
ORDER BY BirimFiyat ASC