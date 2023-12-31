--Tekrar
--Deðiþken Kullanarak
--Deðiþken kullanarak Ürünler tablosunda
-- Güz Çiðdemi Fiyat ve Miktarýný birer deðiþkene atayýn

DECLARE @fiyat money, @miktar smallint, @ad nvarchar(40)
SET @ad = 'Güz Çiðdemi'
SELECT @fiyat = BirimFiyat, @miktar = StokMiktarý
FROM Ürünler WHERE ÜrünAd = @ad
print @ad+' Fiyat:'+CONVERT(varchar, @fiyat)
		 +'TL, Miktar:'+CONVERT(varchar,@miktar)

-- Güz Çiðdeminin ÜrünNo=2222, Çiðdem, 40TL, 400Adet, 
-- olarak güncelleyin

GO -- Ýle ayýrýrsak editörün hata vermesini engelleriz ama çalýþtýrmayýz.
DECLARE @fiyat money, @miktar smallint, @ad nvarchar(40), 
		@no_eski int, @no_yeni int
SET @no_eski =2
SET @no_yeni =2222
SET @ad = 'Çiðdem'
SET @miktar =40
SET @fiyat =40
UPDATE Ürünler
SET ÜrünAd=@ad, BirimFiyat=@fiyat, StokMiktarý=@miktar,
	ÜrünNo=@no_yeni
WHERE ÜrünNo=@no_eski

-- 333 Armut 17 TL 12 ADET tükenmedi olarak yeni kayýt girin
-- deðiþken kullanarak

GO
DECLARE @fiyat money, @miktar smallint, @ad nvarchar(40), 
		@no int, @tuken bit
SET @no =3333
SET @ad = 'Armut'
SET @miktar =12
SET @fiyat =17
SET @tuken =0
INSERT INTO Ürünler(ÜrünNo, ÜrünAd, BirimFiyat, StokMiktarý, Tükendi)
VALUES(@no, @ad, @fiyat, @miktar, @tuken)

-- deðiþken kullanarak Armutu silin

GO
DECLARE @no int
SET @no =3333
DELETE FROM Ürünler WHERE ÜrünNo=@no

-- Deðiþken kullanarak bu gün kaç günlük olduðunuzu bulunuz?

GO
DECLARE @dogtar date, @suan date, @gun int
SET @dogtar ='1971.06.10'
SET @suan = GETDATE()
SET @gun = DATEDIFF(DAY, @dogtar, @suan)
print @gun

----------------------------------------------------------

/* AKIÞ KONTROL DEYÝMLERÝ :
	SELECT ... CASE ... WHEN ... THEN yapýsý
	IF ... ELSE ...
	WHILE ...
	BREAK
	CONTINUE
*/

RASTGELE SAYI ÜRETMEK ÝÇÝN RAND() [0.0,1.0] aralýðýnda rastgele sayý 
RAND(SEED) : SEED üretilen sayý büyüklüðünne etki ETMEZ, üretilen 
rastgele sayý dizisinden kaçýncýsýnýn alýnacaðýný belirler
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
SELECT * FROM Ürünler
-- % : Modül yani bölme kalan
SELECT 6%2 -- kalan 0 çift
SELECT 5%2 -- kalan 1 tek
SELECT 111%2 -- 1 tek
SELECT *, ÜrünNO%2 FROM Ürünler

-- ÜrünNo tek ise tek, çift ise çift yazan yeni bir kolon için:
SELECT ÜrünAd, ÜrünNo, TEKÇÝFT =
 CASE 
	   WHEN(ÜrünNo%2=0) THEN 'ÇÝFT'
	   WHEN(ÜrünNo%2=1) THEN 'TEK'
 END
FROM Ürünler

-------------------------------------------
SELECT * FROM Ürünler
-- Stok Miktarý, alt limiti ve tükendi kolonlarýndan yararlanarak
-- envanter durumu ile ilgili yorum yapalým
SELECT ÜrünNo, ÜrünAd, StokMiktarý, StokMiktarý, StokAltLimit, Tükendi,
EnvanterDurumu =
CASE
	WHEN Tükendi =0 AND StokMiktarý>StokAltLimit
	THEN 'Stokta Var.'
	WHEN Tükendi =0 AND StokMiktarý<=StokAltLimit
	THEN 'Yeniden Sipariþ Ver!'
	WHEN Tükendi =1 AND StokMiktarý>0
	THEN 'Seri sonu ürünlerden kurtul!'
	WHEN Tükendi =1 AND StokMiktarý=0
	THEN 'Seri sonu ürün, sorun yok.'
END
FROM Ürünler

---------------------------------------------
WHILE(Koþul)
BEGIN
	IF(Koþul2) CONTINUE
	IF(Koþul3) BREAK
	-- kodalar
END
-- WHILE, koþul doðru olduðu sürece dönen bir döngüdür.
-- BREAK, koþul2 doðru olduðunda döngüyü kýrar, sonlandýrýr
-- CONTINUE, koþul3 doðru olduðunda, CONTINUE den sonraki
-- satýrlar çalýþtýrýlmadan program satýrý döngünün ilk satýrýna
-- getirilir(bir sonraki tur için!)

-- 1 den 11 e sayalým (sýnýrlar dahil)
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

-- 1 den 30 a kadar sayýlarý yazdýrýrken sayý 25 olunca döngüden
-- çýkýlsýn
GO
DECLARE @say int
SET @say =1
WHILE(@say<=30)
BEGIN
print @say
SET @say = @say+1
IF (@say=26) BREAK
END

-- 1 den 30 a kadar sayýlarý yazdýrýlýrken [15,20] arasý yazýlmasýn
-- (1,2,....13,14,21,22,....30)
GO
DECLARE @say int
SET @say =0
WHILE(@say<30)
BEGIN
SET @say = @say+1
IF ((@say>=15)AND(@say<=20)) CONTINUE --den sonrasý atlanýr
print @say
END