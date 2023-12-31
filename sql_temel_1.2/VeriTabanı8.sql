--Bir müþteri sipariþ vermemiþse silinsin kodu yazalým
  --
GO
ALTER PROCEDURE MüþteriSil @musno nvarchar(5)
AS
BEGIN
  SELECT * FROM Müþteriler WHERE MüþteriNo=@musno
  -- Önce Müþteri var mý? yok mu kontrol et!
  IF EXISTS(SELECT * FROM Müþteriler WHERE MüþteriNo=@musno)
  BEGIN 
  print 'Müþteri VAR!'
  -- Sipariþler tablosunda var mý ?
	 IF EXISTS( SELECT * FROM Sipariþler 
			   WHERE MüþteriNo=@musno )
	 begin -- bu sorgudan dönen varsa silinmemelidir
	  print @musno +' Alýþ veriþ yapmýþ bir müþteri silinmemeli'
	 end 
	 ELSE 
	 begin 
	  print @musno +' sipariþ vermemiþ müþteri silinebilir'
	   DELETE FROM Müþteriler WHERE MüþteriNo=@musno
	 END
 END -- IF Müþteri varmý kapanýþ
 ELSE
  print 'Aradýðýnýz müþteri Mðþteriler tablosunda yok'
END

MüþteriSil YÜCFA
MüþteriSil AKTER
MüþteriSil ARSAL

-- ' ascii deðer 39
DECLARE @ad char(39),
SET @ad ='jsdnfkjsdf'

print char(39)+'Ali'+char(39)

-- ASCII sayýsýnýn karakter karþýlýðýný bulmak için
SELECT CHAR(39) , CHAR(65), CHAR(97)
-- Bir karakterin ASCII kod karþýlýðýný almak için
SELECT ASCII('A') , ASCII('a')

--// Bir örnek :                 
DECLARE @ad varchar(50), @harf char(1), @il varchar(80) ,
        @sqlcumle varchar(500)
SET @harf= CHAR(39)
SET @ad = 'A%'
SET @il='Ankara'
SET @sqlcumle = 'SELECT * FROM Müþteriler
  WHERE Adý LIKE '+@harf + @ad + @harf +' AND il = '+@harf+@il+@harf
print @sqlcumle 
EXECUTE(@sqlcumle)  --EXEC()

-- ASCII tablosu : kodlara karþýlýk karakterler
print ASCII('A')
print ASCII('a')
--0 dan 255 e ASCII kodlarýn harf karþýlýðý
DECLARE @i int, @harf char(1)
SET @i = 0;
WHILE(@i<256)  
BEGIN
  SET @harf = CHAR(@i)
  print convert(varchar,@i) + ' ' + @harf
  SET @i = @i + 1
END

-------------------------------------------------------------

INDEX : Dizin 

Veritabanýnda sorgularý hýzlandýrmak için kolonlar üzerinde oluþturulan
yapýlardýr.

Yapýlarýna göre iki gruba ayrýlýrlar.

1. Clustered INDEX : Kümelenmiþ Dizin : 
   Dizinin oluþturulduðu kolondaki bilgileri kümeleyerek, aramanýn hýzlý 
   yapýlabilmesi için index oluþturur. Kümelenmemiþ dizine göre hýzlýdýr. 
   Küme için bellek kullanýmý söz konusudur.
2. NonClustered INDEX : Kümelenmemiþ dizin. Kümeleme yapmadan index oluþturduðu
	için bellek kullanýmý yoktur. Kümelenmiþ dizine göre yavaþtýr.
	
Bir tablonun sadece 1 tane kümelenmiþ dizini olabilir. 
Bir tablonun 1 den fazla kümelenmemiþ dizini olabilir.
	

CREATE CLUSTERED/NONCLUSTERED INDEX dizinAdý
ON TablonunAdý(KolonAdý)

-- Ürünler tablosunun  ÜrünAdý kolonuna Kümelenmiþ bir dizin yaratalým

CREATE CLUSTERED INDEX indÜrünAd
ON Ürünler(ÜrünAd)--Hata 1 tabloda sadece 1 tane kümelenmiþ dizin Olur

CREATE NONCLUSTERED INDEX indÜrünAd
ON Ürünler(ÜrünAd)

-- Ürünler tablosunda Kategoriler kolonunda
-- kümelenmemiþ index oluþturalým
CREATE NONCLUSTERED INDEX inxFiyat
ON Ürünler(KategoriNo)

-- ALTER biraz karýþýk

