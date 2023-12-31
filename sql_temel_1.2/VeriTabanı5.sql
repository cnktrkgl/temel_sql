--Tekrar
--De�i�ken Kullanarak
--De�i�ken kullanarak �r�nler tablosunda
-- G�z �i�demi Fiyat ve Miktar�n� birer de�i�kene atay�n

DECLARE @fiyat money, @miktar smallint, @ad nvarchar(40)
SET @ad = 'G�z �i�demi'
SELECT @fiyat = BirimFiyat, @miktar = StokMiktar�
FROM �r�nler WHERE �r�nAd = @ad
print @ad+' Fiyat:'+CONVERT(varchar, @fiyat)
		 +'TL, Miktar:'+CONVERT(varchar,@miktar)

-- G�z �i�deminin �r�nNo=2222, �i�dem, 40TL, 400Adet, 
-- olarak g�ncelleyin

GO -- �le ay�r�rsak edit�r�n hata vermesini engelleriz ama �al��t�rmay�z.
DECLARE @fiyat money, @miktar smallint, @ad nvarchar(40), 
		@no_eski int, @no_yeni int
SET @no_eski =2
SET @no_yeni =2222
SET @ad = '�i�dem'
SET @miktar =40
SET @fiyat =40
UPDATE �r�nler
SET �r�nAd=@ad, BirimFiyat=@fiyat, StokMiktar�=@miktar,
	�r�nNo=@no_yeni
WHERE �r�nNo=@no_eski

-- 333 Armut 17 TL 12 ADET t�kenmedi olarak yeni kay�t girin
-- de�i�ken kullanarak

GO
DECLARE @fiyat money, @miktar smallint, @ad nvarchar(40), 
		@no int, @tuken bit
SET @no =3333
SET @ad = 'Armut'
SET @miktar =12
SET @fiyat =17
SET @tuken =0
INSERT INTO �r�nler(�r�nNo, �r�nAd, BirimFiyat, StokMiktar�, T�kendi)
VALUES(@no, @ad, @fiyat, @miktar, @tuken)

-- de�i�ken kullanarak Armutu silin

GO
DECLARE @no int
SET @no =3333
DELETE FROM �r�nler WHERE �r�nNo=@no

-- De�i�ken kullanarak bu g�n ka� g�nl�k oldu�unuzu bulunuz?

GO
DECLARE @dogtar date, @suan date, @gun int
SET @dogtar ='1971.06.10'
SET @suan = GETDATE()
SET @gun = DATEDIFF(DAY, @dogtar, @suan)
print @gun

----------------------------------------------------------

/* AKI� KONTROL DEY�MLER� :
	SELECT ... CASE ... WHEN ... THEN yap�s�
	IF ... ELSE ...
	WHILE ...
	BREAK
	CONTINUE
*/

RASTGELE SAYI �RETMEK ���N RAND() [0.0,1.0] aral���nda rastgele say� 
RAND(SEED) : SEED �retilen say� b�y�kl���nne etki ETMEZ, �retilen 
rastgele say� dizisinden ka��nc�s�n�n al�naca��n� belirler
print RAND()
SELECT RAND()
print RAND(2)
SELECT RAND(3)


DECLARE @deger int
SET @deger = 100*RAND()-50
IF(@deger>=0)
 BEGIN
	-- kodlar
	print 'Pozitif'
 END
ELSE
 BEGIN
	-- kodlar
	print 'Negatif'
 END
 print @deger

------------------------------------------------------

SELECT CASE :
SELECT * FROM �r�nler
-- % : Mod�l yani b�lme kalan
SELECT 6%2 -- kalan 0 �ift
SELECT 5%2 -- kalan 1 tek
SELECT 111%2 -- 1 tek
SELECT *, �r�nNO%2 FROM �r�nler

-- �r�nNo tek ise tek, �ift ise �ift yazan yeni bir kolon i�in:
SELECT �r�nAd, �r�nNo, TEK��FT =
 CASE 
	   WHEN(�r�nNo%2=0) THEN '��FT'
	   WHEN(�r�nNo%2=1) THEN 'TEK'
 END
FROM �r�nler

-------------------------------------------
SELECT * FROM �r�nler
-- Stok Miktar�, alt limiti ve t�kendi kolonlar�ndan yararlanarak
-- envanter durumu ile ilgili yorum yapal�m
SELECT �r�nNo, �r�nAd, StokMiktar�, StokMiktar�, StokAltLimit, T�kendi,
EnvanterDurumu =
CASE
	WHEN T�kendi =0 AND StokMiktar�>StokAltLimit
	THEN 'Stokta Var.'
	WHEN T�kendi =0 AND StokMiktar�<=StokAltLimit
	THEN 'Yeniden Sipari� Ver!'
	WHEN T�kendi =1 AND StokMiktar�>0
	THEN 'Seri sonu �r�nlerden kurtul!'
	WHEN T�kendi =1 AND StokMiktar�=0
	THEN 'Seri sonu �r�n, sorun yok.'
END
FROM �r�nler

---------------------------------------------
WHILE(Ko�ul)
BEGIN
	IF(Ko�ul2) CONTINUE
	IF(Ko�ul3) BREAK
	-- kodalar
END
-- WHILE, ko�ul do�ru oldu�u s�rece d�nen bir d�ng�d�r.
-- BREAK, ko�ul2 do�ru oldu�unda d�ng�y� k�rar, sonland�r�r
-- CONTINUE, ko�ul3 do�ru oldu�unda, CONTINUE den sonraki
-- sat�rlar �al��t�r�lmadan program sat�r� d�ng�n�n ilk sat�r�na
-- getirilir(bir sonraki tur i�in!)

-- 1 den 11 e sayal�m (s�n�rlar dahil)
DECLARE @say int
SET @say =1
WHILE(@say<12)
BEGIN
print @say
SET @say = @say+1
END
---------------------------------
GO
DECLARE @say int
SET @say =1
WHILE(1=1)
BEGIN
print @say
SET @say = @say+1
IF (@say=12) BREAK
END

-- 1 den 30 a kadar say�lar� yazd�r�rken say� 25 olunca d�ng�den
-- ��k�ls�n
GO
DECLARE @say int
SET @say =1
WHILE(@say<=30)
BEGIN
print @say
SET @say = @say+1
IF (@say=26) BREAK
END

-- 1 den 30 a kadar say�lar� yazd�r�l�rken [15,20] aras� yaz�lmas�n
-- (1,2,....13,14,21,22,....30)
GO
DECLARE @say int
SET @say =0
WHILE(@say<30)
BEGIN
SET @say = @say+1
IF ((@say>=15)AND(@say<=20)) CONTINUE --den sonras� atlan�r
print @say
END