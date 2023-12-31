-- DEÐÝÞKENLER
DECLARE @deðiþkenAdý VeriTipi

Tablo yaratýrken kolonlarda kullandýðýmýz veri tipleri ile 
deðiþken tanýmlayabiliriz..

Sistem deðiþkenlerinin solunda iki tane @ olur!
@@ERROR, @@rowcount

SELECT 5/0 -- sýfýra bölme hatasý 8134
SELECT @@ERROR

SELECT 5/0
SELECT * FROM master.dbo.sysmessages
WHERE error = @@ERROR

@@rowcount :
Insert, Update, Delete iþlemlerinden kaç satýr etkilendiðini gösterir

-- Ürünler tablosunda tüm ürünlerin miktarýný 1 arttýralým

UPDATE Ürünler
SET StokMiktarý = StokMiktarý +1
print @@rowcount

DECLARE @deðiþkenAdý VeriTipi

DECLARE @ad varchar(50), @adet int, @fiyat float 
SET @ad = 'Tablet'
SET @fiyat = 1299.99
SET @adet = 5
print @ad 
print @fiyat 
print @adet -- print messages olarak gösterir basar
SELECT @ad AS Adý, @fiyat AS Fiyat, @adet AS Miktar -- Select result yani table olarak gösterir basar

CONVERT ile tip dönüþümü :
HedefVeriTipindeDeðiþken = CONVERT(HedefVeriTipi, EskiVeriTipiDeðiþken)

DECLARE @ad varchar(50), @adet int, @fiyat float 
SET @ad = 'Tablet'
SET @fiyat = 1299.99
SET @adet = 5
print 'Ürün Adý:' + @ad + ', Fiyat:' + CONVERT(varchar, @fiyat) + ', Adet:' + CONVERT(varchar, @adet)
SELECT @ad AS Adý, @fiyat AS Fiyat, @adet AS Miktar

-- SELECT ile de deðiþkenle deðer atabiliriz

DECLARE @z int
SELECT @z =99
print @z

-- Bir sorgu sonucundan dönen bir deðeri bir deðiþkene atamak
-- Sihirli Zambak ýn fiyatýný bir deðiþkene atayalým

DECLARE @fiyat money
SET @fiyat = (SELECT BirimFiyat FROM Ürünler WHERE ÜrünAd = 'Sihirli Zambak')
print @fiyat

-- Güz Çiðdemi nin latince adýný, fiyatýný, miktarýný birer deðiþkene aktaralým

DECLARE @latince nvarchar(50), @fiyat money, @adet smallint
SET @fiyat = (SELECT BirimFiyat FROM Ürünler WHERE ÜrünAd = 'Güz Çiðdemi')
SET @adet = (SELECT StokMiktarý FROM Ürünler WHERE ÜrünAd = 'Güz Çiðdemi')
SET @latince = (SELECT LatinceAdý FROM Ürünler WHERE ÜrünAd = 'Güz Çiðdemi')
print @latince
print @fiyat
print @adet
-- Bu çok uzun oldu daha kýsa bir yol var!!

DECLARE @latince nvarchar(50), @fiyat money, @adet smallint,
		@mesaj varchar(250)
SELECT @fiyat=BirimFiyat, @adet=StokMiktarý, 
		@latince=LatinceAdý
FROM Ürünler
WHERE ÜrünAd='Güz Çiðdemi'
SET @mesaj='Latince Adý:'+ @latince +', Fiyatý:'+
			CONVERT(varchar,@fiyat)+', Miktar:'+
			CONVERT(varchar,@adet)
print @mesaj

-- DEÐÝÞKEN DEÐERLERÝNÝ INSERT ÝLE TABLOYA KAYDETMEK :
-- Nergis 33 adet, fiyatý 17.58 TL Ürünler tablosuna kayýt edelim
-- ÜrünNo : 214, tükendi 0

DECLARE @PK int, @ad nvarchar(40), @adet smallint,
		@fiyat money, @tuken bit
SET @PK =214
SET @ad ='Nergis'
SET @fiyat =17.58
SET @adet =33
SET @tuken =0
INSERT INTO Ürünler(ÜrünNo,ÜrünAd,BirimFiyat,StokMiktarý,Tükendi)
VALUES(@PK,@ad,@fiyat,@adet,@tuken)

-- DEÐÝÞKEN KULLANARAK UPDATE :
-- 214 nolu ürünü, Sarý Nergis, 22.7TL
-- 0 adet tükendi olarak güncelleyiniz
DECLARE @PK int, @ad nvarchar(40), @adet smallint,
		@fiyat money, @tuken bit
SET @PK =214
SET @ad ='Sarý Nergis'
SET @fiyat = 22.7
SET @adet = 0
SET @tuken = 1
UPDATE Ürünler -- Son üç satýr formda yazýlýr çünkü özellikler tanýmlýdýr.
SET ÜrünAd=@ad,BirimFiyat=@fiyat,StokMiktarý=@adet,Tükendi=@tuken
WHERE ÜrünNo=@PK

-- DEÐÝÞKEN KULLANARAK DELETE :
-- 214 nolu ürünü siliniz
DECLARE @PK int
SET @PK =214
DELETE FROM Ürünler WHERE ÜrünNo =@PK

-- DATATIME -> yazýya dönüþümde stiller
DECLARE @an datetime
SET @an = GETDATE()
SELECT @an AS OlduðuGibi, CONVERT(varchar, @an,113) AS Stil_113,
							CONVERT(varchar, @an,104) AS Stil_104,
							CONVERT(varchar, @an,114) AS Stil_114,
							CONVERT(varchar, @an,111) AS Stil_111

-- Deðiþken ile verilen iki tarih arasýnda kaç gün geçti ?
DECLARE @tar1 date, @tar2 date, @gun int
SET @tar1='1071.08.06'
SET @tar2='1922.08.30'
SET @gun = DATEDIFF(DAY,@tar1,@tar2) -- SECOND,MINUTE,HOUR,DAY,MONTH,YEAR
print @gun