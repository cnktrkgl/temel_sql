--Bir m��teri sipari� vermemi�se silinsin kodu yazal�m
  --
GO
ALTER PROCEDURE M��teriSil @musno nvarchar(5)
AS
BEGIN
  SELECT * FROM M��teriler WHERE M��teriNo=@musno
  -- �nce M��teri var m�? yok mu kontrol et!
  IF EXISTS(SELECT * FROM M��teriler WHERE M��teriNo=@musno)
  BEGIN 
  print 'M��teri VAR!'
  -- Sipari�ler tablosunda var m� ?
	 IF EXISTS( SELECT * FROM Sipari�ler 
			   WHERE M��teriNo=@musno )
	 begin -- bu sorgudan d�nen varsa silinmemelidir
	  print @musno +' Al�� veri� yapm�� bir m��teri silinmemeli'
	 end 
	 ELSE 
	 begin 
	  print @musno +' sipari� vermemi� m��teri silinebilir'
	   DELETE FROM M��teriler WHERE M��teriNo=@musno
	 END
 END -- IF M��teri varm� kapan��
 ELSE
  print 'Arad���n�z m��teri M��teriler tablosunda yok'
END

M��teriSil Y�CFA
M��teriSil AKTER
M��teriSil ARSAL

-- ' ascii de�er 39
DECLARE @ad char(39),
SET @ad ='jsdnfkjsdf'

print char(39)+'Ali'+char(39)

-- ASCII say�s�n�n karakter kar��l���n� bulmak i�in
SELECT CHAR(39) , CHAR(65), CHAR(97)
-- Bir karakterin ASCII kod kar��l���n� almak i�in
SELECT ASCII('A') , ASCII('a')

--// Bir �rnek :                 
DECLARE @ad varchar(50), @harf char(1), @il varchar(80) ,
        @sqlcumle varchar(500)
SET @harf= CHAR(39)
SET @ad = 'A%'
SET @il='Ankara'
SET @sqlcumle = 'SELECT * FROM M��teriler
  WHERE Ad� LIKE '+@harf + @ad + @harf +' AND il = '+@harf+@il+@harf
print @sqlcumle 
EXECUTE(@sqlcumle)  --EXEC()

-- ASCII tablosu : kodlara kar��l�k karakterler
print ASCII('A')
print ASCII('a')
--0 dan 255 e ASCII kodlar�n harf kar��l���
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

Veritaban�nda sorgular� h�zland�rmak i�in kolonlar �zerinde olu�turulan
yap�lard�r.

Yap�lar�na g�re iki gruba ayr�l�rlar.

1. Clustered INDEX : K�melenmi� Dizin : 
   Dizinin olu�turuldu�u kolondaki bilgileri k�meleyerek, araman�n h�zl� 
   yap�labilmesi i�in index olu�turur. K�melenmemi� dizine g�re h�zl�d�r. 
   K�me i�in bellek kullan�m� s�z konusudur.
2. NonClustered INDEX : K�melenmemi� dizin. K�meleme yapmadan index olu�turdu�u
	i�in bellek kullan�m� yoktur. K�melenmi� dizine g�re yava�t�r.
	
Bir tablonun sadece 1 tane k�melenmi� dizini olabilir. 
Bir tablonun 1 den fazla k�melenmemi� dizini olabilir.
	

CREATE CLUSTERED/NONCLUSTERED INDEX dizinAd�
ON TablonunAd�(KolonAd�)

-- �r�nler tablosunun  �r�nAd� kolonuna K�melenmi� bir dizin yaratal�m

CREATE CLUSTERED INDEX ind�r�nAd
ON �r�nler(�r�nAd)--Hata 1 tabloda sadece 1 tane k�melenmi� dizin Olur

CREATE NONCLUSTERED INDEX ind�r�nAd
ON �r�nler(�r�nAd)

-- �r�nler tablosunda Kategoriler kolonunda
-- k�melenmemi� index olu�tural�m
CREATE NONCLUSTERED INDEX inxFiyat
ON �r�nler(KategoriNo)

-- ALTER biraz kar���k

-- Bir index dizini silmek

DROP INDEX TablonunAd�.DizinAd�
-- Fiyat kolonundaki dizini silelim

DROP INDEX �r�nler.inxFiyat


