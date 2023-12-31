-- Ad� Burcu olan Ankaral� M��terileri listeleyiniz
SELECT * FROM M��teriler
WHERE (Ad� = 'Burcu' AND il = 'Ankara')

-- Ad� Ahmet olan m��teriler ile birlikte Burcu olan m��terileri de listeleyiniz
SELECT * FROM M��teriler
WHERE (Ad� = 'Ahmet' OR Ad� = 'Burcu')

-- Fiyat� 10 TL den pahal� 20 TL den ucuz �r�nleri listeleyiniz
--<---------0-----------10--------20-------> Fiyat
                        --------------->10<Fiyat
	    --Fiyat<20<---------------

SELECT * FROM �r�nler
WHERE BirimFiyat>10 AND BirimFiyat<20
ORDER BY BirimFiyat ASC

-- Stok Miktar� 10 dan az ve 20 den �ok olan �r�nleri listeleyiniz
--<---------0------------10-------------20-------------
--        <--------------               ------------->
SELECT * FROM �r�nler
WHERE StokMiktar�<10 OR StokMiktar�>20
ORDER BY StokMiktar� ASC

-- Ad� Ertu�ruldan b�y�k , Umuttan k���k olanlar�n� listeleyiniz
-- Alfabetik
SELECT * FROM M��teriler
WHERE Ad�>'Ertu�rul' AND Ad�<'Umut'
ORDER BY Ad� ASC

-- Aral�k Sorgulamak i�in BETWEEN
-- S�n�rlar dahildir!!!
SELECT * FROM TabloAd�
WHERE KolonAd BETWEEN k���kde�er AND b�y�kde�er

-- Ad� Ertu�ruldan b�y�k , Umuttan k���k olanlar�n� listeleyiniz
-- Alfabetik
-- S�n�rlar dahil olsun
SELECT * FROM M��teriler
WHERE Ad� BETWEEN 'Ertu�lur'AND 'Umut'
ORDER BY Ad� ASC

-- Fiyat� 10 TL den pahal� 20 TL den ucuz �r�nleri listeleyiniz
-- S�n�rlar dahil
SELECT * FROM �r�nler
WHERE BirimFiyat BETWEEN 10 AND 20
ORDER BY BirimFiyat ASC

-- Sadece Latince Ad� Bo� NULL olan �r�nleri Listeleyiniz
SELECT * FROM �r�nler
WHERE LatinceAd� IS NULL

-- Latince Ad� Bo�/NULL olmayan �r�nleri Listeleyiniz
SELECT * FROM �r�nler
WHERE LatinceAd� IS NOT NULL
-- Alternatif bir ��z�m geldi(ASCII kodlama sistemiyle alakal�)(UNICORD dili)
SELECT * FROM �r�nler
WHERE LatinceAd� >'A'


-- Karakter katarlar� i�in iki joker:
% : Herhangi bir hece yerine joker, bo� karakter katar�da(karakter dizisi) olabilir.
_ : Herhangi bir harf yerine joker

-- Bu jokerler = denktir ile �al��mazlar !!!
-- LIKE : gibi benzer operat�r� ile �al���rlar.

-- As� A harfi ile ba�layan M��terileri listeleyelim
SELECT * FROM M��teriler
WHERE Ad� ='A%' -- �ALI�MAZ! Ad� Tam olarak A% arar
-- O halde A ile ba�layan herhangi bir karakter katar� ile devam edenler BENZER/LIKE arayal�
SELECT * FROM M��teriler
WHERE Ad� LIKE'A%' -- �ALI�IR

-- Ad� Er hecesi ile biten m��teriler :
SELECT * FROM M��teriler
WHERE Ad� LIKE'%er'

-- Ad�nda er hecesi ge�en m��terileri listeleyelim
-- er, solunda sa��nda yada arada bir yerlerde olabilir.
SELECT * FROM M��teriler
WHERE Ad� LIKE'%ER%'
ORDER BY Ad� ASC

-- _ : tek bir harf joker
SELECT * FROM M��teriler
WHERE Ad� L�KE 'AL%'