-- Bir index dizini silmek

DROP INDEX TablonunAdý.DizinAdý
-- Fiyat kolonundaki dizini silelim

DROP INDEX Ürünler.inxFiyat


-- Bir tablonun kayýtlarýndan , yeni bir tabloyu hýzlýca yaratan 
-- SELECT ..  INTO  Yapýsý :

SELECT kolon1,...,kolonN INTO YeniTabloAdý FROM EskiTabloAdý
WHERE koþul

SELECT * INTO YeniÜrünler FROM Ürünler

SELECT * FROM YeniÜrünler WHERE ÜrünAd='Papatya'

---YeniÜrünler tablosu, ÜrünAd kolonunda tekil,kümelenmiþ bir dizin 
--oluþturalým

UNIQUE : Tekil : Tek ve biricik, tekrar etmeyen, NULL olmayan kayýtlar

CREATE UNIQUE CLUSTERED INDEX inxÜrünAd
ON YeniÜrünler(ÜrünAd) -- hata, ÜrünAd tekil deðil. tekrar eden kayýtlar var

SELECT COUNT(*),ÜrünAd FROM YeniÜrünler
GROUP BY ÜrünAd
HAVING COUNT(*)>1
--
DELETE FROM YeniÜrünler
WHERE ÜrünAd IN (
					SELECT ÜrünAd FROM YeniÜrünler
					GROUP BY ÜrünAd
					HAVING COUNT(*)>1
					)
--yada
DELETE FROM YeniÜrünler WHERE ÜrünAd='Dönel Fýskýye'
DELETE FROM YeniÜrünler WHERE ÜrünAd LIKE'%çmekan%'
DELETE FROM YeniÜrünler WHERE ÜrünAd='Organik Gübre'
DELETE FROM YeniÜrünler WHERE ÜrünNo=126
---YeniÜrünler tablosu, ÜrünAd kolonunda kümelenmiþ
-- bir dizin oluþturalým
CREATE CLUSTERED INDEX inxÜrünAd
ON YeniÜrünler(ÜrünAd)   --(basit)

-- Bir tablodaki dizinler hakkýnda bize bilgi verecek
-- sistem saklý yordamý 
sp_helpindex TablonunAdý

sp_helpindex YeniÜrünler

-- Veritabanýndaki tüm indexler hakýnda bilgi 
-- alabileceðimiz bir sistem tablosu

SELECT * FROM sys.indexes
--Oluþturulduðu kolona göre indeksler :
-- bir kolon üzerinde oluþturulan indeksler BASÝT
-- birden fazla kolon birlikte indekslensiðinde BÝLEÞÝK indeks
-- olarak adlandýrýlýrlar
-- Buraya kadar yaptýðýmýz indexler "basit" dizinlerdi
-- Müþteriler tablosunda Ad ve Soyad kolonlarýna 
-- bileþik dizin uygulayalým
-- Ad ve Soyadýn ikisi birlikte tekrar etmeyecek biçimde
-- tekil : Unique olmayasýný isteyelim
-- PK kümelenmiþ olduðundan dizin ancak kümelenmemiþ olabilir

CREATE UNIQUE NONCLUSTERED INDEX indAdSoyad
ON Müþteriler(Adý,Soyadý) -- Bileþik!!!

-- Dizinler grafik arayüz ile de  yönetilebilirler.

-- Müþteriler tablosunda il, ilçe kolonlarý üzerinde
-- index oluþtura
CREATE NONCLUSTERED INDEX indksililce
ON Müþteriler(il,ilçe)

-- Ürünler tablosunda fiyata göre yapýlan aramalarý
-- hýzlandýrýn
CREATE NONCLUSTERED INDEX indeksFiyat
ON Ürünler(BirimFiyat)
---------------------------------------Bu Bölümü ATLA!!! FONKSÝYONLARA GÝT !!!
-- Dizin Oluþturmada Hýz/Performans
------------------------------------------
SELECT * INTO Müþteriler1 FROM Müþteriler

SELECT * INTO Ürünler1 FROM Ürünler


-- Müþterileri Ada ve Soyada göre azalan sýralayalým

