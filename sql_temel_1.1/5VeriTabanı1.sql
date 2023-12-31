-- Sipari� detaylar� tablosunda 11161 numaral� sipari�in
-- indirimli sat�� tutarlar�n� bulal�m
SELECT * , BirimFiyat*Miktar AS Sat��Tutar�,
           BirimFiyat*Miktar-BirimFiyat*Miktar*�ndirim AS indirimli,
           BirimFiyat*Miktar*(1-indirim) AS indirimli
FROM [Sipari� Detaylar�]

/*
indirimliSat��Tutar� = sat��Tutar� - indirimMiktar
       indirim %10 olsa : %10 = 10/100 = 0.1
indirimliTutar� = Fiyat*Miktar - Fiyat*Miktar*0.1
indirimliTutar� = Fiyat*Miktar(1 - 0.1)

indirimliTutar� = Fiyat*Miktar(1 - indirim)
*/


-- Bu g�ne kadar �irketin kasas�na giren ger�ek para toplam ne kadard�r??
SELECT SUM(BirimFiyat*Miktar*(1-indirim)) AS ToplamSipari�Tutar�
FROM [Sipari� Detaylar�]

-- 11161 i�in bu g�ne kadar giren para
SELECT SUM(BirimFiyat*Miktar*(1-indirim)) AS ToplamSipari�Tutar�
FROM [Sipari� Detaylar�]
WHERE Sipari�No = 11161

-- Her bir sipari�in indirimli toplam sat�� tutar�n� bulunuz
SELECT Sipari�No, SUM(BirimFiyat*Miktar*(1-indirim)) AS ToplamSipari�Tutar�
FROM [Sipari� Detaylar�]
GROUP BY Sipari�No
ORDER BY SUM(BirimFiyat*Miktar*(1-indirim)) ASC

-- �ndirimli toplam sat�� tutarlar� 50 ile 100 tl aras� olan
-- sipari�leri listeleyiniz s�n�rlar dahil olsun
SELECT Sipari�No, SUM(BirimFiyat*Miktar*(1-indirim)) AS ToplamSat��Tutar�
FROM [Sipari� Detaylar�]
GROUP BY Sipari�No
HAVING SUM(BirimFiyat*Miktar*(1-indirim)) between 50 and 100
ORDER BY SUM(BirimFiyat*Miktar*(1-indirim)) ASC
----------------------------------------------
-- �r�nler tablosunda Toplam StokTutar� 500 ile 1000 aras�ndaki kategorileri listeleyiniz
SELECT * FROM �r�nler ORDER BY KategoriNo ASC
--
SELECT KategoriNo, SUM(BirimFiyat*StokMiktar�) AS ToplamStokTutar�
FROM �r�nler
GROUP BY KategoriNo
HAVING SUM(BirimFiyat*StokMiktar�) BETWEEN 500 AND 1000
ORDER BY SUM(BirimFiyat*StokMiktar�) ASC

-- Her bir sat�c� firmaya ait toplam stok tutar�
-- 500 ile 1000 tl aras�nda olan firmalar� isteleyiniz
SELECT Sat�c�FirmaNo, SUM(BirimFiyat*StokMiktar�) AS ToplamStokTutar�
FROM �r�nler
GROUP BY Sat�c�FirmaNo
HAVING SUM(BirimFiyat*StokMiktar�) BETWEEN 500 AND 1000
ORDER BY SUM(BirimFiyat*StokMiktar�) DESC
--

-- M��teri say�s� 20 den fazla illeri listeleyiniz
SELECT COUNT(*) AS Say�
FROM M��teriler
GROUP BY �l
HAVING COUNT(*) >20
ORDER BY �l ASC

-- M��teriler tablosunda tekrar eden Adlar� bulunuz en az 2 kere tekrar etsin
SELECT Ad�, COUNT(*) AS TekrarSay�s�
FROM M��teriler
GROUP BY Ad�
HAVING COUNT(*)>1



/*
A��klama Paragraf�
MS SQL Server da kullan�lan dil
Transact-SQL, T-SQL dir

SQL : Structured Query Language
    : Yap�sal Sorgulama Dili
	Script : Betik dili 
SQL �� b�l�mden olu�ur :
1. Query : Sorgu : Komutu SELECT
2. Data Manupilation Language(DML): Veri Kullan�m dili
   INSERT : Bir tabloya kay�t girmek i�in
   UPDATE : Bir tablodaki kay�tlar� g�ncellemek i�in
   DELETE : Bir tablodaki kay�tlar� silmek i�in
3. Data Definition Language(DDL): Veri tan�mlama dili
   CREATE : Bir VT nesnesini yaratmak i�in
   ALTER : Bir VT nesnesini de�i�tirmek i�in
   DROP : Bir VT nesnesini silmek/Yok etmek i�in*/

2.Veri Kullanma Dili :
--INSERT : tabloya kay�t girmek i�in
--1.Kullan�m : Sadece se�ilen kolonlara kay�t girmek i�in :
INSERT INTO TabloAd(kolonAd1, kolonAd2,.....,kolonAdN)
VALUES(de�er1, de�er2,.....,de�erN)

-- M��teriler tablosunun sadece se�ti�imiz kolonlar�n� girebilir
SELECT * FROM M��teriler

INSERT INTO M��teriler(Soyad�, Ad�, M��teriNo, il)
VALUES( 'Deniz','Ali','Denal','Bal�kesir')

-- �r�nler tablosuna fiyat� 15.5 olan 7 adet begonvil ekleyelim
SELECT * FROM �r�nler
--
INSERT INTO �r�nler(T�kendi,�r�nAd,BirimFiyat,StokMiktar�)
VALUES(0,'Begonvil',15,5,7)
-- T�kendi null olamaz!!!!
-- �r�nNo PK(PR�MARY KEY) oldu�unda null olmaz!!!
2.Kullan�m tablonun t�m kolonlar�na veri girildi�inde kolonAd� yaz�lmaz,
  de�erler tablodaki s�rada verilir.
  INSERT INTO TabloAd�
  VALUES(de�er1,de�er2,...,de�erN)
-- UMAAD, Ada UMAR, Atat�rk M. , Karesi, Bal�kesir,10020,TR,
-- (266)1234567 yeni m��teri olarak kay�t et
INSERT INTO M��teriler
VALUES('UMAAD', 'Ada', 'UMAR', 'Atat�rk M.', 'Karaesi',
        'Bal�kesir','10020','TR','(266)1234567')

-- �r�nler tablosuna kay�t edin :
INSERT INTO �r�nler
VALUES(228,'L�bnan Sediri','',10,13,'1 adet',98.75,5,1,1,0)

3. Kullan�m :Birden fazla sat�r� (tuple) tek seferde kay�t etmek istersek
INSERT INTO M��teriler(M��teriNo,Ad�,Soyad�)
VALUES ('AAAA1','Zeynep','Umar'),
       ('AAAA2','Burcu','Uydan'),
	   ('AAAA3','Mert','G�rboy')
SELECT * FROM M��teriler