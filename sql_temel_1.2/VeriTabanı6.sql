Global Unique Identifier : GUID
16byte = 128bitlik bellek kullanýr
32 adet 16lýk(Hexadecimal) rakamdan oluþur
Deðeri rastgele belirlenir.
Üretilen bir deðerin tekrar üretilme, benzeme ihtimali çok düþüktür.
Bu nedenle benzersiz(unique) olduðu kabul edilir.
Örnek Bir GUID : 0EA12683-02D2-466B-8C20-98B10F9B4A16
GUID kullaným alanlarý :
1) Microsoft Windows COM(Component Object Model) nesnelerinin sýnýf
   içi ata arayüzlerinin(interface) iç tarafa tanýmlamak için kullanýlýr.
2) Intel harddisk bölümlemesi için GUID kullanmaktadýr.
3) Veritabanýnda tablolarda birincil anahtar olarak benzersizliði 
   saðlamak için kullanýlýr.

MS-SQL  da GUID oluþturmak için fonksiyon : newID()
print newID() -- veya
SELECT newID()
Hexadecimal rakamlar : 0123456789ABCDEF
GUID 240041AE-6D93-45D3-A940-1CACC3413AFD
	 8 rakam -4rkm-4rkm-4rkm-12 rakam rakamlarý karakter katarýna
	 çevrelim 36 karakter gerekecek
DECLARE @guidString char(36), @guid uniqueidentifier -- veritipi!!
SET @guid = newID()
SET @guidString = CONVERT(char(36), @guid)
print 'GUID deðeri : '+ @guidString

-- GUID verisini tutacak veri tipi : uniqueidentifier
-- GUID yi birinci anahtar olarak kullanan bir tablo yapalým :

USE master
GO
DROP DATABASE Firma -- Yani Database siler
GO

CREATE DATABASE Firma
GO
USE Firma
GO
CREATE TABLE Müþteriler
(
 MüþteriNo uniqueidentifier NOT NULL DEFAULT newID() primary key,
 Þirket varchar(30) NOT NULL,
 Kiþi varchar(60) NOT NULL,
 Adres varchar(50) NOT NULL,
 PostaKodu char(5) NOT NULL,
 Tel char(13)
)
GO
INSERT Müþteriler VALUES( newID(), 'Apple', 'Steve Wozniak', 'California', '13547', '+01149951546' ),
						( newID(), 'Microsoft', 'Bill Gates', 'Redmond, Washington', '98008', '+18006427676' ),
						( newID(), 'Vestel', 'Ahmet Zorlu', 'Manisa', '45001', '+908502224123' ),
						( newID(), 'Arçelik', 'Çelik', 'Gebze, Kocaeli', '41001', '+902626787878' )
						-- veya
INSERT Müþteriler(Þirket, Kiþi, Adres, PostaKodu, Tel)
				  VALUES( 'Apple', 'Steve Wozniak', 'California', '13547', '+01149951546' ),
						( 'Microsoft', 'Bill Gates', 'Redmond, Washington', '98008', '+18006427676' ),
						( 'Vestel', 'Ahmet Zorlu', 'Manisa', '45001', '+908502224123' ),
						( 'Arçelik', 'Çelik', 'Gebze, Kocaeli', '41001', '+902626787878' )

------

-- Ürünler tablosunda Güz Çiðdemi yada Mango Var mý Yok mu? Var sa Var yok ise Yok 
-- yazan kodu yazýnýz.

SELECT * FROM Ürünler WHERE ÜrünAd='Sihirli Zambak'
SELECT * FROM Ürünler WHERE ÜrünAd='Mango'
GO
DECLARE @miktar smallint
SELECT @miktar = StokMiktarý From Ürünler WHERE ÜrünAd='Mango'
IF( @miktar>=0 )
 print 'Var ' + CONVERT(varchar,@miktar)+ ' adet'
ELSE
 print 'Yok ' + CONVERT(varchar,@miktar)+ ' adet'

-- sayarak :
SELECT COUNT(*) FROM Ürünler WHERE ÜrünAd='Sihirli Zambak'
SELECT COUNT(*) FROM Ürünler WHERE ÜrünAd='Mango'
--
GO
DECLARE @miktar smallint
SET @miktar =(SELECT COUNT(*) From Ürünler WHERE ÜrünAd='Sirli Zambak')--'Mango')
IF( @miktar>0 )
 print 'Var '
