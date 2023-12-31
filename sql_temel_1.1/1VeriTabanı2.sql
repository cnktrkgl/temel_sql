-- seçilen kolonlarý sorgulamak
SELECT ÜrünAd, BirimFiyat, StokMiktarý
FROM Ürünler
-- kolonlarýn yerini dilediðimiz gibi deðiþtirebilirsiniz
-- AS : kolon adý belirler
SELECT StokMiktarý AS Miktar, ÜrünAd AS  Adý,
 BirimFiyat AS Fiyat
FROM Ürünler
-- Ürünlerin her birinin Stok Tutarlarýný gösterebilirsiniz
SELECT ÜrünAd, BirimFiyat, StokMiktarý,
        BirimFiyat*StokMiktarý AS StokTutarý
FROM Ürünler
-- Adý ve Soyadý kolonlarýný birlikte AdSýyad olarak gösterelim
SELECT Adý+' '+Soyadý AS AdSoyadý, il FROM Müþteriler
---------------------------------------------------------
-- SIRALAMAK
-- ORDER BY KolonADI ASC/DESC : Kolon adýna göre SIRALAMA
-- ASC : ASCENDING : Artan
-- DESC : DESCENDING : Azalan sýrada sýralar
SELECT * FROM Müþteriler
ORDER BY Adý ASC -- Ada göre artan sýrada sýralar
-- Müþterileri Soyadýna göre Azalan sýrada sýralayalým
SELECT * FROM Müþteriler
ORDER BY Soyadý DESC
-- Ürünleri fiyatýna göre artan sýrada sýralayýnýz
SELECT * FROM Ürünler
ORDER BY BirimFiyat ASC

-- Müþterileri ile göre azalan sýrada sýralayalým
SELECT * FROM Müþteriler
ORDER BY Ýl DESC

-- Birden fazla kolona göre sýralama yapmak
-- ile göre çok sayýda tekrar olduðundan sýralama için 2. bir kriter gerekli
SELECT * FROM Müþteriler
ORDER BY Ýl DESC, Ýlçe ASC
-- hatta 3. bir sýralama kriteri gerekli
SELECT * FROM Müþteriler
ORDER BY Ýl DESC, Ýlçe ASC, Adres DESC
-- Eðer ASC/DESC yazýlmaz ise varsayýlan deðer ASC dir
SELECT Adý FROM Müþteriler
ORDER BY Adý 
------------------------------------ SÜZMEK
SELECT * FROM TabloAdý
WHERE (Koþul)
-- Koþulu saðlayan satýrlarý listeler
-- Adý Ahmet olan müþterileri listeleyiniz
SELECT * FROM Müþteriler
WHERE (Adý = 'Ahmet')
-- Fiyatý 50 lira olan ürünleri listeleyiniz
SELECT * FROM Ürünler
WHERE (BirimFiyat = 50)
-- Fiyatý 50 liradan pahalý ürünleri listeleyiniz
SELECT * FROM Ürünler
WHERE (BirimFiyat > 50)
-- Fiyatý 50 liradan pahalý ürünleri listeleyiniz
-- artan sýrada sralayalým listeleyiniz
SELECT * FROM Ürünler
WHERE (BirimFiyat > 50)
ORDER BY BirimFiyat ASC
-- Adý Burcu dan küçük olan Müþterileri listeleyiniz
-- Azalan sýrada sýralayalým
SELECT * FROM Müþteriler
WHERE Adý < 'Burcu'
ORDER BY Adý DESC
-- Ýzmirli müþterileri listeleyelim
SELECT * FROM Müþteriler
WHERE Ýl = 'Ýzmir'
-- Ýzmirli olmayan müþterileri listeleyelim
SELECT * FROM Müþteriler
WHERE Ýl != 'Ýzmir'
ORDER BY Ýl ASC
-- Ýkinci yol
SELECT * FROM Müþteriler
WHERE Ýl <> 'Ýzmir'
ORDER BY Ýl ASC
-- Fiyatý 10 liradan pahalý, 20 liradan ucuz ürünleri listeleyiniz
SELECT * FROM Ürünler
WHERE BirimFiyat>10 AND BirimFiyat<20