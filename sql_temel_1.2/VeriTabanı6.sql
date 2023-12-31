Global Unique Identifier : GUID
16byte = 128bitlik bellek kullan�r
32 adet 16l�k(Hexadecimal) rakamdan olu�ur
De�eri rastgele belirlenir.
�retilen bir de�erin tekrar �retilme, benzeme ihtimali �ok d���kt�r.
Bu nedenle benzersiz(unique) oldu�u kabul edilir.
�rnek Bir GUID : 0EA12683-02D2-466B-8C20-98B10F9B4A16
GUID kullan�m alanlar� :
1) Microsoft Windows COM(Component Object Model) nesnelerinin s�n�f
   i�i ata aray�zlerinin(interface) i� tarafa tan�mlamak i�in kullan�l�r.
2) Intel harddisk b�l�mlemesi i�in GUID kullanmaktad�r.
3) Veritaban�nda tablolarda birincil anahtar olarak benzersizli�i 
   sa�lamak i�in kullan�l�r.

MS-SQL  da GUID olu�turmak i�in fonksiyon : newID()
print newID() -- veya
SELECT newID()
Hexadecimal rakamlar : 0123456789ABCDEF
GUID 240041AE-6D93-45D3-A940-1CACC3413AFD
	 8 rakam -4rkm-4rkm-4rkm-12 rakam rakamlar� karakter katar�na
	 �evrelim 36 karakter gerekecek
DECLARE @guidString char(36), @guid uniqueidentifier -- veritipi!!
SET @guid = newID()
SET @guidString = CONVERT(char(36), @guid)
print 'GUID de�eri : '+ @guidString

-- GUID verisini tutacak veri tipi : uniqueidentifier
-- GUID yi birinci anahtar olarak kullanan bir tablo yapal�m :

USE master
GO
DROP DATABASE Firma -- Yani Database siler
GO

CREATE DATABASE Firma
GO
USE Firma
GO
CREATE TABLE M��teriler
(
 M��teriNo uniqueidentifier NOT NULL DEFAULT newID() primary key,
 �irket varchar(30) NOT NULL,
 Ki�i varchar(60) NOT NULL,
 Adres varchar(50) NOT NULL,
 PostaKodu char(5) NOT NULL,
 Tel char(13)
)
GO
INSERT M��teriler VALUES( newID(), 'Apple', 'Steve Wozniak', 'California', '13547', '+01149951546' ),
						( newID(), 'Microsoft', 'Bill Gates', 'Redmond, Washington', '98008', '+18006427676' ),
						( newID(), 'Vestel', 'Ahmet Zorlu', 'Manisa', '45001', '+908502224123' ),
						( newID(), 'Ar�elik', '�elik', 'Gebze, Kocaeli', '41001', '+902626787878' )
						-- veya
INSERT M��teriler(�irket, Ki�i, Adres, PostaKodu, Tel)
				  VALUES( 'Apple', 'Steve Wozniak', 'California', '13547', '+01149951546' ),
						( 'Microsoft', 'Bill Gates', 'Redmond, Washington', '98008', '+18006427676' ),
						( 'Vestel', 'Ahmet Zorlu', 'Manisa', '45001', '+908502224123' ),
						( 'Ar�elik', '�elik', 'Gebze, Kocaeli', '41001', '+902626787878' )

------

-- �r�nler tablosunda G�z �i�demi yada Mango Var m� Yok mu? Var sa Var yok ise Yok 
-- yazan kodu yaz�n�z.

SELECT * FROM �r�nler WHERE �r�nAd='Sihirli Zambak'
SELECT * FROM �r�nler WHERE �r�nAd='Mango'
GO
DECLARE @miktar smallint
SELECT @miktar = StokMiktar� From �r�nler WHERE �r�nAd='Mango'
IF( @miktar>=0 )
 print 'Var ' + CONVERT(varchar,@miktar)+ ' adet'
ELSE
 print 'Yok ' + CONVERT(varchar,@miktar)+ ' adet'

-- sayarak :
SELECT COUNT(*) FROM �r�nler WHERE �r�nAd='Sihirli Zambak'
SELECT COUNT(*) FROM �r�nler WHERE �r�nAd='Mango'
--
GO
DECLARE @miktar smallint
SET @miktar =(SELECT COUNT(*) From �r�nler WHERE �r�nAd='Sirli Zambak')--'Mango')
IF( @miktar>0 )
 print 'Var '