-- Bir tablonun kay�tlar�ndan , yeni bir tabloyu h�zl�ca yaratan 
-- SELECT ..  INTO  Yap�s� :

SELECT kolon1,...,kolonN INTO YeniTabloAd� FROM EskiTabloAd�
WHERE ko�ul

SELECT * INTO Yeni�r�nler FROM �r�nler

SELECT * FROM Yeni�r�nler WHERE �r�nAd='Papatya'

---Yeni�r�nler tablosu, �r�nAd kolonunda tekil,k�melenmi� bir dizin 
--olu�tural�m

UNIQUE : Tekil : Tek ve biricik, tekrar etmeyen, NULL olmayan kay�tlar

CREATE UNIQUE CLUSTERED INDEX inx�r�nAd
ON Yeni�r�nler(�r�nAd) -- hata, �r�nAd tekil de�il. tekrar eden kay�tlar var

SELECT COUNT(*),�r�nAd FROM Yeni�r�nler
GROUP BY �r�nAd
HAVING COUNT(*)>1
--
DELETE FROM Yeni�r�nler
WHERE �r�nAd IN (
					SELECT �r�nAd FROM Yeni�r�nler
					GROUP BY �r�nAd
					HAVING COUNT(*)>1
					)
--yada
DELETE FROM Yeni�r�nler WHERE �r�nAd='D�nel F�sk�ye'
DELETE FROM Yeni�r�nler WHERE �r�nAd LIKE'%�mekan%'
DELETE FROM Yeni�r�nler WHERE �r�nAd='Organik G�bre'
DELETE FROM Yeni�r�nler WHERE �r�nNo=126
---Yeni�r�nler tablosu, �r�nAd kolonunda k�melenmi�
-- bir dizin olu�tural�m
CREATE CLUSTERED INDEX inx�r�nAd
ON Yeni�r�nler(�r�nAd)   --(basit)

-- Bir tablodaki dizinler hakk�nda bize bilgi verecek
-- sistem sakl� yordam� 
sp_helpindex TablonunAd�

sp_helpindex Yeni�r�nler

-- Veritaban�ndaki t�m indexler hak�nda bilgi 
-- alabilece�imiz bir sistem tablosu

SELECT * FROM sys.indexes
--Olu�turuldu�u kolona g�re indeksler :
-- bir kolon �zerinde olu�turulan indeksler BAS�T
-- birden fazla kolon birlikte indekslensi�inde B�LE��K indeks
-- olarak adland�r�l�rlar
-- Buraya kadar yapt���m�z indexler "basit" dizinlerdi
-- M��teriler tablosunda Ad ve Soyad kolonlar�na 
-- bile�ik dizin uygulayal�m
-- Ad ve Soyad�n ikisi birlikte tekrar etmeyecek bi�imde
-- tekil : Unique olmayas�n� isteyelim
-- PK k�melenmi� oldu�undan dizin ancak k�melenmemi� olabilir

CREATE UNIQUE NONCLUSTERED INDEX indAdSoyad
ON M��teriler(Ad�,Soyad�) -- Bile�ik!!!

-- Dizinler grafik aray�z ile de  y�netilebilirler.

-- M��teriler tablosunda il, il�e kolonlar� �zerinde
-- index olu�tura
CREATE NONCLUSTERED INDEX indksililce
ON M��teriler(il,il�e)

-- �r�nler tablosunda fiyata g�re yap�lan aramalar�
-- h�zland�r�n
CREATE NONCLUSTERED INDEX indeksFiyat
ON �r�nler(BirimFiyat)
---------------------------------------Bu B�l�m� ATLA!!! FONKS�YONLARA G�T !!!
-- Dizin Olu�turmada H�z/Performans
------------------------------------------
SELECT * INTO M��teriler1 FROM M��teriler

SELECT * INTO �r�nler1 FROM �r�nler


-- M��terileri Ada ve Soyada g�re azalan s�ralayal�m

SELECT * FROM M��teriler
ORDER BY Ad� DESC, Soyad� DESC
Zaman Maliyeti : COST
SELECT %0		S�ralama %72	   PK_IndexTarama %28
---------------------------------------------------
SELECT * FROM M��teriler1
ORDER BY Ad� DESC, Soyad� DESC
COST :
SELECT %0		S�ralama %69 	Tablo Tarama %31
--------------------------------------------------
Aramay� h�zland�rmak istedi�im Ad, Soyad koloanlar�nda
bile�ik k�melenmi� dizin yaratay�m
CREATE CLUSTERED INDEX indAdSoy
ON M��teriler1(Ad�,Soyad�) -- bile�ik k�melenmi�

