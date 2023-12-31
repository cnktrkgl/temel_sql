USE Bahceisleri

-- Alfebeden Dilim Çýkar
-- ÜrünAdý o,ö,p,r,s,þ,t ile baþlayanlarý sorgulayalým
SELECT * FROM Ürünler
WHERE ÜrünAd LIKE '[O-T]%'
ORDER BY ÜrünAd ASC

-- Alfebeden Dilim Çýkar
-- ÜrünAdý o,ö,p,r,s,þ,t ile baþlaMAYANLARI sorgulayalým
SELECT * FROM Ürünler
WHERE ÜrünAd NOT LIKE '[O-T]%'
ORDER BY ÜrünAd ASC
-- Diðer seçenek
SELECT * FROM Ürünler
WHERE ÜrünAd LIKE '[^O-T]%'
ORDER BY ÜrünAd ASC

-- Ürünler Tablosunda SatýcýFirmaNo lardan farklý olanlarý sorgulayalým
SELECT DISTINCT SatýcýFirmaNo FROM Ürünler
-- Ürünler Tablosunda SatýcýFirmaNo lardan olanlarý sorgulayalým
SELECT SatýcýFirmaNo FROM Ürünler

SELECT * FROM Ürünler

-- Ürünler tablosunun kategoriNo kolonunda tekrar etmeyen kayýtlarý gösteriniz
SELECT DISTINCT KategoriNo FROM  Ürünler
---------------------------------------------------------
--AGGREGATE FUNCTIONS : Toplumsal Fonksiyonlar (Tek bir deðer döndüren fonksiyonlar)
MIN(kolonAdý) : Bir kolondaki en küçük deðeri döndürür.
MAX(kolonAdý) : Bir kolondaki en büyük deðeri döndürür.
AVG(kolonAdý) : Sayýsal bir kolondaki deðerlerin ortalamasý
SUM(kolonAdý) : Sayýsal bir kolondaki deðerlerin toplamý
COUNT(kolonAdý) : Kolonda boþ/NULL olmayan kayýtlarýn sayýsý
STDEV(kolonAdý) : Sayýsal kolondaki deðerleri standart sapmasý

-- En pahalý ürünün fiyatý ?
SELECT MAX(BirimFiyat) AS EnPahalýFiyat FROM Ürünler
-- StokMiktarý 0 olmayan en az üründen ne kadar var stokta ?
SELECT MIN(StokMiktarý) AS StoktaOlanEnAzAdet FROM Ürünler
WHERE StokMiktarý >0
-- Dðer yol
SELECT MIN(StokMiktarý) AS StoktaOlanEnAzAdet FROM Ürünler
WHERE StokMiktarý !=0

-- Adý en küçük müþteri kim ?
SELECT MIN(Adý) FROM Müþteriler
-- Adý en büyük ürün ?
SELECT MAX(ÜrünAd) FROM Ürünler

-- KategoriNo 13 olan Ürünlerden en ucuz olanýn fiyatý
SELECT MIN(BirimFiyat) FROM Ürünler
WHERE KategoriNo=13

-- 7Nolu Firmadan aldýðýnýz en pahalý ürün kaç TL ?
SELECT MAX(BirimFiyat) FROM Ürünler
WHERE SatýcýFirmaNo=7

-- Kaç müþteri var ?
SELECT COUNT(*) FROM Müþteriler
-- Kayýt sayýsý hakkýnda en doðru bilgiyi COUNT(*) verir tüm kolonlara bakar,
-- mutlaka bir doludur

-- Ürünler tablosunda ÜrünAd Kolonundaki kayýtlarý sayýn
SELECT COUNT(ÜrünAd) FROM Ürünler ---195
-- Ürünler tablosunda LaticeAdý kolonundaki kayýtlarý sayýn
SELECT COUNT(LatinceAdý) FROM Ürünler ---68
-- Ürünler tablosunda Tüm Kolonlardaki kayýtlarý sayýn
SELECT COUNT(*) FROM Ürünler ---195

-- 16 nolu kategoride kaç çeþit ürün vardýr ?
SELECT COUNT(*) FROM Ürünler
WHERE KategoriNo=16
-- Ýstanbullu adý a harfi ile baþlayan kaç müþterimiz var?
SELECT COUNT(*) FROM Müþteriler
WHERE Ýl='Ýstanbul' and Adý LIKE 'A%'
-- Latince Adý NULL olan kaç adet Ürün var ?
SELECT COUNT(LatinceAdý) FROM Ürünler
WHERE LatinceAdý is NULL -- COUNT boþlarý saymaz !!!

SELECT COUNT(*) FROM Ürünler
WHERE LatinceAdý is NULL -- 127

-- Bu Firmada kaç adet ürün var?
SELECT SUM(StokMiktarý) AS ToplamPaketSayýsý FROM Ürünler

-- Ürünler tablosu BirimFiyat kolonunun toplamý nedir ?
SELECT SUM(BirimFiyat) AS BirimFiyatKolonToplam FROM Ürünler

-- Bu firma stoðunu oluþturmak için kaç para harcamýþtýr?
-- Toplam stok tutarý nedir?
SELECT ÜrünAd, StokMiktarý, BirimFiyat, StokMiktarý*BirimFiyat FROM Ürünler
-- Tek bir deðer döndüren fomksiyon, satýrlar döndürecek bir kolon ile ayný
-- sorguda kullanýlmaz!!!!
SELECT SUM(StokMiktarý*BirimFiyat) AS ToplamStokTutarý FROM Ürünler

-- 11084 nolu sipariþin toplam satýþ tutarýný bulunuz
SELECT *, BirimFiyat*Miktar AS Tutar FROM [Sipariþ Detaylarý]
WHERE SipariþNo=11084
-- Toplam Tutar :
SELECT SUM(BirimFiyat*Miktar) AS Tutar FROM [Sipariþ Detaylarý]
WHERE SipariþNo=11084

-- Bu Firmanýn Toplam Sipariþ tutarý nedir
SELECT SUM(BiriMFiyat*Miktar) AS ToplamSipariþTutarý FROM [Sipariþ Detaylarý]

-- Ürünlerin BirimFiyat Kolonun ortalamasý nedir?
SELECT AVG(BirimFiyat) AS OrtalamaFiyat FROM Ürünler
-- Bu gerçek bir ortalam fiyat deðil neden ?