SELECT * FROM Müþteriler
ORDER BY Adý DESC, Soyadý DESC
Zaman Maliyeti : COST
SELECT %0		Sýralama %72	   PK_IndexTarama %28
---------------------------------------------------
SELECT * FROM Müþteriler1
ORDER BY Adý DESC, Soyadý DESC
COST :
SELECT %0		Sýralama %69 	Tablo Tarama %31
--------------------------------------------------
Aramayý hýzlandýrmak istediðim Ad, Soyad koloanlarýnda
bileþik kümelenmiþ dizin yaratayým
CREATE CLUSTERED INDEX indAdSoy
ON Müþteriler1(Adý,Soyadý) -- bileþik kümelenmiþ

SELECT * FROM Müþteriler1
ORDER BY Adý DESC, Soyadý DESC
COST :
SELECT %0		Sýralama %0 	Index Tarama %100

DROP INDEX Müþteriler1.indAdSoy


-- Ürünler tablosu dizinsiz
-- ÜrünAdýna göre Kümelenmiþ,
-- Ürün Fiyatýna göre kümelenmemiþ dizin yaratýp
-- dizinsiz durum ile executation planlarý kýyaslayýn
SELECT * FROM Ürünler1
WHERE ÜrünAd = 'Dekorluk Yosun'
COST :
SELECT %0		Sýralama %0 		  Tablo Tarama %100 0.0057121

SELECT * FROM Ürünler1
WHERE ÜrünAd = 'Dekorluk Yosun'
COST :
SELECT %0		Sýralama %0		KümeliDizin Tarama %100 0.00328311
------------------------------------------------------------------
-- 


Execution Plan Kümelenmemiþ dizini görmezden geldi ...


DROP INDEX Ürünler1.indAd

SELECT * FROM Ürünler1 ORDER BY BirimFiyat ASC
COST :
SELECT %0		Sýralama %73		Tablo Tarama %27
				0.0135911			0.0049714

--Ürünlerin Fiyata göre sýralayý hýzlandýrmak için BirimFiyat kolonuna
-- kümelenmemiþ index
CREATE NONCLUSTERED INDEX indFiyat
ON Ürünler1(BirimFiyat)

SELECT * FROM Ürünler1 ORDER BY BirimFiyat ASC
COST :
SELECT %0		Sýralama %73		Kümeli Dizin(indAd) Tarama %27
				0.0135911			0.0049714
-----------------------------------------------------ATLANAN BÖLÜM SONU-----


/*
FONKSÝYONLAR :
MS SQL sever da fonksiyonlar, girdi parametresi alabilen, 
geriye bir deðer döndürme yeteneðine sahip programlama yapýlarý
dýr. Saklý yordamlar(stored procedure) sorgu içerisinden
çaðýrýlamazlarken,  fonksiyonlar sorgu içinde kullanýlabilirler.
Geriye bir deðer veya tablo döndürebilirler. Görünüm(View) ile
saðlanan tablo yapýsýndan farklý olarak parametre alan bir 
yapýya sahiptirler.
Bir fonksiyon, tablolara insert, update, delete yapamaz ancak
bu sorgularýn içerisinde kullanýlabilir.
Fonksiyon kullanýlýrken dbo(schema) belirtilmelidir.
Týpký farklý bir vt deki tabloyu sorguladýðýmýz gibi:
*/
use master
go
SELECT Bahçeiþleri_.dbo.Müþteriler.Adý,
	   Bahçeiþleri_.dbo.Müþteriler.Soyadý,
	   Bahçeiþleri_.dbo.Müþteriler.il
 FROM Bahçeiþleri_.dbo.Müþteriler
  --   vtAdý.dbo.TabloAdý.KolonAdý
  
 -- Sistem Fonksiyonlarý : 
 print getdate()
 SELECT 'Bu gün :'+CONVERT(VARCHAR(50), GETDATE())
 print pi() --pi sayýsýný verir
 SELECT SIN(PI()/2) AS '90dereceninSinüsü'
  -- derece cinsinden deðil radyan cinsinden çal???r

-- Kullanýcý Tanýmlý Fonksiyon Yaratma
/*
CREATE FUNCTION FoksiyonAdý
(@deðiþken1 veritip1, @deðiþken2 veritip2,...) -- giren deðiþkenker
RETURNS VeriTipiDönen
BEGIN
    ...
	RETURN @DeðiþkenDönen
END
*/
GO
--YARAT
CREATE FUNCTION kdvHesapla(@fiyat Money, @Oran float)
RETURNS Money
BEGIN
	RETURN @fiyat*@Oran
END
GO

print dbo.kdvHesapla(100,0.18)

