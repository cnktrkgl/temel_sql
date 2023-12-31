 /*
Tablo Birle�tirme (JOIN): 
Birden fazla ili�kili tablodan kay�tlar� birle�tirerek 
sorgulamak i�in kullan�l�r. Genel olarak �� t�r� vard�r : 
1. INNER JOIN : �� Birle�tirme. Birle�tirme ko�uluna uyan kay�tlar�
listeler.
2. OUTER JOIN : D�� Birle�tirme. Birle�tirme ko�uluna uyan, bir
veya her iki tablodan birle�tirme ko�uluna uymayan kay�tlar� da
listeler. T�rleri:
	a)LEFT OUTER JOIN : SOL d�� birle�tirme : Her iki tablodan
		birle�tirme ko�uluna uyan kay�tlara ek olarak SOLDAK�
	tablonun birle�tirme ko�uluna uyMAyan kay�tlar�n� listeler.
	b)RIGHT OUTER JOIN : SA� d�� birle�tirme : Her iki tablodan
		birle�tirme ko�uluna uyan kay�tlara ek olarak SA�DAK�
	tablonun birle�tirme ko�uluna uyMAyan kay�tlar�n� listeler.
	c)FULL OUTER JOIN : TAM d�� birle�tirme : Her iki tablodan
		birle�tirme ko�uluna uyan kay�tlara ek olarak HER �K�
	tablonun birle�tirme ko�uluna uyMAyan kay�tlar�n� listeler.
3. CROSS JOIN : Sa�daki tablonun t�m kay�tlar� ile Soldaki tablonun
	t�m kay�tlar�n� e�le�tirir. Bir tabloda 7 di�erinde 8 kay�t
	varsa 7x8=56 sat�r listeler

	kolonlar� �a��rmak i�in :
	tabloAd�.kolonAd�
	veritaban�Ad�.tabloAd�.dbo.kolonAd�

	I� birle�tirme  : 
	SELECT * FROM tablo1
	INNER JOIN tablo2 ON birle�tirmeKo�ulu1
	INNER JOIN tablo3 ON birle�tirmeKo�ulu2
	....

	Birle�tirme ko�ulu : 
	tablo1.primarykey = tablo2.foreinkey

	KolonAdlar�n�n yaz�l��� :
	SELECT TaboAd�.KolonAd�, ...
	Tam yaz�l��� :
	Veritaban�Ad�.dbo.TabloAd�.KolonAd�
	dbo : database owner

	use master
	SELECT Bahceisleri.dbo.M��teriler.Ad�
	FROM Bahceisleri.dbo.M��teriler
	*/
	-----------------------------------------------------
	-- Hangi M��teri, Hangi Sipari�i Vermi�tir?
	SELECT * FROM M��teriler
	INNER JOIN Sipari�ler
	ON Sipari�ler.M��teriNO = M��teriler.M��teriNo

	SELECT M��teriler.M��teriNo, M��teriler.Ad�, M��teriler.Soyad�, 
			Sipari�ler.Sipari�No 
	FROM M��teriler
	INNER JOIN Sipari�ler
	ON Sipari�ler.M��teriNO = M��teriler.M��teriNo

	-- Hangi M��teri, hangi Sipari�i, hangi �al��ana vermi�tir?
	SELECT M��teriler.M��teriNo, M��teriler.Ad� AS M��teriAd�, M��teriler.Soyad� AS M��teriSoyad�, 
			Sipari�ler.Sipari�No, 
			�al��anlar.�al��anNo, �al��anlar.Ad� +' '+ �al��anlar.Soyad� AS �al��anlar
	FROM M��teriler
	INNER JOIN Sipari�ler
	ON Sipari�ler.M��teriNO = M��teriler.M��teriNo
	INNER JOIN �al��anlar
	ON Sipari�ler.�al��anNo = �al��anlar.�al��anNo

	-- Hangi M��teri, hangi Sipari�i, hangi �al��an, hangi Nakliyeci ta��m��t�r?
	SELECT M��teriler.M��teriNo, M��teriler.Ad� AS M��teriAd�, M��teriler.Soyad� AS M��teriSoyad�, 
			Sipari�ler.Sipari�No, 
			�al��anlar.�al��anNo, �al��anlar.Ad� +' '+ �al��anlar.Soyad� AS �al��anlar,
			Nakliyeciler.NAKL�YEC�NO, Nakliyeciler.��RKET AS KargoFirmas�
	FROM M��teriler
	INNER JOIN Sipari�ler
	ON Sipari�ler.M��teriNO = M��teriler.M��teriNo
	INNER JOIN �al��anlar
	ON Sipari�ler.�al��anNo = �al��anlar.�al��anNo
	INNER JOIN Nakliyeciler
	ON Sipari�ler.Nakliyeci = Nakliyeciler.NAKL�YEC�NO

	-- Hangi M��teri, hangi Sipari�i, hangi �al��an, hangi Nakliyeci, Hangi �r�nden ka� tane ka� liraya ka� tane sat�lm��t�r 
	-- ve indirim uygulanm��m�d�r?
	SELECT M��teriler.M��teriNo, M��teriler.Ad� AS M��teriAd�, M��teriler.Soyad� AS M��teriSoyad�, 
			Sipari�ler.Sipari�No, 
			�al��anlar.�al��anNo, �al��anlar.Ad� +' '+ �al��anlar.Soyad� AS �al��anlar,
			Nakliyeciler.NAKL�YEC�NO, Nakliyeciler.��RKET AS KargoFirmas�,
			�r�nler.�r�nAd, 
			[Sipari� Detaylar�].BirimFiyat, [Sipari� Detaylar�].Miktar, [Sipari� Detaylar�].�ndirim,
			�r�nler.KategoriNo, �r�nler.Sat�c�FirmaNo
	FROM M��teriler
	INNER JOIN Sipari�ler
	ON Sipari�ler.M��teriNO = M��teriler.M��teriNo
	INNER JOIN �al��anlar
	ON Sipari�ler.�al��anNo = �al��anlar.�al��anNo
	INNER JOIN Nakliyeciler
	ON Sipari�ler.Nakliyeci = Nakliyeciler.NAKL�YEC�NO
	INNER JOIN [Sipari� Detaylar�]
	ON Sipari�ler.Sipari�No = [Sipari� Detaylar�].Sipari�No
	INNER JOIN �r�nler
	ON [Sipari� Detaylar�].�r�nNo = �r�nler.�r�nNo

	-- Hangi M��teri, hangi Sipari�i, hangi �al��an, hangi Nakliyeci, Hangi �r�nden ka� tane ka� liraya ka� tane sat�lm��t�r 
	-- ve indirim uygulanm��m�d�r, �r�nlerin kategorisini ve tedarik etti�imiz sat�c� firmay� da g�steriniz?
	SELECT M��teriler.M��teriNo, M��teriler.Ad� AS M��teriAd�, M��teriler.Soyad� AS M��teriSoyad�, 
			Sipari�ler.Sipari�No, 
			�al��anlar.�al��anNo, �al��anlar.Ad� +' '+ �al��anlar.Soyad� AS �al��anlar,
			Nakliyeciler.NAKL�YEC�NO, Nakliyeciler.��RKET AS KargoFirmas�,
			�r�nler.�r�nAd, 
			[Sipari� Detaylar�].BirimFiyat, [Sipari� Detaylar�].Miktar, [Sipari� Detaylar�].�ndirim,
			�r�nler.KategoriNo, Kategoriler.KategoriAd�, 
			�r�nler.Sat�c�FirmaNo, Sat�c�lar.FirmaAd� AS Sat�c�Firma
	FROM M��teriler
	INNER JOIN Sipari�ler
	ON Sipari�ler.M��teriNO = M��teriler.M��teriNo
	INNER JOIN �al��anlar
	ON Sipari�ler.�al��anNo = �al��anlar.�al��anNo
	INNER JOIN Nakliyeciler
	ON Sipari�ler.Nakliyeci = Nakliyeciler.NAKL�YEC�NO
	INNER JOIN [Sipari� Detaylar�]
	ON Sipari�ler.Sipari�No = [Sipari� Detaylar�].Sipari�No
	INNER JOIN �r�nler
	ON [Sipari� Detaylar�].�r�nNo = �r�nler.�r�nNo
	INNER JOIN Kategoriler
	ON �r�nler.KategoriNo = Kategoriler.KategoriNo
	INNER JOIN Sat�c�lar
	ON �r�nler.Sat�c�FirmaNo = Sat�c�lar.Sat�c�FirmaNo