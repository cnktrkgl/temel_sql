-- Ürünlerin BirimFiyat Kolonun ortalamasý nedir?
SELECT AVG(BirimFiyat) AS OrtalamaFiyat FROM Ürünler
-- Diðer yol
SELECT AVG(BirimFiyat) FROM Ürünler
-- Bu gerçek bir ortalama fiyat deðilneden?
-- Ortalama nasýl hesaplanýr?
-- Tüm deðerleri toplarýz
SELECT SUM(BirimFiyat) AS Toplam FROM Ürünler
-- Sonra deðerlerin adetine böleriz
SELECT COUNT(BirimFiyat) AS Adet FROM Ürünler
-- Bölelim
SELECT SUM(BirimFiyat)/COUNT(BirimFiyat) AS Ortalama FROM Ürünler
--
SELECT AVG(BirimFiyat) AS AVGILE FROM Ürünler

-- Gerçek bir birimfiyat ortalamasý hesaplamak istersek 
-- aðýrlýklý ortalama hesaplamalýyýz :


      Fiyat1xMiktar1+Fiyat2xMiktar2+....+FiyatNXMiktarN
ort = ---------------------------------------------------
      Miktar1+Miktar2+.....+MiktarN

	   Toplam Stok Tutarý
ort = -------------------------------
       Toplam Stok Miktarý

SELECT SUM(BirimFiyat*StokMiktarý)/SUM(StokMiktarý) AS AðOrtFiyatý FROM Ürünler --17.7504
-- Sipariþ Detaylarý tablosundan satýlan her ürünün satýþ tutarýný hesaplayým
SELECT *, BirimFiyat*Miktar AS SatýþTutarý FROM [Sipariþ Detaylarý]

-- Bu þirketin bu güne kadar yaptýðý satýþlarýn toplam tutarý nedir?
SELECT SUM(BirimFiyat*Miktar) AS ToplamSatýþTutarý FROM [Sipariþ Detaylarý]
-- Satýrlar döndüren kolonlara, tek bir deðer döndüren toplamsa fonksiyonlar yanyana sorguda kullanýlmaz!!

-- Sadece 11097 nolu sipariþte ürünlerin satýþ tutarlarýný listeleyiniz
SELECT * FROM [Sipariþ Detaylarý]
WHERE SipariþNo=11097
--  Diðer yol
SELECT *, BirimFiyat*Miktar AS SatýþTutar 
FROM [Sipariþ Detaylarý]
WHERE SipariþNo=11097

-- Sadece 11097 nolu sipariþ toplam satýþ tutarlarýný hesaplayýnýz
SELECT SUM(BirimFiyat*Miktar) AS SatýþTutarý
FROM [Sipariþ Detaylarý] Where SipariþNo=11097 --116.55
---------------------
-- 1)Adý A harfi ile baþlayan soyadý n harfi ile biten müþterilerin sayýsýný 
SELECT COUNT(*) FROM Müþteriler WHERE Adý LIKE 'A%' AND SoyAdý LIKE '%N'

-- 2)Ýli Ankara , ilçesi Çankaya olan müþterilerin Adý en küçük olaný
SELECT MIN(Adý) FROM Müþteriler
WHERE Ýl='Ankara' AND Ýlçe='Çankaya'

-- 3)En ucuz, en pahalý , ortalama ürün fiyatýný, toplam stok miktarýný,
-- toplam stok tutarýný, latince boþ olanlarýn sayýsýný bir sorguda gfösteriniz
SELECT MIN(BirimFiyat) AS EnUcuz, MAX(BirimFiyat) AS EnPahalý, AVG(BirimFiyat) AS ortFyt, SUM(StokMiktarý) AS TopStokMik, 
SUM(BirimFiyat*StokMiktarý) AS TopStokTutar, COUNT(LatinceAdý) AS LatinceBoþOlmayanlar FROM Ürünler

------------------------- GRUPLAMA : GROUP BY Yn cümlesi
Toplamsal (Aggrrgate) Fonksiyonlarý tablonun tamamýna uygulanabileceði gibi,
kayýtlar ortak bir özelliðe göre gruplanarak, her bir gruba ayrý ayrý da uygulanabilirler.
Gruplama yapýldýðýnda, sorgu sonucunda, her bir gruba sadece 1 satýr izin verilir.
Sorguda toplumsal fonksiyonlarýn yanýnda sadece gruplama yapýlan kolonun gösterilmesine izin verilir.
SELECT ortakÖzellikKolon, MIN(kolon1), AVG(kolon2),...,SUM(kolonN) FROM TabloAdý
GROUP BY ortakÖzellikKolonu
-- Ürün Çeþit sayýsý, en pahalý ürün fiyat ve toplam stok Tutarý
-- her bir kategori için hesaplayýnýz
SELECT * FROM Ürünler ORDER BY KategoriNo