-- Bir m��teri ar�yoruz ad� �� harfli 
-- Al ile ba�l�yor
-- Alper 5 harf
SELECT * FROM M��teriler
WHERE Ad� LIKE 'Al_'--_ tek harf
-- Es ile ba�layan m��teri
SELECT * FROM M��teriler
WHERE Ad� LIKE 'ES%'
-- Es ile ba�layan a ile biten 4 harfli m��teri ad�
SELECT * FROM M��teriler
WHERE Ad� LIKE 'ES_a' --_ tek harf esin yok esra,esma var
-- Al ile ba�layan 5 harfli
SELECT * FROM M��teriler
WHERE Ad� LIKE 'AL___'

-- M��terilerin Adlar�
-- A,B,C,�,D,E harfi ile ba�layanlar�n listesi
-- F;G,H,I,�,J ile ba�layanlar farkl� bir liste
-- K,L,M,N,O,�,U ile ba�...
-- ...Alfabeden dilim ��kart�yoruz...
SELECT * FROM M��teriler
WHERE Ad� LIKE 'A%' OR Ad� LIKE 'B%' OR Ad� LIKE 'C%' OR Ad� LIKE '�%' OR Ad� LIKE 'D%' OR Ad� LIKE 'E%'
ORDER BY Ad� ASC
-- Alfabeden Dilim ��kartman�n Kolay� Var
SELECT * FROM M��teriler
WHERE Ad� LIKE '[A-E]%'
ORDER BY Ad� ASC
--
SELECT * FROM M��teriler
WHERE Ad� LIKE '[K_U]%'
ORDER BY Ad� ASC

-- Ad� KLMNO�U harfleri ile ba�lamayanlar� listelersek
SELECT * FROM M��teriler
WHERE Ad� NOT LIKE '[K-U]%'
ORDER BY Ad� ASC

-- MS-SQL server dili Transact SQL : T-SQL
-- Ayn� ��z�m ��ylede olabilir:
SELECT * FROM M��teriler
WHERE Ad� LIKE '[^K-U]%'
ORDER BY Ad� ASC
---------------------------------
-- Fiyat� 10,20,30,40,50,60 TL olan �r�nleri listeleyiniz
SELECT * FROM �r�nler
WHERE BirimFiyat=10 OR BirimFiyat=20 OR BirimFiyat=30 OR BirimFiyat=40 OR BirimFiyat=50 OR BirimFiyat=60
ORDER BY BirimFiyat ASC
-- Kolay yolu : Alt sorgu Kullanmak :
-- Bir k�me g�sterip, bu k�menin i�inde olanlar� listele  demek
SELECT * FROM �r�nler
WHERE BirimFiyat IN (10,20,30,40,50,60)
ORDER BY BirimFiyat ASC
-- Ad� Adem, Ay�e, G�zde, Tolga, Ertu�rul, Turan olan m��terileri listeleyiniz
SELECT * FROM M��teriler
WHERE Ad�='Adem' OR Ad�='Ay�e' OR Ad�='G�zde' OR Ad�='Tolga' OR Ad�='Ertu�rul' OR Ad�='Turan'
ORDER BY Ad� ASC
-- Kolay yol
SELECT * FROM M��teriler
WHERE Ad� IN ('Adem','Ay�e','G�zde','Tolga','Ertu�rul','Turan')
ORDER BY Ad� ASC

-- Bir kolondaki kay�tlardan sadece Farkl� Olanlar� getirmek DISTINCT/FARKLI(Ayr� olanlar� getir anlam�nda)
SELECT il FROM M��teriler
-- Sadece farkl� illeri getirmek i�in
SELECT DISTINCT il FROM M��teriler
ORDER BY il ASC
-- il il�e �iftlerinden farkl� olanlar� listeleyelim
SELECT DISTINCT il�e, il FROM M��teriler
ORDER BY il ASC, il�e ASC
-- �r�nler tablosundaki f�yatlardan farkl� olanlar� listeleyiniz
SELECT DISTINCT BirimFiyat FROM �r�nler
ORDER BY BirimFiyat ASC