SELECT * FROM M��teriler1
ORDER BY Ad� DESC, Soyad� DESC
COST :
SELECT %0		S�ralama %0 	Index Tarama %100

DROP INDEX M��teriler1.indAdSoy


-- �r�nler tablosu dizinsiz
-- �r�nAd�na g�re K�melenmi�,
-- �r�n Fiyat�na g�re k�melenmemi� dizin yarat�p
-- dizinsiz durum ile executation planlar� k�yaslay�n
SELECT * FROM �r�nler1
WHERE �r�nAd = 'Dekorluk Yosun'
COST :
SELECT %0		S�ralama %0 		  Tablo Tarama %100 0.0057121

SELECT * FROM �r�nler1
WHERE �r�nAd = 'Dekorluk Yosun'
COST :
SELECT %0		S�ralama %0		K�meliDizin Tarama %100 0.00328311
------------------------------------------------------------------
-- 


Execution Plan K�melenmemi� dizini g�rmezden geldi ...


DROP INDEX �r�nler1.indAd

SELECT * FROM �r�nler1 ORDER BY BirimFiyat ASC
COST :
SELECT %0		S�ralama %73		Tablo Tarama %27
				0.0135911			0.0049714

--�r�nlerin Fiyata g�re s�ralay� h�zland�rmak i�in BirimFiyat kolonuna
-- k�melenmemi� index
CREATE NONCLUSTERED INDEX indFiyat
ON �r�nler1(BirimFiyat)

SELECT * FROM �r�nler1 ORDER BY BirimFiyat ASC
COST :
SELECT %0		S�ralama %73		K�meli Dizin(indAd) Tarama %27
				0.0135911			0.0049714
-----------------------------------------------------ATLANAN B�L�M SONU-----


/*
FONKS�YONLAR :
MS SQL sever da fonksiyonlar, girdi parametresi alabilen, 
geriye bir de�er d�nd�rme yetene�ine sahip programlama yap�lar�
d�r. Sakl� yordamlar(stored procedure) sorgu i�erisinden
�a��r�lamazlarken,  fonksiyonlar sorgu i�inde kullan�labilirler.
Geriye bir de�er veya tablo d�nd�rebilirler. G�r�n�m(View) ile
sa�lanan tablo yap�s�ndan farkl� olarak parametre alan bir 
yap�ya sahiptirler.
Bir fonksiyon, tablolara insert, update, delete yapamaz ancak
bu sorgular�n i�erisinde kullan�labilir.
Fonksiyon kullan�l�rken dbo(schema) belirtilmelidir.
T�pk� farkl� bir vt deki tabloyu sorgulad���m�z gibi:
*/
use master
go
SELECT Bah�ei�leri_.dbo.M��teriler.Ad�,
	   Bah�ei�leri_.dbo.M��teriler.Soyad�,
	   Bah�ei�leri_.dbo.M��teriler.il
 FROM Bah�ei�leri_.dbo.M��teriler
  --   vtAd�.dbo.TabloAd�.KolonAd�
  
 -- Sistem Fonksiyonlar� : 
 print getdate()
 SELECT 'Bu g�n :'+CONVERT(VARCHAR(50), GETDATE())
 print pi() --pi say�s�n� verir
 SELECT SIN(PI()/2) AS '90dereceninSin�s�'
  -- derece cinsinden de�il radyan cinsinden �al???r

