/*
	STORED PROCEDURE : SAKLI YORDAM

CREATE PRODUCEDURE YordaAd�
input de�i�ken tan�mlar�, output de�i�ken tan�mlar�
AS
SQL ifadeleri..
...
...
...
Sunucu tarf�ndan depolanan ve Transcat-SQL(T-SQL :microsoft un
sql dili) ifadelerinin toplu i� dosyalar� olan sakl� yordamlar
�u �st�nl�klere sahiptir :
+ Veritaban� nesneleridir. Veritaban� dosya�nda bulunurlar.
  Veritaban� ile ta��n�rlar.
+ Verilerin yordama aktar�lmas�na, i�lenmesine ve yordamdan
  bir sonu� kodunun geri al�nmas�na olanak sa�lar.
+ Daha h�zl� �al��mak �zere iyi �ekilde(optimum) depolan�rlar.
Dezavantaj� :
Bir sorgu i�erisinde kullan�lmazlar, sorgudan �a��r�lamazlar

*/

-- M��teriListele ad�nda bir sakl� yordam yazal�m
CREATE PROCEDURE M��teriListele
AS
SELECT * FROM M��teriler
-- �a��ral�m
GO
M��teriListele
EXECUTE('M��teriListele')
-- PROCEDURE De�i�tirmek : ALTER
GO
ALTER PROCEDURE M��teriListele
AS
SELECT M��teriNo, Ad�, Soyad� FROM M��teriler
GO
M��teriListele
GO
DROP PROCEDURE M��teriListele

-- PROCEDURE yarat�rken sp_ ile ba�lanmaz!
-- ��nk� sistem yordamlar� sp_ ile ba�lar!
GO
sp_helptext M��teriListele
GO
SP_HELPDB
GO
sp_helpdb Bahceisleri

-- ili verilen m��terileri listeleyen yordam yaz�n

GO
CREATE PROCEDURE M��terininili @il nvarchar(20)
AS
SELECT Ad�, Soyad�, il FROM M��teriler WHERE �l=@il
--
GO
M��terininili Bal�kesir
GO
M��terininili '�zmir'
GO
DECLARE @sehir nvarchar(20)
SET @sehir = 'Girne'
EXECUTE('M��terininili '+@sehir) -- EXECUTE(karakterkatar�SQL)

-- Alt fiyat ve �st fiyat verildi�inde fiyat� arada kalan
-- �r�nleri listeleyen yordam yaz�n�z
-- alt fiyat 10, �st fiyat 20
GO
CREATE PROCEDURE �r�nFiyatAral��� @alt money, @ust money
AS
SELECT * FROM �r�nler
WHERE BirimFiyat>@alt AND BirimFiyat<@ust
ORDER BY BirimFiyat ASC
GO
�r�nFiyatAral��� 10,20

--------------------------------------------
-- �r�nFiyatAral��� 20, 10 �nce b�y�k sonra k���k de�er girilse de �al��s�n
-- Alt fiyat ve �st fiyat verildi�inde fiyat� arada kalan
-- �r�nleri listeleyen yordam yaz�n�z
GO
ALTER PROCEDURE �r�nFiyatAral��� @f1 money, @f2 money
AS
DECLARE @alt money, @ust money
if(@f1<@f2)
BEGIN
	SET @alt=@f1
	SET @ust=@f2
END
ELSE
BEGIN
	SET @alt=@f2
	SET @ust=@f1
END
SELECT * FROM �r�nler
WHERE BirimFiyat>@alt AND BirimFiyat<@ust
ORDER BY BirimFiyat ASC
GO
�r�nF�yatAral��� 20, 10
GO
�r�nF�yatAral��� 10, 20

-- Verilen iki sipari� numaras� aras�ndaki sipari�lerde 
-- hangi �r�nden ka� TL ye ka� tane sat�ld� ve sat�� tutar�
-- ne idi listeleyen bir yordam yaz�n�z
GO
CREATE PROCEDURE ikiSipNoAras�Sipari�Tutarlar� @sip1 int, @sip2 int
AS
SELECT Sipari�No,SD.�r�nNo,�r�nAd,SD.BirimFiyat,Miktar,indirim,
		SD.BirimFiyat*Miktar*(1-indirim) AS Sipari�Tutar� 
