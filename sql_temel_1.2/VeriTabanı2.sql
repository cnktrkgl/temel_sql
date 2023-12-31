 /*
Tablo Birleþtirme (JOIN): 
Birden fazla iliþkili tablodan kayýtlarý birleþtirerek 
sorgulamak için kullanýlýr. Genel olarak ÜÇ türü vardýr : 
1. INNER JOIN : Ýç Birleþtirme. Birleþtirme koþuluna uyan kayýtlarý
listeler.
2. OUTER JOIN : Dýþ Birleþtirme. Birleþtirme koþuluna uyan, bir
veya her iki tablodan birleþtirme koþuluna uymayan kayýtlarý da
listeler. Türleri:
	a)LEFT OUTER JOIN : SOL dýþ birleþtirme : Her iki tablodan
		birleþtirme koþuluna uyan kayýtlara ek olarak SOLDAKÝ
	tablonun birleþtirme koþuluna uyMAyan kayýtlarýný listeler.
	b)RIGHT OUTER JOIN : SAÐ dýþ birleþtirme : Her iki tablodan
		birleþtirme koþuluna uyan kayýtlara ek olarak SAÐDAKÝ
	tablonun birleþtirme koþuluna uyMAyan kayýtlarýný listeler.
	c)FULL OUTER JOIN : TAM dýþ birleþtirme : Her iki tablodan
		birleþtirme koþuluna uyan kayýtlara ek olarak HER ÝKÝ
	tablonun birleþtirme koþuluna uyMAyan kayýtlarýný listeler.
3. CROSS JOIN : Saðdaki tablonun tüm kayýtlarý ile Soldaki tablonun
	tüm kayýtlarýný eþleþtirir. Bir tabloda 7 diðerinde 8 kayýt
	varsa 7x8=56 satýr listeler

	kolonlarý çaðýrmak için :
	tabloAdý.kolonAdý
	veritabanýAdý.tabloAdý.dbo.kolonAdý

	Iç birleþtirme  : 
	SELECT * FROM tablo1
	INNER JOIN tablo2 ON birleþtirmeKoþulu1
	INNER JOIN tablo3 ON birleþtirmeKoþulu2
	....

	Birleþtirme koþulu : 
	tablo1.primarykey = tablo2.foreinkey

	KolonAdlarýnýn yazýlýþý :
	SELECT TaboAdý.KolonAdý, ...
	Tam yazýlýþý :
	VeritabanýAdý.dbo.TabloAdý.KolonAdý
	dbo : database owner

	use master
	SELECT Bahceisleri.dbo.Müþteriler.Adý
	FROM Bahceisleri.dbo.Müþteriler
	*/
	-----------------------------------------------------
	-- Hangi Müþteri, Hangi Sipariþi Vermiþtir?
	SELECT * FROM Müþteriler
	INNER JOIN Sipariþler
	ON Sipariþler.MüþteriNO = Müþteriler.MüþteriNo

	SELECT Müþteriler.MüþteriNo, Müþteriler.Adý, Müþteriler.Soyadý, 
			Sipariþler.SipariþNo 
	FROM Müþteriler
	INNER JOIN Sipariþler
	ON Sipariþler.MüþteriNO = Müþteriler.MüþteriNo

	-- Hangi Müþteri, hangi Sipariþi, hangi Çalýþana vermiþtir?
	SELECT Müþteriler.MüþteriNo, Müþteriler.Adý AS MüþteriAdý, Müþteriler.Soyadý AS MüþteriSoyadý, 
			Sipariþler.SipariþNo, 
			Çalýþanlar.ÇalýþanNo, Çalýþanlar.Adý +' '+ Çalýþanlar.Soyadý AS Çalýþanlar
	FROM Müþteriler
	INNER JOIN Sipariþler
	ON Sipariþler.MüþteriNO = Müþteriler.MüþteriNo
	INNER JOIN Çalýþanlar
	ON Sipariþler.ÇalýþanNo = Çalýþanlar.ÇalýþanNo

	-- Hangi Müþteri, hangi Sipariþi, hangi Çalýþan, hangi Nakliyeci taþýmýþtýr?
	SELECT Müþteriler.MüþteriNo, Müþteriler.Adý AS MüþteriAdý, Müþteriler.Soyadý AS MüþteriSoyadý, 
			Sipariþler.SipariþNo, 
			Çalýþanlar.ÇalýþanNo, Çalýþanlar.Adý +' '+ Çalýþanlar.Soyadý AS Çalýþanlar,
			Nakliyeciler.NAKLÝYECÝNO, Nakliyeciler.ÞÝRKET AS KargoFirmasý
	FROM Müþteriler
	INNER JOIN Sipariþler
	ON Sipariþler.MüþteriNO = Müþteriler.MüþteriNo
	INNER JOIN Çalýþanlar
	ON Sipariþler.ÇalýþanNo = Çalýþanlar.ÇalýþanNo
	INNER JOIN Nakliyeciler
	ON Sipariþler.Nakliyeci = Nakliyeciler.NAKLÝYECÝNO

	-- Hangi Müþteri, hangi Sipariþi, hangi Çalýþan, hangi Nakliyeci, Hangi üründen kaç tane kaç liraya kaç tane satýlmýþtýr 
	-- ve indirim uygulanmýþmýdýr?
	SELECT Müþteriler.MüþteriNo, Müþteriler.Adý AS MüþteriAdý, Müþteriler.Soyadý AS MüþteriSoyadý, 
			Sipariþler.SipariþNo, 
			Çalýþanlar.ÇalýþanNo, Çalýþanlar.Adý +' '+ Çalýþanlar.Soyadý AS Çalýþanlar,
			Nakliyeciler.NAKLÝYECÝNO, Nakliyeciler.ÞÝRKET AS KargoFirmasý,
			Ürünler.ÜrünAd, 
			[Sipariþ Detaylarý].BirimFiyat, [Sipariþ Detaylarý].Miktar, [Sipariþ Detaylarý].Ýndirim,
			Ürünler.KategoriNo, Ürünler.SatýcýFirmaNo
	FROM Müþteriler
	INNER JOIN Sipariþler
	ON Sipariþler.MüþteriNO = Müþteriler.MüþteriNo
	INNER JOIN Çalýþanlar
	ON Sipariþler.ÇalýþanNo = Çalýþanlar.ÇalýþanNo
	INNER JOIN Nakliyeciler
	ON Sipariþler.Nakliyeci = Nakliyeciler.NAKLÝYECÝNO
	INNER JOIN [Sipariþ Detaylarý]
	ON Sipariþler.SipariþNo = [Sipariþ Detaylarý].SipariþNo
	INNER JOIN Ürünler
	ON [Sipariþ Detaylarý].ÜrünNo = Ürünler.ÜrünNo

	-- Hangi Müþteri, hangi Sipariþi, hangi Çalýþan, hangi Nakliyeci, Hangi üründen kaç tane kaç liraya kaç tane satýlmýþtýr 
	-- ve indirim uygulanmýþmýdýr, ürünlerin kategorisini ve tedarik ettiðimiz satýcý firmayý da gösteriniz?
	SELECT Müþteriler.MüþteriNo, Müþteriler.Adý AS MüþteriAdý, Müþteriler.Soyadý AS MüþteriSoyadý, 
			Sipariþler.SipariþNo, 
			Çalýþanlar.ÇalýþanNo, Çalýþanlar.Adý +' '+ Çalýþanlar.Soyadý AS Çalýþanlar,
			Nakliyeciler.NAKLÝYECÝNO, Nakliyeciler.ÞÝRKET AS KargoFirmasý,
			Ürünler.ÜrünAd, 
			[Sipariþ Detaylarý].BirimFiyat, [Sipariþ Detaylarý].Miktar, [Sipariþ Detaylarý].Ýndirim,
			Ürünler.KategoriNo, Kategoriler.KategoriAdý, 
			Ürünler.SatýcýFirmaNo, Satýcýlar.FirmaAdý AS SatýcýFirma
	FROM Müþteriler
	INNER JOIN Sipariþler
	ON Sipariþler.MüþteriNO = Müþteriler.MüþteriNo
	INNER JOIN Çalýþanlar
	ON Sipariþler.ÇalýþanNo = Çalýþanlar.ÇalýþanNo
	INNER JOIN Nakliyeciler
	ON Sipariþler.Nakliyeci = Nakliyeciler.NAKLÝYECÝNO
	INNER JOIN [Sipariþ Detaylarý]
	ON Sipariþler.SipariþNo = [Sipariþ Detaylarý].SipariþNo
	INNER JOIN Ürünler
	ON [Sipariþ Detaylarý].ÜrünNo = Ürünler.ÜrünNo
	INNER JOIN Kategoriler
	ON Ürünler.KategoriNo = Kategoriler.KategoriNo
	INNER JOIN Satýcýlar
	ON Ürünler.SatýcýFirmaNo = Satýcýlar.SatýcýFirmaNo