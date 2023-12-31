-- Sipariþ detaylarý tablosunda 11161 numaralý sipariþin
-- indirimli satýþ tutarlarýný bulalým
SELECT * , BirimFiyat*Miktar AS SatýþTutarý,
           BirimFiyat*Miktar-BirimFiyat*Miktar*Ýndirim AS indirimli,
           BirimFiyat*Miktar*(1-indirim) AS indirimli
FROM [Sipariþ Detaylarý]

/*
indirimliSatýþTutarý = satýþTutarý - indirimMiktar
       indirim %10 olsa : %10 = 10/100 = 0.1
indirimliTutarý = Fiyat*Miktar - Fiyat*Miktar*0.1
indirimliTutarý = Fiyat*Miktar(1 - 0.1)

indirimliTutarý = Fiyat*Miktar(1 - indirim)
*/


-- Bu güne kadar þirketin kasasýna giren gerçek para toplam ne kadardýr??
SELECT SUM(BirimFiyat*Miktar*(1-indirim)) AS ToplamSipariþTutarý
FROM [Sipariþ Detaylarý]

-- 11161 için bu güne kadar giren para
SELECT SUM(BirimFiyat*Miktar*(1-indirim)) AS ToplamSipariþTutarý
FROM [Sipariþ Detaylarý]
WHERE SipariþNo = 11161

-- Her bir sipariþin indirimli toplam satýþ tutarýný bulunuz
SELECT SipariþNo, SUM(BirimFiyat*Miktar*(1-indirim)) AS ToplamSipariþTutarý
FROM [Sipariþ Detaylarý]
GROUP BY SipariþNo
ORDER BY SUM(BirimFiyat*Miktar*(1-indirim)) ASC

-- Ýndirimli toplam satýþ tutarlarý 50 ile 100 tl arasý olan
-- sipariþleri listeleyiniz sýnýrlar dahil olsun
SELECT SipariþNo, SUM(BirimFiyat*Miktar*(1-indirim)) AS ToplamSatýþTutarý
FROM [Sipariþ Detaylarý]
GROUP BY SipariþNo
HAVING SUM(BirimFiyat*Miktar*(1-indirim)) between 50 and 100
ORDER BY SUM(BirimFiyat*Miktar*(1-indirim)) ASC
----------------------------------------------
-- Ürünler tablosunda Toplam StokTutarý 500 ile 1000 arasýndaki kategorileri listeleyiniz
SELECT * FROM Ürünler ORDER BY KategoriNo ASC
--
SELECT KategoriNo, SUM(BirimFiyat*StokMiktarý) AS ToplamStokTutarý
FROM Ürünler
GROUP BY KategoriNo
HAVING SUM(BirimFiyat*StokMiktarý) BETWEEN 500 AND 1000
ORDER BY SUM(BirimFiyat*StokMiktarý) ASC

-- Her bir satýcý firmaya ait toplam stok tutarý
-- 500 ile 1000 tl arasýnda olan firmalarý isteleyiniz
SELECT SatýcýFirmaNo, SUM(BirimFiyat*StokMiktarý) AS ToplamStokTutarý
FROM Ürünler
GROUP BY SatýcýFirmaNo
HAVING SUM(BirimFiyat*StokMiktarý) BETWEEN 500 AND 1000
ORDER BY SUM(BirimFiyat*StokMiktarý) DESC
--

-- Müþteri sayýsý 20 den fazla illeri listeleyiniz
SELECT COUNT(*) AS Sayý
FROM Müþteriler
GROUP BY Ýl
HAVING COUNT(*) >20
ORDER BY Ýl ASC

-- Müþteriler tablosunda tekrar eden Adlarý bulunuz en az 2 kere tekrar etsin
SELECT Adý, COUNT(*) AS TekrarSayýsý
FROM Müþteriler
GROUP BY Adý
HAVING COUNT(*)>1



/*
Açýklama Paragrafý
MS SQL Server da kullanýlan dil
Transact-SQL, T-SQL dir

SQL : Structured Query Language
    : Yapýsal Sorgulama Dili
	Script : Betik dili 
SQL Üç bölümden oluþur :
1. Query : Sorgu : Komutu SELECT
2. Data Manupilation Language(DML): Veri Kullaným dili
   INSERT : Bir tabloya kayýt girmek için
   UPDATE : Bir tablodaki kayýtlarý güncellemek için
   DELETE : Bir tablodaki kayýtlarý silmek için
3. Data Definition Language(DDL): Veri tanýmlama dili
   CREATE : Bir VT nesnesini yaratmak için
   ALTER : Bir VT nesnesini deðiþtirmek için
   DROP : Bir VT nesnesini silmek/Yok etmek için*/

2.Veri Kullanma Dili :
--INSERT : tabloya kayýt girmek için
--1.Kullaným : Sadece seçilen kolonlara kayýt girmek için :
INSERT INTO TabloAd(kolonAd1, kolonAd2,.....,kolonAdN)
VALUES(deðer1, deðer2,.....,deðerN)

-- Müþteriler tablosunun sadece seçtiðimiz kolonlarýný girebilir
SELECT * FROM Müþteriler

INSERT INTO Müþteriler(Soyadý, Adý, MüþteriNo, il)
VALUES( 'Deniz','Ali','Denal','Balýkesir')

-- Ürünler tablosuna fiyatý 15.5 olan 7 adet begonvil ekleyelim
SELECT * FROM Ürünler
--
INSERT INTO Ürünler(Tükendi,ÜrünAd,BirimFiyat,StokMiktarý)
VALUES(0,'Begonvil',15,5,7)
-- Tükendi null olamaz!!!!
-- ÜrünNo PK(PRÝMARY KEY) olduðunda null olmaz!!!
2.Kullaným tablonun tüm kolonlarýna veri girildiðinde kolonAdý yazýlmaz,
  deðerler tablodaki sýrada verilir.
  INSERT INTO TabloAdý
  VALUES(deðer1,deðer2,...,deðerN)
-- UMAAD, Ada UMAR, Atatürk M. , Karesi, Balýkesir,10020,TR,
-- (266)1234567 yeni müþteri olarak kayýt et
INSERT INTO Müþteriler
VALUES('UMAAD', 'Ada', 'UMAR', 'Atatürk M.', 'Karaesi',
        'Balýkesir','10020','TR','(266)1234567')

-- Ürünler tablosuna kayýt edin :
INSERT INTO Ürünler
VALUES(228,'Lübnan Sediri','',10,13,'1 adet',98.75,5,1,1,0)

3. Kullaným :Birden fazla satýrý (tuple) tek seferde kayýt etmek istersek
INSERT INTO Müþteriler(MüþteriNo,Adý,Soyadý)
VALUES ('AAAA1','Zeynep','Umar'),
       ('AAAA2','Burcu','Uydan'),
	   ('AAAA3','Mert','Gürboy')
SELECT * FROM Müþteriler