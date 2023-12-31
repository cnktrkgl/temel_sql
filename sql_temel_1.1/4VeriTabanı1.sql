-- �r�nlerin BirimFiyat Kolonun ortalamas� nedir?
SELECT AVG(BirimFiyat) AS OrtalamaFiyat FROM �r�nler
-- Di�er yol
SELECT AVG(BirimFiyat) FROM �r�nler
-- Bu ger�ek bir ortalama fiyat de�ilneden?
-- Ortalama nas�l hesaplan�r?
-- T�m de�erleri toplar�z
SELECT SUM(BirimFiyat) AS Toplam FROM �r�nler
-- Sonra de�erlerin adetine b�leriz
SELECT COUNT(BirimFiyat) AS Adet FROM �r�nler
-- B�lelim
SELECT SUM(BirimFiyat)/COUNT(BirimFiyat) AS Ortalama FROM �r�nler
--
SELECT AVG(BirimFiyat) AS AVGILE FROM �r�nler

-- Ger�ek bir birimfiyat ortalamas� hesaplamak istersek 
-- a��rl�kl� ortalama hesaplamal�y�z :


      Fiyat1xMiktar1+Fiyat2xMiktar2+....+FiyatNXMiktarN
ort = ---------------------------------------------------
      Miktar1+Miktar2+.....+MiktarN

	   Toplam Stok Tutar�
ort = -------------------------------
       Toplam Stok Miktar�

SELECT SUM(BirimFiyat*StokMiktar�)/SUM(StokMiktar�) AS A�OrtFiyat� FROM �r�nler --17.7504
-- Sipari� Detaylar� tablosundan sat�lan her �r�n�n sat�� tutar�n� hesaplay�m
SELECT *, BirimFiyat*Miktar AS Sat��Tutar� FROM [Sipari� Detaylar�]

-- Bu �irketin bu g�ne kadar yapt��� sat��lar�n toplam tutar� nedir?
SELECT SUM(BirimFiyat*Miktar) AS ToplamSat��Tutar� FROM [Sipari� Detaylar�]
-- Sat�rlar d�nd�ren kolonlara, tek bir de�er d�nd�ren toplamsa fonksiyonlar yanyana sorguda kullan�lmaz!!

-- Sadece 11097 nolu sipari�te �r�nlerin sat�� tutarlar�n� listeleyiniz
SELECT * FROM [Sipari� Detaylar�]
WHERE Sipari�No=11097
--  Di�er yol
SELECT *, BirimFiyat*Miktar AS Sat��Tutar 
FROM [Sipari� Detaylar�]
WHERE Sipari�No=11097

-- Sadece 11097 nolu sipari� toplam sat�� tutarlar�n� hesaplay�n�z
SELECT SUM(BirimFiyat*Miktar) AS Sat��Tutar�
FROM [Sipari� Detaylar�] Where Sipari�No=11097 --116.55
---------------------
-- 1)Ad� A harfi ile ba�layan soyad� n harfi ile biten m��terilerin say�s�n� 
SELECT COUNT(*) FROM M��teriler WHERE Ad� LIKE 'A%' AND SoyAd� LIKE '%N'

-- 2)�li Ankara , il�esi �ankaya olan m��terilerin Ad� en k���k olan�
SELECT MIN(Ad�) FROM M��teriler
WHERE �l='Ankara' AND �l�e='�ankaya'

-- 3)En ucuz, en pahal� , ortalama �r�n fiyat�n�, toplam stok miktar�n�,
-- toplam stok tutar�n�, latince bo� olanlar�n say�s�n� bir sorguda gf�steriniz
SELECT MIN(BirimFiyat) AS EnUcuz, MAX(BirimFiyat) AS EnPahal�, AVG(BirimFiyat) AS ortFyt, SUM(StokMiktar�) AS TopStokMik, 
SUM(BirimFiyat*StokMiktar�) AS TopStokTutar, COUNT(LatinceAd�) AS LatinceBo�Olmayanlar FROM �r�nler

------------------------- GRUPLAMA : GROUP BY Yn c�mlesi
Toplamsal (Aggrrgate) Fonksiyonlar� tablonun tamam�na uygulanabilece�i gibi,
kay�tlar ortak bir �zelli�e g�re gruplanarak, her bir gruba ayr� ayr� da uygulanabilirler.
Gruplama yap�ld���nda, sorgu sonucunda, her bir gruba sadece 1 sat�r izin verilir.
Sorguda toplumsal fonksiyonlar�n yan�nda sadece gruplama yap�lan kolonun g�sterilmesine izin verilir.
SELECT ortak�zellikKolon, MIN(kolon1), AVG(kolon2),...,SUM(kolonN) FROM TabloAd�
GROUP BY ortak�zellikKolonu
-- �r�n �e�it say�s�, en pahal� �r�n fiyat ve toplam stok Tutar�
-- her bir kategori i�in hesaplay�n�z
SELECT * FROM �r�nler ORDER BY KategoriNo

