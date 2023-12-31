-- DE���KENLER
DECLARE @de�i�kenAd� VeriTipi

Tablo yarat�rken kolonlarda kulland���m�z veri tipleri ile 
de�i�ken tan�mlayabiliriz..

Sistem de�i�kenlerinin solunda iki tane @ olur!
@@ERROR, @@rowcount

SELECT 5/0 -- s�f�ra b�lme hatas� 8134
SELECT @@ERROR

SELECT 5/0
SELECT * FROM master.dbo.sysmessages
WHERE error = @@ERROR

@@rowcount :
Insert, Update, Delete i�lemlerinden ka� sat�r etkilendi�ini g�sterir

-- �r�nler tablosunda t�m �r�nlerin miktar�n� 1 artt�ral�m

UPDATE �r�nler
SET StokMiktar� = StokMiktar� +1
print @@rowcount

DECLARE @de�i�kenAd� VeriTipi

DECLARE @ad varchar(50), @adet int, @fiyat float 
SET @ad = 'Tablet'
SET @fiyat = 1299.99
SET @adet = 5
print @ad 
print @fiyat 
print @adet -- print messages olarak g�sterir basar
SELECT @ad AS Ad�, @fiyat AS Fiyat, @adet AS Miktar -- Select result yani table olarak g�sterir basar

CONVERT ile tip d�n���m� :
HedefVeriTipindeDe�i�ken = CONVERT(HedefVeriTipi, EskiVeriTipiDe�i�ken)

DECLARE @ad varchar(50), @adet int, @fiyat float 
SET @ad = 'Tablet'
SET @fiyat = 1299.99
SET @adet = 5
print '�r�n Ad�:' + @ad + ', Fiyat:' + CONVERT(varchar, @fiyat) + ', Adet:' + CONVERT(varchar, @adet)
SELECT @ad AS Ad�, @fiyat AS Fiyat, @adet AS Miktar

-- SELECT ile de de�i�kenle de�er atabiliriz

DECLARE @z int
SELECT @z =99
print @z

-- Bir sorgu sonucundan d�nen bir de�eri bir de�i�kene atamak
-- Sihirli Zambak �n fiyat�n� bir de�i�kene atayal�m

DECLARE @fiyat money
SET @fiyat = (SELECT BirimFiyat FROM �r�nler WHERE �r�nAd = 'Sihirli Zambak')
print @fiyat

-- G�z �i�demi nin latince ad�n�, fiyat�n�, miktar�n� birer de�i�kene aktaral�m

DECLARE @latince nvarchar(50), @fiyat money, @adet smallint
SET @fiyat = (SELECT BirimFiyat FROM �r�nler WHERE �r�nAd = 'G�z �i�demi')
SET @adet = (SELECT StokMiktar� FROM �r�nler WHERE �r�nAd = 'G�z �i�demi')
SET @latince = (SELECT LatinceAd� FROM �r�nler WHERE �r�nAd = 'G�z �i�demi')
print @latince
print @fiyat
print @adet
-- Bu �ok uzun oldu daha k�sa bir yol var!!

DECLARE @latince nvarchar(50), @fiyat money, @adet smallint,
		@mesaj varchar(250)
SELECT @fiyat=BirimFiyat, @adet=StokMiktar�, 
		@latince=LatinceAd�
FROM �r�nler
WHERE �r�nAd='G�z �i�demi'
SET @mesaj='Latince Ad�:'+ @latince +', Fiyat�:'+
			CONVERT(varchar,@fiyat)+', Miktar:'+
			CONVERT(varchar,@adet)
print @mesaj

-- DE���KEN DE�ERLER�N� INSERT �LE TABLOYA KAYDETMEK :
-- Nergis 33 adet, fiyat� 17.58 TL �r�nler tablosuna kay�t edelim
-- �r�nNo : 214, t�kendi 0

DECLARE @PK int, @ad nvarchar(40), @adet smallint,
		@fiyat money, @tuken bit
SET @PK =214
SET @ad ='Nergis'
SET @fiyat =17.58
SET @adet =33
SET @tuken =0
INSERT INTO �r�nler(�r�nNo,�r�nAd,BirimFiyat,StokMiktar�,T�kendi)
VALUES(@PK,@ad,@fiyat,@adet,@tuken)

-- DE���KEN KULLANARAK UPDATE :
-- 214 nolu �r�n�, Sar� Nergis, 22.7TL
-- 0 adet t�kendi olarak g�ncelleyiniz
DECLARE @PK int, @ad nvarchar(40), @adet smallint,
		@fiyat money, @tuken bit
SET @PK =214
SET @ad ='Sar� Nergis'
SET @fiyat = 22.7
SET @adet = 0
SET @tuken = 1
UPDATE �r�nler -- Son �� sat�r formda yaz�l�r ��nk� �zellikler tan�ml�d�r.
SET �r�nAd=@ad,BirimFiyat=@fiyat,StokMiktar�=@adet,T�kendi=@tuken
WHERE �r�nNo=@PK

-- DE���KEN KULLANARAK DELETE :
-- 214 nolu �r�n� siliniz
DECLARE @PK int
SET @PK =214
DELETE FROM �r�nler WHERE �r�nNo =@PK

-- DATATIME -> yaz�ya d�n���mde stiller
DECLARE @an datetime
SET @an = GETDATE()
SELECT @an AS Oldu�uGibi, CONVERT(varchar, @an,113) AS Stil_113,
							CONVERT(varchar, @an,104) AS Stil_104,
							CONVERT(varchar, @an,114) AS Stil_114,
							CONVERT(varchar, @an,111) AS Stil_111

-- De�i�ken ile verilen iki tarih aras�nda ka� g�n ge�ti ?
DECLARE @tar1 date, @tar2 date, @gun int
SET @tar1='1071.08.06'
SET @tar2='1922.08.30'
SET @gun = DATEDIFF(DAY,@tar1,@tar2) -- SECOND,MINUTE,HOUR,DAY,MONTH,YEAR
print @gun