SELECT * FROM Kategoriler

SELECT KategoriNo,
       COUNT(ÜrünAd) AS ÜrünÇeþitSayýsý, MAX(BirimFiyat) AS EnPahalý,
       SUM(BirimFiyat*StokMiktarý) AS ToplamStokTutarý
FROM Ürünler GROUP BY KategoriNo
ORDER BY COUNT(ÜrünAd) DESC --Ürün Çeþit sayýsýna göre  azalan Sýralayýnýz

-- Ýllere göre Müþteri sayýlarýný listeleyiniz
SELECT Ýl, COUNT(*) AS Sayý FROM Müþteriler
GROUP BY Ýl
ORDER BY Ýl ASC

-- Ýllere göre Müþteri sayýlarýný listeleyiniz, mþteri sayýsýna göre artan sýralayýnýz
SELECT Ýl, COUNT(*) AS Sayý FROM Müþteriler
GROUP BY Ýl
ORDER BY COUNT(*) ASC

-- Ýl ve ilçelere göre müþteri sayýlarýný listeleyiniz
SELECT Ýl, Ýlçe, COUNT(*) AS Sayý FROM Müþteriler
GROUP BY Ýl, Ýlçe
ORDER  BY il ASC, Ýlçe ASC

-- Her bir satýcý firmadan alýnan ürünlerin en ucuz, en pahalý ve ortalama
-- fiyatýný, o firmaya yapýlan toplam ödemeyi, ofirmadan alýnan ürün çeþit sayýsýný,
-- firmadan alýnan toplam ürün adetini, firmadan alýnan ürünlerin aðýrlýklý ortalama
-- fiyatýný hesaplayýnýz
SELECT SatýcýFirmaNo, MIN(BirimFiyat) AS EnUcuz, MAX(BirimFiyat) AS EnPahalý,
       AVG(BirimFiyat) AS ortFiyat, SUM(BirimFiyat*StokMiktarý) AS ToplamÖdeme,
	   COUNT(*) AS ÇeþitSayýsý, SUM(StokMiktarý) AS TopUrunAdeti,
	   SUM(BirimFiyat*StokMiktarý)/SUM(StokMiktarý) AS AðýrlýklýOrtFiyat
FROM Ürünler
GROUP BY SatýcýFirmaNo
ORDER BY SatýcýFirmaNo ASC

-- Müþteriler tablosunda her bir ilin kaç kez tekrar ettiðini bulabilirmisiniz?
SELECT Ýl, COUNT(*) AS MüþSayý FROM Müþteriler
GROUP BY Ýl

-- Tekrar eden Müþteri Adlarýný kaç kez tekrar ettiðini bulabilirmisiniz?
SELECT Adý, COUNT(*) AS MüþAdý FROM Müþteriler
GROUP BY Adý
HAVING COUNT(*)>1

-- GROUP BY da kural yazmak için WHERE kullanýlmaz!!! Onun yerine 
-- HAVING (Kural) kullanýlýr. Bu kurala sahip olan sonuçlar listelensin

-- Yukarýdaki satýcý firmalar ileilgili soruda sonuçlarý
-- ürün çeþit sayýsý 4 den fazla olan satýcýlar için listeleyiniz
SELECT SatýcýFirmaNo, MIN(BirimFiyat) AS EnUcuz, MAX(BirimFiyat) AS EnPahalý,
       AVG(BirimFiyat) AS ortFiyat, SUM(BirimFiyat*StokMiktarý) AS ToplamÖdeme,
	   COUNT(*) AS ÇeþitSayýsý, SUM(StokMiktarý) AS TopUrunAdeti,
	   SUM(BirimFiyat*StokMiktarý)/SUM(StokMiktarý) AS AðýrlýklýOrtFiyat
FROM Ürünler
GROUP BY SatýcýFirmaNo
HAVING COUNT(*)>4 -------------<---------
ORDER BY COUNT(*) ASC
-----------------------
-- Sipariþ Detaylarý tablosunda her bir sipariþin toplam satýþ tutarýný bulunuz?
SELECT SipariþNo, SUM(BirimFiyat*Miktar) AS SipariþTutarý FROM [Sipariþ Detaylarý]
GROUP BY SipariþNo