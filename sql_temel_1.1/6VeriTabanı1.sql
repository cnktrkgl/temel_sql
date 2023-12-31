-- Sýnavdan önce insert into 3 çeþidini görmüþtük..

-- DML den update ve delete ile devam ediyoruz

-- UPDATE koþulu saðlayan satýrlarda, seçilen kolonlarýn deðerini günceller..

UPDATE TabloAdý
   SET KolonAd1 = yenideðer1,
   KolonAd2 = yenideðer2,
   ...
   KolonAdN = yenideðerN
WHERE (Koþul)'bulmak istediklerimiz'

-- ili Ankara ilçesi Çanaya olan Müþterilerin ilçesini
-- Çankaya olarak güncelleyelim :
SELECT * FROM Müþteriler
WHERE Ýl='Ankara' AND Ýlçe = 'Çanaya'
-- MüþteriNo DERNE ve SAGYA olan iki kiþi
UPDATE Müþteriler
SET Ýlçe='Çankaya'
WHERE Ýl='Ankara' AND Ýlçe='Çanaya'
-- görelim düzelmiþ mi?
SELECT * FROM Müþteriler WHERE MüþteriNo IN ('DERNE','SAGYA')
--
-- Kategoriler tablosunda KategoriAdý ÇÝÇEK Soðanlarý, Soðanlý Çiçekler olarak güncelleyiniz

SELECT * FROM Kategoriler
--
UPDATE Kategoriler
SET KategoriAdý = 'Soðanlý Çiçekler'
WHERE KategoriAdý = 'Çiçek Soðanlarý'
--
-- Ürünler tablosunda  LaticeAdý NULL olan kayýtlarý
-- 'Yok' olarak güncelleyiniz
SELECT * FROM Ürünler WHERE LatinceAdý IS NULL
--
UPDATE Ürünler
SET LatinceAdý = 'YOK'
WHERE LatinceAdý IS NULL

--
-- Kýþ çiLeðinden 4 tane satýldý, ürünler tablosunu güncelleyiniz
UPDATE Ürünler
SET StokMiktarý = StokMiktarý-4
WHERE ÜrünAd = 'Kýþ Çileði'

-- Kýþ Çileðinden 16 adet stok giriþi yapmak üzere tablosunu güncelleyiniz
UPDATE Ürünler
SET StokMiktarý = StokMiktarý+16
WHERE ÜrünAd = 'Kýþ Çileði'

-- Ürenler tablosunda Aðaçlar kategorisindaki ürünlere
-- %5 zam yapýnýz
-- ZamlýBirimFiyat*5/100
-- ZamlýBirimFiyat*(1+0.05) = ZamlýBirimFiyat*1.05
UPDATE Ürünler
SET BirimFiyat = BirimFiyat*5/100
WHERE KategoriNo = 13

-- Tüm ürünlere %8 indirim uygulayýnýz?
-- ÝndirimliBirimFiyat = BirimFiyat - BirimFiyat*8/100
-- ÝndirimliBirimFiyat = BirimFiyat*(1-0.08) = BirimFiyat*0.92 = BirimFiyat*.92
UPDATE Ürünler
SET BirimFiyat = BirimFiyat - BirimFiyat*8/100

-- 5 tl den ucuz ürünlere %20 zam ??
-- 100 tl den pahalý ürünlere %10 indirim yapýnýz??

--

DELETE
-- Koþulu saðlayan kayýtlarý siler.
DELETE FROM TabloAdý
WHERE(koþul)
-- VT de kayýtlar daima tutulur, eski kayýt silinmez,
-- sadece yanlýþ kayýtlar silinir
 
-- Ürünler tab. Tükenmiþ/SeriSonu kayýtlarý silelim
-- önce koþulu saðlayan satýrlarý görüp, kpþulu test edelim
SELECT * FROM Ürünler WHERE Tükendi=1
-- sonra silelimn
DELETE FROM Ürünler WHERE Tükendi=1
--
-- Yurtdýþýndan müþterileri siliniz
SELECT * FROM Müþteriler WHERE Ülke != 'TR'
--
SELECT * FROM Müþteriler WHERE Ülke <> 'TR'

DELETE FROM Müþteriler
WHERE Ülke != 'TR'
---------------------------------------
-- Alt Sorgular

SELECT * FROM Ürünler WHERE BirimFiyat IN (10,20,30,40)

-- En ucuz ürünün fiyatý?
SELECT MIN(BirimFiyat) FROM Ürünler
-- En ucuz ürünün Adý?
SELECT ÜrünAd FROM Ürünler WHERE BirimFiyat = 1.61
-- Ýki sorguyu birleþtirelim
SELECT ÜrünAd FROM Ürünler
WHERE BirimFiyat = (SELECT MIN(BirimFiyat) FROM Ürünler)-- Alt sorgu

-- En pahalý ürünün adý ?
SELECT ÜrünAd FROM Ürünler
WHERE BirimFiyat = (SELECT MAX(BirimFiyat) FROM Ürünler)-- Alt sorgu

-- Alt sorgu parantez içerisinde yazýlýr.