SELECT * FROM Kategoriler

SELECT KategoriNo,
       COUNT(�r�nAd) AS �r�n�e�itSay�s�, MAX(BirimFiyat) AS EnPahal�,
       SUM(BirimFiyat*StokMiktar�) AS ToplamStokTutar�
FROM �r�nler GROUP BY KategoriNo
ORDER BY COUNT(�r�nAd) DESC --�r�n �e�it say�s�na g�re  azalan S�ralay�n�z

-- �llere g�re M��teri say�lar�n� listeleyiniz
SELECT �l, COUNT(*) AS Say� FROM M��teriler
GROUP BY �l
ORDER BY �l ASC

-- �llere g�re M��teri say�lar�n� listeleyiniz, m�teri say�s�na g�re artan s�ralay�n�z
SELECT �l, COUNT(*) AS Say� FROM M��teriler
GROUP BY �l
ORDER BY COUNT(*) ASC

-- �l ve il�elere g�re m��teri say�lar�n� listeleyiniz
SELECT �l, �l�e, COUNT(*) AS Say� FROM M��teriler
GROUP BY �l, �l�e
ORDER  BY il ASC, �l�e ASC

-- Her bir sat�c� firmadan al�nan �r�nlerin en ucuz, en pahal� ve ortalama
-- fiyat�n�, o firmaya yap�lan toplam �demeyi, ofirmadan al�nan �r�n �e�it say�s�n�,
-- firmadan al�nan toplam �r�n adetini, firmadan al�nan �r�nlerin a��rl�kl� ortalama
-- fiyat�n� hesaplay�n�z
SELECT Sat�c�FirmaNo, MIN(BirimFiyat) AS EnUcuz, MAX(BirimFiyat) AS EnPahal�,
       AVG(BirimFiyat) AS ortFiyat, SUM(BirimFiyat*StokMiktar�) AS Toplam�deme,
	   COUNT(*) AS �e�itSay�s�, SUM(StokMiktar�) AS TopUrunAdeti,
	   SUM(BirimFiyat*StokMiktar�)/SUM(StokMiktar�) AS A��rl�kl�OrtFiyat
FROM �r�nler
GROUP BY Sat�c�FirmaNo
ORDER BY Sat�c�FirmaNo ASC

-- M��teriler tablosunda her bir ilin ka� kez tekrar etti�ini bulabilirmisiniz?
SELECT �l, COUNT(*) AS M��Say� FROM M��teriler
GROUP BY �l

-- Tekrar eden M��teri Adlar�n� ka� kez tekrar etti�ini bulabilirmisiniz?
SELECT Ad�, COUNT(*) AS M��Ad� FROM M��teriler
GROUP BY Ad�
HAVING COUNT(*)>1

-- GROUP BY da kural yazmak i�in WHERE kullan�lmaz!!! Onun yerine 
-- HAVING (Kural) kullan�l�r. Bu kurala sahip olan sonu�lar listelensin

-- Yukar�daki sat�c� firmalar ileilgili soruda sonu�lar�
-- �r�n �e�it say�s� 4 den fazla olan sat�c�lar i�in listeleyiniz
SELECT Sat�c�FirmaNo, MIN(BirimFiyat) AS EnUcuz, MAX(BirimFiyat) AS EnPahal�,
       AVG(BirimFiyat) AS ortFiyat, SUM(BirimFiyat*StokMiktar�) AS Toplam�deme,
	   COUNT(*) AS �e�itSay�s�, SUM(StokMiktar�) AS TopUrunAdeti,
	   SUM(BirimFiyat*StokMiktar�)/SUM(StokMiktar�) AS A��rl�kl�OrtFiyat
FROM �r�nler
GROUP BY Sat�c�FirmaNo
HAVING COUNT(*)>4 -------------<---------
ORDER BY COUNT(*) ASC
-----------------------
-- Sipari� Detaylar� tablosunda her bir sipari�in toplam sat�� tutar�n� bulunuz?
SELECT Sipari�No, SUM(BirimFiyat*Miktar) AS Sipari�Tutar� FROM [Sipari� Detaylar�]
GROUP BY Sipari�No