/*
	STORED PROCEDURE : SAKLI YORDAM

CREATE PRODUCEDURE YordaAdý
input deðiþken tanýmlarý, output deðiþken tanýmlarý
AS
SQL ifadeleri..
...
...
...
Sunucu tarfýndan depolanan ve Transcat-SQL(T-SQL :microsoft un
sql dili) ifadelerinin toplu iþ dosyalarý olan saklý yordamlar
þu üstünlüklere sahiptir :
+ Veritabaný nesneleridir. Veritabaný dosyaýnda bulunurlar.
  Veritabaný ile taþýnýrlar.
+ Verilerin yordama aktarýlmasýna, iþlenmesine ve yordamdan
  bir sonuç kodunun geri alýnmasýna olanak saðlar.
+ Daha hýzlý çalýþmak üzere iyi þekilde(optimum) depolanýrlar.
Dezavantajý :
Bir sorgu içerisinde kullanýlmazlar, sorgudan çaðýrýlamazlar

*/

-- MüþteriListele adýnda bir saklý yordam yazalým
CREATE PROCEDURE MüþteriListele
AS
SELECT * FROM Müþteriler
-- Çaðýralým
GO
MüþteriListele
EXECUTE('MüþteriListele')
-- PROCEDURE Deðiþtirmek : ALTER
GO
ALTER PROCEDURE MüþteriListele
AS
SELECT MüþteriNo, Adý, Soyadý FROM Müþteriler
GO
MüþteriListele
GO
DROP PROCEDURE MüþteriListele

-- PROCEDURE yaratýrken sp_ ile baþlanmaz!
-- Çünkü sistem yordamlarý sp_ ile baþlar!
GO
sp_helptext MüþteriListele
GO
SP_HELPDB
GO
sp_helpdb Bahceisleri

-- ili verilen müþterileri listeleyen yordam yazýn

GO
CREATE PROCEDURE Müþterininili @il nvarchar(20)
AS
SELECT Adý, Soyadý, il FROM Müþteriler WHERE Ýl=@il
--
GO
Müþterininili Balýkesir
GO
Müþterininili 'Ýzmir'
GO
DECLARE @sehir nvarchar(20)
SET @sehir = 'Girne'
EXECUTE('Müþterininili '+@sehir) -- EXECUTE(karakterkatarýSQL)

-- Alt fiyat ve Üst fiyat verildiðinde fiyatý arada kalan
-- ürünleri listeleyen yordam yazýnýz
-- alt fiyat 10, üst fiyat 20
GO
CREATE PROCEDURE ÜrünFiyatAralýðý @alt money, @ust money
AS
SELECT * FROM Ürünler
WHERE BirimFiyat>@alt AND BirimFiyat<@ust
ORDER BY BirimFiyat ASC
GO
ÜrünFiyatAralýðý 10,20

--------------------------------------------
-- ÜrünFiyatAralýðý 20, 10 önce büyük sonra küçük deðer girilse de çalýþsýn
-- Alt fiyat ve Üst fiyat verildiðinde fiyatý arada kalan
-- ürünleri listeleyen yordam yazýnýz
GO
ALTER PROCEDURE ÜrünFiyatAralýðý @f1 money, @f2 money
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
SELECT * FROM Ürünler
WHERE BirimFiyat>@alt AND BirimFiyat<@ust
ORDER BY BirimFiyat ASC
GO
ÜrünFÝyatAralýðý 20, 10
GO
ÜrünFÝyatAralýðý 10, 20

-- Verilen iki sipariþ numarasý arasýndaki sipariþlerde 
-- hangi üründen kaç TL ye kaç tane satýldý ve satýþ tutarý
-- ne idi listeleyen bir yordam yazýnýz
GO
CREATE PROCEDURE ikiSipNoArasýSipariþTutarlarý @sip1 int, @sip2 int
AS
SELECT SipariþNo,SD.ÜrünNo,ÜrünAd,SD.BirimFiyat,Miktar,indirim,
		SD.BirimFiyat*Miktar*(1-indirim) AS SipariþTutarý 