-- Tek bir deðer (scalar) döndürdüðünden, --VT altýnda,
-- programability altýnda Scalar Valued functions altýnda listelenir
--DEGÝÞTÝR
ALTER FUNCTION kdvHesapla(@fiyat Money, @Oran float)
RETURNS Money
BEGIN
	DECLARE @kdvsi Money
	SET @kdvsi = @fiyat*@Oran
	RETURN @kdvsi
END
GO
-- kullanalým
print dbo.kdvHesapla(100,0.18) -- %18kdv
SELECT dbo.kdvHesapla(25,0.04) AS ' % 4kdv si :'
-- Ürünler tablosunda fiyatlarýn kdvsini gösteren bir kolon olsa :
SELECT ÜrünAd, StokMiktarý, BirimFiyat, 
			dbo.kdvHesapla(BirimFiyat, 0.18) AS 'Kdvsi'
FROM Ürünler 
--Verilen oranda zamlý fiyatý hesaplayan fonksiyonu yazýnýz
go
create function zamlýHesapla(@fiyat Money, @yuzde float)
returns Money
begin
	declare @donen Money
	set @donen=@fiyat+@fiyat/100*@yuzde
	return @donen
end
go
print dbo.zamlýHesapla(150,12.5)
-- Ürünler tablosunda ürünleri %10 zamlý fiyatlarýyla gösteriniz
SELECT ÜrünAd,BirimFiyat, dbo.zamlýHesapla(BirimFiyat,10) AS Zamlý
FROM Ürünler

--Verilen oranda indirimli fiyatý hesaplayan fonksiyonu yazýnýz 
go
create function indirimHesapla(@fiyat Money, @yuzde float)
returns Money
begin
	declare @donen Money
	set @donen=@fiyat-@fiyat/100*@yuzde
	return @donen
end
go
print dbo.indirimHesapla(150,12.5)
--- Tabloda Ürünlerin %20 indirimli fiyatlarýyla gösterin
SELECT ÜrünAd, BirimFiyat,dbo.indirimHesapla(BirimFiyat,20)AS indirimli
FROM ÜRünler

-- Derececinsinde verilen açýnýn Sin Cos hesaplayan fonksiyon
-- yazalým 
print sin(90)

CREATE FUNCTION SinD(@aci float)
RETURNS float
BEGIN
 DECLARE @rad float , @sonuc float
 SET @rad = @aci*PI()/180.0--dereceyi 180e böl, pi ile çarp radyanolsun
 SET @sonuc = SIN(@rad)
 RETURN @sonuc
END
print dbo.SinD(90)
SELECT dbo.SinD(45) AS 'Sin(45)'
-- derece cinsinden cos hesaplamak için yukarýdaki fonksiyonda
-- 6. satýrda sin yerine cos yazarsýnýz

--verilen iki tarih arasýndaki farký yaþ olarak hesaplayan fonksiyon
GO
CREATE FUNCTION Yaþ(@ilkTar DateTime, @sonTar DateTime)
RETURNS int
BEGIN
	DECLARE @yil int
	SET @yil = DATEDIFF(YEAR,@ilkTar, @sonTar)
	RETURN @yil
END
GO
-- bu fonksiyonu kullanarak Çalýþanlarý, yaþlarý ile listeleyiniz
SELECT *, dbo.Yaþ(DoðumTarihi, getdate()) AS Yaþ
FROM Çalýþanlar
--
--Üretim Tarihi ve Kullaným süresi verilen bir ürünün süresinin
--dolmuþ yada tüketilebilir olduðunu mesaj olarak veren bir  fonksiyon
--yazýnýz :
print DATEDIFF(DAY,'2018-12-15',getdate()) 
GO                                    --ürünün tüketilebileceði gün sayýsý
CREATE FUNCTION Tüketilirmi(@ureTar datetime, @gecerliGun int)
RETURNS varchar(50)
BEGIN
	DECLARE @gun int, @mesaj varchar(50)
	SET @gun = DATEDIFF(DAY,@ureTar,getdate())
	if(@gun<=@gecerliGun)
		SET @mesaj = 'Tüketilebilir'
	else
		SET @mesaj = 'Kullaným süresi dolmuþ'
	RETURN @mesaj
END
GO

print dbo.Tüketilirmi('2018-12-15',3)