ELSE
 print 'Yok '
-- B�ylede olur
GO
DECLARE @miktar smallint
SELECT @miktar=COUNT(*) From �r�nler WHERE �r�nAd='Sihirli Zambak'
IF( @miktar>0 )
 print 'Var '
ELSE
 print 'Yok '


-- Hali haz�rda varken yaratmak hataya neden olur!
CREATE DATABASE Firma

-- Yokken silmek hataya neden olur!
DROP DATABASE �irket


Bir sorgu sonucunda d�nen kay�t varsa true, yoksa false veren kal�p:
IF EXISTS(Sorgu) BEGIN.... END
ELSE  BEGIN.... END

IF EXISTS( SELECT * FROM �r�nler WHERE �r�nAd='Sihirli Zambak' )
print 'Var'
else print 'Yok'

-- �irket ad�ndan VT varsa silen bir sorgu yaz�n :
-- Bir VT var m� yok mu anlamak i�in master VT alt�nda sysdatabases ad�ndaki 
-- g�r�n�m� sorgulay�n�z :
-- SELECT * FROM master.dbo.sysdatabases

IF EXISTS(SELECT * FROM master.dbo.sysdatabases WHERE name = '�irket')
BEGIN 
 DROP DATABASE �irket
 print 'Var Siliyorum'
END
ELSE
 print 'Yok Silemem'

-- �irket ad�nda VT yoksa yaratan, varsa silip, yaratan kodu yazal�m

IF EXISTS(SELECT * FROM master.dbo.sysdatabases WHERE name = '�irket')
BEGIN 
 DROP DATABASE �irket
 print 'Var Siliyorum'
END
 CREATE DATABASE �irket
 print 'Yarat�l�yor!'

-- Ad� de�i�ken ile verilen bir VT, varsa silip de yarat�ls�n!

DECLARE @vtAd varchar(100)
SET @vtAd='OtoKiralama'
IF EXISTS(SELECT * FROM master.dbo.sysdatabases WHERE name = @vtAd)
BEGIN 
 DROP DATABASE 
 print 'Var Siliyorum'
END
 CREATE DATABASE @vtAd
 print 'yarat�l�yor!'
-- Komut, vt ad�n� yaz� ile beklerken de�i�ken almaya uygun de�il!
-- Bu t�r sql ifadelerini tamam�n� karakter katar� olarak EXECUTE ile
-- �al��t�r�r�z! EXECUTE(StringSQLifade)
GO
DECLARE @vtAd varchar(100)
SET @vtAd='OtoKiralama'
IF EXISTS(SELECT * FROM master.dbo.sysdatabases WHERE name = @vtAd)
BEGIN 
 EXECUTE('DROP DATABASE '+@vtAd )
 print @vtAd+'Var Siliyorum'
END
 EXECUTE('CREATE DATABASE '+@vtAd )
 print @vtAd+'yarat�l�yor!'

--
-- Bir VT alt�nda herhangi bir VT nesnesi (pk, fk, tablo, view) olup
-- olmad���n� anlamak i�in Her VT nin sistem tablolar� aras�nda bulunan
-- sysobjects tablosu sorgulan�r
-- SELECT * FROM Sysobjects

-- FK_�r�nler_Kategoriler ad�nda bir nesne var m�?

IF EXISTS( SELECT * FROM Sysobjects
		   WHERE name = 'FK_�r�nler_Kategoriler' )
print 'Var'
else print 'Yok'


-- Bir m��teri silinmek istendi�inde, sipari� vermemi� ise silen,
-- sipari� vermi� ise silmeyen kodu yaz�n�z!
-- M��teriNo Sipari�ler tablosunda varsa sipari� vermi�tir ve silinemez!!

DECLARE @m��no char(5)
SET @m��no ='ARARI'
IF EXISTS(SELECT * FROM Sipari�ler
		  WHERE M��teriNo=@m��no)
print @m��no+' M��teri sipari� vermi� oldu�undan silinemez'
ELSE
BEGIN
print  m��no+'M��teri sipari� vermemi� oldu�undan siliyorum...'
DELETE FROM M��teriler WHERE M��teriNo=@m��no
END