-- Kullan�c� Tan�ml� Fonksiyon Yaratma
/*
CREATE FUNCTION FoksiyonAd�
(@de�i�ken1 veritip1, @de�i�ken2 veritip2,...) -- giren de�i�kenker
RETURNS VeriTipiD�nen
BEGIN
    ...
	RETURN @De�i�kenD�nen
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

-- Tek bir de�er (scalar) d�nd�rd���nden, --VT alt�nda,
-- programability alt�nda Scalar Valued functions alt�nda listelenir
--DEG��T�R
ALTER FUNCTION kdvHesapla(@fiyat Money, @Oran float)
RETURNS Money
BEGIN
	DECLARE @kdvsi Money
	SET @kdvsi = @fiyat*@Oran
	RETURN @kdvsi
END
GO
-- kullanal�m
print dbo.kdvHesapla(100,0.18) -- %18kdv
SELECT dbo.kdvHesapla(25,0.04) AS ' % 4kdv si :'
-- �r�nler tablosunda fiyatlar�n kdvsini g�steren bir kolon olsa :
SELECT �r�nAd, StokMiktar�, BirimFiyat, 
			dbo.kdvHesapla(BirimFiyat, 0.18) AS 'Kdvsi'
FROM �r�nler 
--Verilen oranda zaml� fiyat� hesaplayan fonksiyonu yaz�n�z
go
create function zaml�Hesapla(@fiyat Money, @yuzde float)
returns Money
begin
	declare @donen Money
	set @donen=@fiyat+@fiyat/100*@yuzde
	return @donen
end
go
print dbo.zaml�Hesapla(150,12.5)
-- �r�nler tablosunda �r�nleri %10 zaml� fiyatlar�yla g�steriniz
SELECT �r�nAd,BirimFiyat, dbo.zaml�Hesapla(BirimFiyat,10) AS Zaml�
FROM �r�nler

--Verilen oranda indirimli fiyat� hesaplayan fonksiyonu yaz�n�z 
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
--- Tabloda �r�nlerin %20 indirimli fiyatlar�yla g�sterin
SELECT �r�nAd, BirimFiyat,dbo.indirimHesapla(BirimFiyat,20)AS indirimli
FROM �R�nler

-- Derececinsinde verilen a��n�n Sin Cos hesaplayan fonksiyon
-- yazal�m 
print sin(90)

CREATE FUNCTION SinD(@aci float)
RETURNS float
BEGIN
 DECLARE @rad float , @sonuc float
 SET @rad = @aci*PI()/180.0--dereceyi 180e b�l, pi ile �arp radyanolsun
 SET @sonuc = SIN(@rad)
 RETURN @sonuc
END
print dbo.SinD(90)
SELECT dbo.SinD(45) AS 'Sin(45)'
-- derece cinsinden cos hesaplamak i�in yukar�daki fonksiyonda
-- 6. sat�rda sin yerine cos yazars�n�z

--verilen iki tarih aras�ndaki fark� ya� olarak hesaplayan fonksiyon
GO
CREATE FUNCTION Ya�(@ilkTar DateTime, @sonTar DateTime)
RETURNS int
BEGIN
	DECLARE @yil int
	SET @yil = DATEDIFF(YEAR,@ilkTar, @sonTar)
	RETURN @yil
END
GO
-- bu fonksiyonu kullanarak �al��anlar�, ya�lar� ile listeleyiniz
SELECT *, dbo.Ya�(Do�umTarihi, getdate()) AS Ya�
FROM �al��anlar
--
--�retim Tarihi ve Kullan�m s�resi verilen bir �r�n�n s�resinin
--dolmu� yada t�ketilebilir oldu�unu mesaj olarak veren bir  fonksiyon
--yaz�n�z :
print DATEDIFF(DAY,'2018-12-15',getdate()) 
GO                                    --�r�n�n t�ketilebilece�i g�n say�s�
CREATE FUNCTION T�ketilirmi(@ureTar datetime, @gecerliGun int)
RETURNS varchar(50)
BEGIN
	DECLARE @gun int, @mesaj varchar(50)
	SET @gun = DATEDIFF(DAY,@ureTar,getdate())
	if(@gun<=@gecerliGun)
		SET @mesaj = 'T�ketilebilir'
	else
		SET @mesaj = 'Kullan�m s�resi dolmu�'
	RETURN @mesaj
END
GO

print dbo.T�ketilirmi('2018-12-15',3)

-- T�ketim tarihine ka� g�n kald���n� veya ka� g�n ge�ti�ini s�ylesin
CREATE FUNCTION KacGunKald�Gecti(@ureTar datetime, @gecerliGun int)
RETURNS varchar(50)
BEGIN
	DECLARE @kalanGecenGun int, @gun int, @mesaj varchar(50)
	SET @gun = DATEDIFF(DAY,@ureTar,getdate())--her zaman �retimTar.ge�mi�te
	SET @kalanGecenGun = @gecerliGun-@gun
	if(@kalanGecenGun>=0)
		SET @mesaj = 'STT ne '+CONVERT(varchar,@kalanGecenGun)+' kald�.'
	else
		SET @mesaj = 'STT ni '+CONVERT(varchar,-@kalanGecenGun)+' ge�mi�.'
	RETURN @mesaj
END
print dbo.KacGunKald�Gecti('2018-12-10',30)

-- �Al��anlar Tablosunda Emeklilik ya�� gelmi� �al��anlar�n yan�na 
-- 'Emeklili�i gelmi�' yazan bir fonksiyon yaz�n�z
go
CREATE FUNCTION Ya�aG�reEmekliMi(@dtar datetime, @emekliYas int)
RETURNS varchar(50)
BEGIN 
	DECLARE @mesaj varchar(50)
	IF( datediff(year,@dtar,getdate())>=@emekliYas )
		SET @mesaj ='Emekli'
	ELSE SET @mesaj = 'Emekli de�il'
	RETURN @mesaj
END
go
SELECT *, dbo.Ya�aG�reEmekliMi(Do�umTarihi,55) AS Durum 
FROM �al��anlar

-- Sipari� Numaras� verilen bir �r�n�n, t�m Sipari�lerde toplamda 
--ne miktarda  Sat�ld���n� hesaplayan bir fonksiyon 
GO
CREATE FUNCTION �r�nToplamSat��Miktar�(@urunno int)
RETURNS int 
BEGIN
	DECLARE @ToplamMiktar int 
	SET @ToplamMiktar =(SELECT SUM(Miktar) FROM [Sipari� Detaylar�]
						WHERE �r�nNo = @urunno )
	RETURN @ToplamMiktar
END

print dbo.�r�nToplamSAt��Miktar�(2)  -- 1 sihirli zambak
--
SELECT �r�nNo,�r�nAd,StokMiktar�,
   dbo.�r�nToplamSat��Miktar�(�r�nNo) AS ToplamSat��Miktar�
FROM �r�nler
GO
-- Sipari�Numaras� verilen sipari�i, �r�n Ad, fiyat, miktarlar�  ile
-- listeleyen fonksiyonu yaz�n�z.
GO
CREATE FUNCTION Sipari�(@sipNo int)
RETURNS TABLE -- Tablo d�nd�ren fonksiyon
AS
RETURN
(
 SELECT �r�nAd, [Sipari� Detaylar�].BirimFiyat, Miktar 
 FROM  [Sipari� Detaylar�] 
 INNER JOIN �r�nler ON [Sipari� Detaylar�].�r�nNo = �r�nler.�r�nNo
 WHERE Sipari�No =@sipNo
)
GO
-- fonksiyonu �a��ral�m:
SELECT * FROM  dbo.Sipari�(11080)
--

--------------------------------------------------------
-- hafta9 dan Trigger 
-- TRIGGERS : Tetikleyiciler
--
CREATE TRIGGER tetikleyici_ad�
ON tabloAd�_yada_gorunumAd�
Tetikleyici_t�r�(After/Instead Of/FOR) komut_list(insert,update,delte)
AS
SQL_ifadeleri(Prosed�r)

After : Birden fazla komut(insert,update,delete) dinleyebilir.
-- Alter ile Tetikleyiciyi de�i�tiririz
-- alter den sonra ba�tan yazman�z gerek
CREATE TRIGGER tr_�al��anYeniKay�tSonra
ON �al��anlar
AFTER INSERT, UPDATE
AS
INSERT INTO TetikMesaj(TetikAd�,Mesaj )
VALUES('tr_�al��anYeniKay�tSonra',
   '�al��anlar Tablosuna kay�t eklendi veya g�ncellendi')
GO
INSERT INTO �al��anlar(�al��anNo,Ad�,Soyad�)
VALUES(19,'Alphan','NAR')
GO
UPDATE �al��anlar 
SET Ad� ='Mehmet', Soyad� = 'TURHAN'
WHERE �al��anNo =19 
GO
SELECT * FROM TetikMesaj

-- Tetikleyiciyi silmek i�in

DROP Trigger TetikleyiciAd�

DROP Trigger tr_�al��anYeniKay�tSonra
