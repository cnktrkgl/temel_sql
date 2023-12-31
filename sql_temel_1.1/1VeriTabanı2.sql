-- se�ilen kolonlar� sorgulamak
SELECT �r�nAd, BirimFiyat, StokMiktar�
FROM �r�nler
-- kolonlar�n yerini diledi�imiz gibi de�i�tirebilirsiniz
-- AS : kolon ad� belirler
SELECT StokMiktar� AS Miktar, �r�nAd AS  Ad�,
 BirimFiyat AS Fiyat
FROM �r�nler
-- �r�nlerin her birinin Stok Tutarlar�n� g�sterebilirsiniz
SELECT �r�nAd, BirimFiyat, StokMiktar�,
        BirimFiyat*StokMiktar� AS StokTutar�
FROM �r�nler
-- Ad� ve Soyad� kolonlar�n� birlikte AdS�yad olarak g�sterelim
SELECT Ad�+' '+Soyad� AS AdSoyad�, il FROM M��teriler
---------------------------------------------------------
-- SIRALAMAK
-- ORDER BY KolonADI ASC/DESC : Kolon ad�na g�re SIRALAMA
-- ASC : ASCENDING : Artan
-- DESC : DESCENDING : Azalan s�rada s�ralar
SELECT * FROM M��teriler
ORDER BY Ad� ASC -- Ada g�re artan s�rada s�ralar
-- M��terileri Soyad�na g�re Azalan s�rada s�ralayal�m
SELECT * FROM M��teriler
ORDER BY Soyad� DESC
-- �r�nleri fiyat�na g�re artan s�rada s�ralay�n�z
SELECT * FROM �r�nler
ORDER BY BirimFiyat ASC

-- M��terileri ile g�re azalan s�rada s�ralayal�m
SELECT * FROM M��teriler
ORDER BY �l DESC

-- Birden fazla kolona g�re s�ralama yapmak
-- ile g�re �ok say�da tekrar oldu�undan s�ralama i�in 2. bir kriter gerekli
SELECT * FROM M��teriler
ORDER BY �l DESC, �l�e ASC
-- hatta 3. bir s�ralama kriteri gerekli
SELECT * FROM M��teriler
ORDER BY �l DESC, �l�e ASC, Adres DESC
-- E�er ASC/DESC yaz�lmaz ise varsay�lan de�er ASC dir
SELECT Ad� FROM M��teriler
ORDER BY Ad� 
------------------------------------ S�ZMEK
SELECT * FROM TabloAd�
WHERE (Ko�ul)
-- Ko�ulu sa�layan sat�rlar� listeler
-- Ad� Ahmet olan m��terileri listeleyiniz
SELECT * FROM M��teriler
WHERE (Ad� = 'Ahmet')
-- Fiyat� 50 lira olan �r�nleri listeleyiniz
SELECT * FROM �r�nler
WHERE (BirimFiyat = 50)
-- Fiyat� 50 liradan pahal� �r�nleri listeleyiniz
SELECT * FROM �r�nler
WHERE (BirimFiyat > 50)
-- Fiyat� 50 liradan pahal� �r�nleri listeleyiniz
-- artan s�rada sralayal�m listeleyiniz
SELECT * FROM �r�nler
WHERE (BirimFiyat > 50)
ORDER BY BirimFiyat ASC
-- Ad� Burcu dan k���k olan M��terileri listeleyiniz
-- Azalan s�rada s�ralayal�m
SELECT * FROM M��teriler
WHERE Ad� < 'Burcu'
ORDER BY Ad� DESC
-- �zmirli m��terileri listeleyelim
SELECT * FROM M��teriler
WHERE �l = '�zmir'
-- �zmirli olmayan m��terileri listeleyelim
SELECT * FROM M��teriler
WHERE �l != '�zmir'
ORDER BY �l ASC
-- �kinci yol
SELECT * FROM M��teriler
WHERE �l <> '�zmir'
ORDER BY �l ASC
-- Fiyat� 10 liradan pahal�, 20 liradan ucuz �r�nleri listeleyiniz
SELECT * FROM �r�nler
WHERE BirimFiyat>10 AND BirimFiyat<20