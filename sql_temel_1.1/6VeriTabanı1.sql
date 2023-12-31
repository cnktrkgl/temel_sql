-- S�navdan �nce insert into 3 �e�idini g�rm��t�k..

-- DML den update ve delete ile devam ediyoruz

-- UPDATE ko�ulu sa�layan sat�rlarda, se�ilen kolonlar�n de�erini g�nceller..

UPDATE TabloAd�
   SET KolonAd1 = yenide�er1,
   KolonAd2 = yenide�er2,
   ...
   KolonAdN = yenide�erN
WHERE (Ko�ul)'bulmak istediklerimiz'

-- ili Ankara il�esi �anaya olan M��terilerin il�esini
-- �ankaya olarak g�ncelleyelim :
SELECT * FROM M��teriler
WHERE �l='Ankara' AND �l�e = '�anaya'
-- M��teriNo DERNE ve SAGYA olan iki ki�i
UPDATE M��teriler
SET �l�e='�ankaya'
WHERE �l='Ankara' AND �l�e='�anaya'
-- g�relim d�zelmi� mi?
SELECT * FROM M��teriler WHERE M��teriNo IN ('DERNE','SAGYA')
--
-- Kategoriler tablosunda KategoriAd� ���EK So�anlar�, So�anl� �i�ekler olarak g�ncelleyiniz

SELECT * FROM Kategoriler
--
UPDATE Kategoriler
SET KategoriAd� = 'So�anl� �i�ekler'
WHERE KategoriAd� = '�i�ek So�anlar�'
--
-- �r�nler tablosunda  LaticeAd� NULL olan kay�tlar�
-- 'Yok' olarak g�ncelleyiniz
SELECT * FROM �r�nler WHERE LatinceAd� IS NULL
--
UPDATE �r�nler
SET LatinceAd� = 'YOK'
WHERE LatinceAd� IS NULL

--
-- K�� �iLe�inden 4 tane sat�ld�, �r�nler tablosunu g�ncelleyiniz
UPDATE �r�nler
SET StokMiktar� = StokMiktar�-4
WHERE �r�nAd = 'K�� �ile�i'

-- K�� �ile�inden 16 adet stok giri�i yapmak �zere tablosunu g�ncelleyiniz
UPDATE �r�nler
SET StokMiktar� = StokMiktar�+16
WHERE �r�nAd = 'K�� �ile�i'

-- �renler tablosunda A�a�lar kategorisindaki �r�nlere
-- %5 zam yap�n�z
-- Zaml�BirimFiyat*5/100
-- Zaml�BirimFiyat*(1+0.05) = Zaml�BirimFiyat*1.05
UPDATE �r�nler
SET BirimFiyat = BirimFiyat*5/100
WHERE KategoriNo = 13

-- T�m �r�nlere %8 indirim uygulay�n�z?
-- �ndirimliBirimFiyat = BirimFiyat - BirimFiyat*8/100
-- �ndirimliBirimFiyat = BirimFiyat*(1-0.08) = BirimFiyat*0.92 = BirimFiyat*.92
UPDATE �r�nler
SET BirimFiyat = BirimFiyat - BirimFiyat*8/100

-- 5 tl den ucuz �r�nlere %20 zam ??
-- 100 tl den pahal� �r�nlere %10 indirim yap�n�z??

--

DELETE
-- Ko�ulu sa�layan kay�tlar� siler.
DELETE FROM TabloAd�
WHERE(ko�ul)
-- VT de kay�tlar daima tutulur, eski kay�t silinmez,
-- sadece yanl�� kay�tlar silinir
 
-- �r�nler tab. T�kenmi�/SeriSonu kay�tlar� silelim
-- �nce ko�ulu sa�layan sat�rlar� g�r�p, kp�ulu test edelim
SELECT * FROM �r�nler WHERE T�kendi=1
-- sonra silelimn
DELETE FROM �r�nler WHERE T�kendi=1
--
-- Yurtd���ndan m��terileri siliniz
SELECT * FROM M��teriler WHERE �lke != 'TR'
--
SELECT * FROM M��teriler WHERE �lke <> 'TR'

DELETE FROM M��teriler
WHERE �lke != 'TR'
---------------------------------------
-- Alt Sorgular

SELECT * FROM �r�nler WHERE BirimFiyat IN (10,20,30,40)

-- En ucuz �r�n�n fiyat�?
SELECT MIN(BirimFiyat) FROM �r�nler
-- En ucuz �r�n�n Ad�?
SELECT �r�nAd FROM �r�nler WHERE BirimFiyat = 1.61
-- �ki sorguyu birle�tirelim
SELECT �r�nAd FROM �r�nler
WHERE BirimFiyat = (SELECT MIN(BirimFiyat) FROM �r�nler)-- Alt sorgu

-- En pahal� �r�n�n ad� ?
SELECT �r�nAd FROM �r�nler
WHERE BirimFiyat = (SELECT MAX(BirimFiyat) FROM �r�nler)-- Alt sorgu

-- Alt sorgu parantez i�erisinde yaz�l�r.