FROM [Sipariþ Detaylarý] SD INNER JOIN Ürünler
ON SD.ÜrünNo = Ürünler.ÜrünNo
WHERE SipariþNo BETWEEN @sip1 AND @sip2
GO
ikiSipNoArasýSipariþTutarlarý 11084, 11089

-- Verilen iki sipariþNo arasý sipariþlerin
-- toplam sipariþ tutarlarýný listeleyiniz
GO
CREATE PROCEDURE ikiSipNoArasýSipTopTut @s1 int, @s2 int
AS
SELECT SipariþNo, SUM(BirimFiyat*Miktar*(1-indirim)) AS ToplamTutar
FROM [Sipariþ Detaylarý]
GROUP BY SipariþNo
HAVING SipariþNo BETWEEN 11089 AND 110999
GO
ikiSipNoArasýSipTopTut 11100, 11200

-- Toplam Sipariþ Tutarý iki deðer olarak verildiðinde
-- arasýnda kalan sipariþleri listeleyen bir yordam yazýnýz
GO
CREATE PROCEDURE ikiTopTutarArasiSipariþler @i1 money, @i2 money
AS
SELECT SipariþNo, SUM(BirimFiyat*Miktar*(1-indirim)) AS ToplamTutar
FROM [Sipariþ Detaylarý]
GROUP BY SipariþNo
HAVING SUM(BirimFiyat*Miktar*(1-indirim)) BETWEEN @i1 AND @i2
GO
ikiTopTutarArasiSipariþler 0, 10
GO
ikiTopTutarArasiSipariþler 10, 20

-- Geciken Sipariþleri listeleyen yordam yazýnýz
GO
CREATE PROCEDURE GecikenSipariþler
WITH ENCRYPTION
AS
SELECT * FROM Sipariþler WHERE GönderiliþTarihi>ÝsteniþTarihi
GO
GecikenSipariþler
GO
SP_HELPTEXT GecikenSipariþler -- script kriptolu olduðundan göstermez

-- Tükenmiþ Ürünleri listeleyen yordam yazýnýz
GO
CREATE PROCEDURE TükenenÜrünler
WITH ENCRYPTION
AS
SELECT * FROM Ürünler
WHERE Tükendi=1
GO
TükenenÜrünler
GO
SP_HELPTEXT GecikenSipariþler

-- Sipariþ vermemiþ müþterileri listeleyip ardýndan
-- silen bir SP yazýnýz
GO
CREATE PROCEDURE MüþteriSil @musno nvarchar(5)
AS
BEGIN
 SELECT * FROM Sipariþler WHERE MüþteriNO=@musno
 -- Önce Müþteri var mý? yok mu kontrol et!
 IF EXISTS(SELECT * FROM Sipariþler WHERE MüþteriNO=@musno)
 BEGIN
 print 'Müþteri VAR!'
 -- Sipariþler tablosunda var mý?
	IF EXISTS(SELECT * FROM Sipariþler
			  WHERE MüþteriNo=@musno)
	BEGIN -- bu sorgudan dönen varsa silinmelidir
	 print @musno +' Alýþveriþ yapmýþ bir müþteri silinmemeli'
	END
	ELSE
	BEGIN
	 print @musno +' sipariþ vermemiþ müþteri silinebilir'
	  DELETE FROM Müþteriler WHERE MüþteriNo=@musno
	END
END -- IF Müþteri varmý kapanýþ
ELSE
 print 'Aradýðýnýz müþteri Müþteriler tablosunda yok'
END

GO
MüþteriSil YÜCFA
GO
MüþteriSil AKTER
GO
MüþteriSil ARSAL

--------------------------------------------------
-- Not
SELECT GETDATE() -- fonksiyon sorguda çaðrýlýr!
SELECT ÜrünFÝyatAralýðý 20, 10 -- yordam sorguda çaðrýlmaz!