ELSE
 print 'Yok '
-- Böylede olur
GO
DECLARE @miktar smallint
SELECT @miktar=COUNT(*) From Ürünler WHERE ÜrünAd='Sihirli Zambak'
IF( @miktar>0 )
 print 'Var '
ELSE
 print 'Yok '


-- Hali hazýrda varken yaratmak hataya neden olur!
CREATE DATABASE Firma

-- Yokken silmek hataya neden olur!
DROP DATABASE Þirket


Bir sorgu sonucunda dönen kayýt varsa true, yoksa false veren kalýp:
IF EXISTS(Sorgu) BEGIN.... END
ELSE  BEGIN.... END

IF EXISTS( SELECT * FROM Ürünler WHERE ÜrünAd='Sihirli Zambak' )
print 'Var'
else print 'Yok'

-- Þirket adýndan VT varsa silen bir sorgu yazýn :
-- Bir VT var mý yok mu anlamak için master VT altýnda sysdatabases adýndaki 
-- görünümü sorgulayýnýz :
-- SELECT * FROM master.dbo.sysdatabases

IF EXISTS(SELECT * FROM master.dbo.sysdatabases WHERE name = 'Þirket')
BEGIN 
 DROP DATABASE Þirket
 print 'Var Siliyorum'
END
ELSE
 print 'Yok Silemem'

-- Þirket adýnda VT yoksa yaratan, varsa silip, yaratan kodu yazalým

IF EXISTS(SELECT * FROM master.dbo.sysdatabases WHERE name = 'Þirket')
BEGIN 
 DROP DATABASE Þirket
 print 'Var Siliyorum'
END
 CREATE DATABASE Þirket
 print 'Yaratýlýyor!'

-- Adý deðiþken ile verilen bir VT, varsa silip de yaratýlsýn!

DECLARE @vtAd varchar(100)
SET @vtAd='OtoKiralama'
IF EXISTS(SELECT * FROM master.dbo.sysdatabases WHERE name = @vtAd)
BEGIN 
 DROP DATABASE 
 print 'Var Siliyorum'
END
 CREATE DATABASE @vtAd
 print 'yaratýlýyor!'
-- Komut, vt adýný yazý ile beklerken deðiþken almaya uygun deðil!
-- Bu tür sql ifadelerini tamamýný karakter katarý olarak EXECUTE ile
-- çalýþtýrýrýz! EXECUTE(StringSQLifade)
GO
DECLARE @vtAd varchar(100)
SET @vtAd='OtoKiralama'
IF EXISTS(SELECT * FROM master.dbo.sysdatabases WHERE name = @vtAd)
BEGIN 
 EXECUTE('DROP DATABASE '+@vtAd )
 print @vtAd+'Var Siliyorum'
END
 EXECUTE('CREATE DATABASE '+@vtAd )
 print @vtAd+'yaratýlýyor!'

--
-- Bir VT altýnda herhangi bir VT nesnesi (pk, fk, tablo, view) olup
-- olmadýðýný anlamak için Her VT nin sistem tablolarý arasýnda bulunan
-- sysobjects tablosu sorgulanýr
-- SELECT * FROM Sysobjects

-- FK_Ürünler_Kategoriler adýnda bir nesne var mý?

IF EXISTS( SELECT * FROM Sysobjects
		   WHERE name = 'FK_Ürünler_Kategoriler' )
print 'Var'
else print 'Yok'


-- Bir müþteri silinmek istendiðinde, sipariþ vermemiþ ise silen,
-- sipariþ vermiþ ise silmeyen kodu yazýnýz!
-- MüþteriNo Sipariþler tablosunda varsa sipariþ vermiþtir ve silinemez!!

DECLARE @müþno char(5)
SET @müþno ='ARARI'
IF EXISTS(SELECT * FROM Sipariþler
		  WHERE MüþteriNo=@müþno)
print @müþno+' Müþteri sipariþ vermiþ olduðundan silinemez'
ELSE
BEGIN
print  müþno+'Müþteri sipariþ vermemiþ olduðundan siliyorum...'
DELETE FROM Müþteriler WHERE MüþteriNo=@müþno
END