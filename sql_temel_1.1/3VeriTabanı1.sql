USE Bahceisleri

-- Alfebeden Dilim ��kar
-- �r�nAd� o,�,p,r,s,�,t ile ba�layanlar� sorgulayal�m
SELECT * FROM �r�nler
WHERE �r�nAd LIKE '[O-T]%'
ORDER BY �r�nAd ASC

-- Alfebeden Dilim ��kar
-- �r�nAd� o,�,p,r,s,�,t ile ba�laMAYANLARI sorgulayal�m
SELECT * FROM �r�nler
WHERE �r�nAd NOT LIKE '[O-T]%'
ORDER BY �r�nAd ASC
-- Di�er se�enek
SELECT * FROM �r�nler
WHERE �r�nAd LIKE '[^O-T]%'
ORDER BY �r�nAd ASC

-- �r�nler Tablosunda Sat�c�FirmaNo lardan farkl� olanlar� sorgulayal�m
SELECT DISTINCT Sat�c�FirmaNo FROM �r�nler
-- �r�nler Tablosunda Sat�c�FirmaNo lardan olanlar� sorgulayal�m
SELECT Sat�c�FirmaNo FROM �r�nler

SELECT * FROM �r�nler

-- �r�nler tablosunun kategoriNo kolonunda tekrar etmeyen kay�tlar� g�steriniz
SELECT DISTINCT KategoriNo FROM  �r�nler
---------------------------------------------------------
--AGGREGATE FUNCTIONS : Toplumsal Fonksiyonlar (Tek bir de�er d�nd�ren fonksiyonlar)
MIN(kolonAd�) : Bir kolondaki en k���k de�eri d�nd�r�r.
MAX(kolonAd�) : Bir kolondaki en b�y�k de�eri d�nd�r�r.
AVG(kolonAd�) : Say�sal bir kolondaki de�erlerin ortalamas�
SUM(kolonAd�) : Say�sal bir kolondaki de�erlerin toplam�
COUNT(kolonAd�) : Kolonda bo�/NULL olmayan kay�tlar�n say�s�
STDEV(kolonAd�) : Say�sal kolondaki de�erleri standart sapmas�

-- En pahal� �r�n�n fiyat� ?
SELECT MAX(BirimFiyat) AS EnPahal�Fiyat FROM �r�nler
-- StokMiktar� 0 olmayan en az �r�nden ne kadar var stokta ?
SELECT MIN(StokMiktar�) AS StoktaOlanEnAzAdet FROM �r�nler
WHERE StokMiktar� >0
-- D�er yol
SELECT MIN(StokMiktar�) AS StoktaOlanEnAzAdet FROM �r�nler
WHERE StokMiktar� !=0

-- Ad� en k���k m��teri kim ?
SELECT MIN(Ad�) FROM M��teriler
-- Ad� en b�y�k �r�n ?
SELECT MAX(�r�nAd) FROM �r�nler

-- KategoriNo 13 olan �r�nlerden en ucuz olan�n fiyat�
SELECT MIN(BirimFiyat) FROM �r�nler
WHERE KategoriNo=13

-- 7Nolu Firmadan ald���n�z en pahal� �r�n ka� TL ?
SELECT MAX(BirimFiyat) FROM �r�nler
WHERE Sat�c�FirmaNo=7

-- Ka� m��teri var ?
SELECT COUNT(*) FROM M��teriler
-- Kay�t say�s� hakk�nda en do�ru bilgiyi COUNT(*) verir t�m kolonlara bakar,
-- mutlaka bir doludur

-- �r�nler tablosunda �r�nAd Kolonundaki kay�tlar� say�n
SELECT COUNT(�r�nAd) FROM �r�nler ---195
-- �r�nler tablosunda LaticeAd� kolonundaki kay�tlar� say�n
SELECT COUNT(LatinceAd�) FROM �r�nler ---68
-- �r�nler tablosunda T�m Kolonlardaki kay�tlar� say�n
SELECT COUNT(*) FROM �r�nler ---195

-- 16 nolu kategoride ka� �e�it �r�n vard�r ?
SELECT COUNT(*) FROM �r�nler
WHERE KategoriNo=16
-- �stanbullu ad� a harfi ile ba�layan ka� m��terimiz var?
SELECT COUNT(*) FROM M��teriler
WHERE �l='�stanbul' and Ad� LIKE 'A%'
-- Latince Ad� NULL olan ka� adet �r�n var ?
SELECT COUNT(LatinceAd�) FROM �r�nler
WHERE LatinceAd� is NULL -- COUNT bo�lar� saymaz !!!

SELECT COUNT(*) FROM �r�nler
WHERE LatinceAd� is NULL -- 127

-- Bu Firmada ka� adet �r�n var?
SELECT SUM(StokMiktar�) AS ToplamPaketSay�s� FROM �r�nler

-- �r�nler tablosu BirimFiyat kolonunun toplam� nedir ?
SELECT SUM(BirimFiyat) AS BirimFiyatKolonToplam FROM �r�nler

-- Bu firma sto�unu olu�turmak i�in ka� para harcam��t�r?
-- Toplam stok tutar� nedir?
SELECT �r�nAd, StokMiktar�, BirimFiyat, StokMiktar�*BirimFiyat FROM �r�nler
-- Tek bir de�er d�nd�ren fomksiyon, sat�rlar d�nd�recek bir kolon ile ayn�
-- sorguda kullan�lmaz!!!!
SELECT SUM(StokMiktar�*BirimFiyat) AS ToplamStokTutar� FROM �r�nler

-- 11084 nolu sipari�in toplam sat�� tutar�n� bulunuz
SELECT *, BirimFiyat*Miktar AS Tutar FROM [Sipari� Detaylar�]
WHERE Sipari�No=11084
-- Toplam Tutar :
SELECT SUM(BirimFiyat*Miktar) AS Tutar FROM [Sipari� Detaylar�]
WHERE Sipari�No=11084

-- Bu Firman�n Toplam Sipari� tutar� nedir
SELECT SUM(BiriMFiyat*Miktar) AS ToplamSipari�Tutar� FROM [Sipari� Detaylar�]

-- �r�nlerin BirimFiyat Kolonun ortalamas� nedir?
SELECT AVG(BirimFiyat) AS OrtalamaFiyat FROM �r�nler
-- Bu ger�ek bir ortalam fiyat de�il neden ?