FROM [Sipari� Detaylar�] SD INNER JOIN �r�nler
ON SD.�r�nNo = �r�nler.�r�nNo
WHERE Sipari�No BETWEEN @sip1 AND @sip2
GO
ikiSipNoAras�Sipari�Tutarlar� 11084, 11089

-- Verilen iki sipari�No aras� sipari�lerin
-- toplam sipari� tutarlar�n� listeleyiniz
GO
CREATE PROCEDURE ikiSipNoAras�SipTopTut @s1 int, @s2 int
AS
SELECT Sipari�No, SUM(BirimFiyat*Miktar*(1-indirim)) AS ToplamTutar
FROM [Sipari� Detaylar�]
GROUP BY Sipari�No
HAVING Sipari�No BETWEEN 11089 AND 110999
GO
ikiSipNoAras�SipTopTut 11100, 11200

-- Toplam Sipari� Tutar� iki de�er olarak verildi�inde
-- aras�nda kalan sipari�leri listeleyen bir yordam yaz�n�z
GO
CREATE PROCEDURE ikiTopTutarArasiSipari�ler @i1 money, @i2 money
AS
SELECT Sipari�No, SUM(BirimFiyat*Miktar*(1-indirim)) AS ToplamTutar
FROM [Sipari� Detaylar�]
GROUP BY Sipari�No
HAVING SUM(BirimFiyat*Miktar*(1-indirim)) BETWEEN @i1 AND @i2
GO
ikiTopTutarArasiSipari�ler 0, 10
GO
ikiTopTutarArasiSipari�ler 10, 20

-- Geciken Sipari�leri listeleyen yordam yaz�n�z
GO
CREATE PROCEDURE GecikenSipari�ler
WITH ENCRYPTION
AS
SELECT * FROM Sipari�ler WHERE G�nderili�Tarihi>�steni�Tarihi
GO
GecikenSipari�ler
GO
SP_HELPTEXT GecikenSipari�ler -- script kriptolu oldu�undan g�stermez

-- T�kenmi� �r�nleri listeleyen yordam yaz�n�z
GO
CREATE PROCEDURE T�kenen�r�nler
WITH ENCRYPTION
AS
SELECT * FROM �r�nler
WHERE T�kendi=1
GO
T�kenen�r�nler
GO
SP_HELPTEXT GecikenSipari�ler

-- Sipari� vermemi� m��terileri listeleyip ard�ndan
-- silen bir SP yaz�n�z
GO
CREATE PROCEDURE M��teriSil @musno nvarchar(5)
AS
BEGIN
 SELECT * FROM Sipari�ler WHERE M��teriNO=@musno
 -- �nce M��teri var m�? yok mu kontrol et!
 IF EXISTS(SELECT * FROM Sipari�ler WHERE M��teriNO=@musno)
 BEGIN
 print 'M��teri VAR!'
 -- Sipari�ler tablosunda var m�?
	IF EXISTS(SELECT * FROM Sipari�ler
			  WHERE M��teriNo=@musno)
	BEGIN -- bu sorgudan d�nen varsa silinmelidir
	 print @musno +' Al��veri� yapm�� bir m��teri silinmemeli'
	END
	ELSE
	BEGIN
	 print @musno +' sipari� vermemi� m��teri silinebilir'
	  DELETE FROM M��teriler WHERE M��teriNo=@musno
	END
END -- IF M��teri varm� kapan��
ELSE
 print 'Arad���n�z m��teri M��teriler tablosunda yok'
END

GO
M��teriSil Y�CFA
GO
M��teriSil AKTER
GO
M��teriSil ARSAL

--------------------------------------------------
-- Not
SELECT GETDATE() -- fonksiyon sorguda �a�r�l�r!
SELECT �r�nF�yatAral��� 20, 10 -- yordam sorguda �a�r�lmaz!