-- Tüketim tarihine kaç gün kaldýðýný veya kaç gün geçtiðini söylesin
CREATE FUNCTION KacGunKaldýGecti(@ureTar datetime, @gecerliGun int)
RETURNS varchar(50)
BEGIN
	DECLARE @kalanGecenGun int, @gun int, @mesaj varchar(50)
	SET @gun = DATEDIFF(DAY,@ureTar,getdate())--her zaman üretimTar.geçmiþte
	SET @kalanGecenGun = @gecerliGun-@gun
	if(@kalanGecenGun>=0)
		SET @mesaj = 'STT ne '+CONVERT(varchar,@kalanGecenGun)+' kaldý.'
	else
		SET @mesaj = 'STT ni '+CONVERT(varchar,-@kalanGecenGun)+' geçmiþ.'
	RETURN @mesaj
END
print dbo.KacGunKaldýGecti('2018-12-10',30)

-- ÇAlýþanlar Tablosunda Emeklilik yaþý gelmiþ çalýþanlarýn yanýna 
-- 'Emekliliði gelmiþ' yazan bir fonksiyon yazýnýz
go
CREATE FUNCTION YaþaGöreEmekliMi(@dtar datetime, @emekliYas int)
RETURNS varchar(50)
BEGIN 
	DECLARE @mesaj varchar(50)
	IF( datediff(year,@dtar,getdate())>=@emekliYas )
		SET @mesaj ='Emekli'
	ELSE SET @mesaj = 'Emekli deðil'
	RETURN @mesaj
END
go
SELECT *, dbo.YaþaGöreEmekliMi(DoðumTarihi,55) AS Durum 
FROM Çalýþanlar

-- Sipariþ Numarasý verilen bir ürünün, tüm Sipariþlerde toplamda 
--ne miktarda  Satýldýðýný hesaplayan bir fonksiyon 
GO
CREATE FUNCTION ÜrünToplamSatýþMiktarý(@urunno int)
RETURNS int 
BEGIN
	DECLARE @ToplamMiktar int 
	SET @ToplamMiktar =(SELECT SUM(Miktar) FROM [Sipariþ Detaylarý]
						WHERE ÜrünNo = @urunno )
	RETURN @ToplamMiktar
END

print dbo.ÜrünToplamSAtýþMiktarý(2)  -- 1 sihirli zambak
--
SELECT ÜrünNo,ÜrünAd,StokMiktarý,
   dbo.ÜrünToplamSatýþMiktarý(ÜrünNo) AS ToplamSatýþMiktarý
FROM Ürünler
GO
-- SipariþNumarasý verilen sipariþi, ürün Ad, fiyat, miktarlarý  ile
-- listeleyen fonksiyonu yazýnýz.
GO
CREATE FUNCTION Sipariþ(@sipNo int)
RETURNS TABLE -- Tablo döndüren fonksiyon
AS
RETURN
(
 SELECT ÜrünAd, [Sipariþ Detaylarý].BirimFiyat, Miktar 
 FROM  [Sipariþ Detaylarý] 
 INNER JOIN Ürünler ON [Sipariþ Detaylarý].ÜrünNo = Ürünler.ÜrünNo
 WHERE SipariþNo =@sipNo
)
GO
-- fonksiyonu çaðýralým:
SELECT * FROM  dbo.Sipariþ(11080)
--

--------------------------------------------------------
-- hafta9 dan Trigger 
-- TRIGGERS : Tetikleyiciler
--
CREATE TRIGGER tetikleyici_adý
ON tabloAdý_yada_gorunumAdý
Tetikleyici_türü(After/Instead Of/FOR) komut_list(insert,update,delte)
AS
SQL_ifadeleri(Prosedür)

After : Birden fazla komut(insert,update,delete) dinleyebilir.
-- Alter ile Tetikleyiciyi deðiþtiririz
-- alter den sonra baþtan yazmanýz gerek
CREATE TRIGGER tr_ÇalýþanYeniKayýtSonra
ON Çalýþanlar
AFTER INSERT, UPDATE
AS
INSERT INTO TetikMesaj(TetikAdý,Mesaj )
VALUES('tr_ÇalýþanYeniKayýtSonra',
   'Çalýþanlar Tablosuna kayýt eklendi veya güncellendi')
GO
INSERT INTO Çalýþanlar(ÇalýþanNo,Adý,Soyadý)
VALUES(19,'Alphan','NAR')
GO
UPDATE Çalýþanlar 
SET Adý ='Mehmet', Soyadý = 'TURHAN'
WHERE ÇalýþanNo =19 
GO
SELECT * FROM TetikMesaj

-- Tetikleyiciyi silmek için

DROP Trigger TetikleyiciAdý

DROP Trigger tr_ÇalýþanYeniKayýtSonra
