SELECT * FROM BahceG�r

SELECT        dbo.Sipari�ler.Sipari�No, dbo.M��teriler.Ad� + ' ' + dbo.M��teriler.Soyad� AS M��teriler, dbo.�al��anlar.Ad� AS �al��anAd, dbo.�al��anlar.Soyad� AS �al��anSoyad, dbo.Nakliyeciler.��RKET AS Kargo, dbo.�r�nler.�r�nAd, 
                         dbo.Kategoriler.KategoriAd� AS Kategorisi, dbo.[Sipari� Detaylar�].BirimFiyat, dbo.[Sipari� Detaylar�].Miktar, dbo.[Sipari� Detaylar�].�ndirim, dbo.Sat�c�lar.FirmaAd� AS Sat�c�Firma
FROM            dbo.�al��anlar INNER JOIN
                         dbo.Sipari�ler ON dbo.�al��anlar.�al��anNo = dbo.Sipari�ler.�al��anNo INNER JOIN
                         dbo.M��teriler ON dbo.Sipari�ler.M��teriNO = dbo.M��teriler.M��teriNo INNER JOIN
                         dbo.Nakliyeciler ON dbo.Sipari�ler.Nakliyeci = dbo.Nakliyeciler.NAKL�YEC�NO INNER JOIN
                         dbo.[Sipari� Detaylar�] ON dbo.Sipari�ler.Sipari�No = dbo.[Sipari� Detaylar�].Sipari�No INNER JOIN
                         dbo.�r�nler ON dbo.[Sipari� Detaylar�].�r�nNo = dbo.�r�nler.�r�nNo INNER JOIN
                         dbo.Sat�c�lar ON dbo.�r�nler.Sat�c�FirmaNo = dbo.Sat�c�lar.Sat�c�FirmaNo INNER JOIN
                         dbo.Kategoriler ON dbo.�r�nler.KategoriNo = dbo.Kategoriler.KategoriNo