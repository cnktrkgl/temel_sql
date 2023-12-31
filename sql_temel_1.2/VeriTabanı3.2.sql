SELECT * FROM BahceGör

SELECT        dbo.Sipariþler.SipariþNo, dbo.Müþteriler.Adý + ' ' + dbo.Müþteriler.Soyadý AS Müþteriler, dbo.Çalýþanlar.Adý AS ÇalýþanAd, dbo.Çalýþanlar.Soyadý AS ÇalýþanSoyad, dbo.Nakliyeciler.ÞÝRKET AS Kargo, dbo.Ürünler.ÜrünAd, 
                         dbo.Kategoriler.KategoriAdý AS Kategorisi, dbo.[Sipariþ Detaylarý].BirimFiyat, dbo.[Sipariþ Detaylarý].Miktar, dbo.[Sipariþ Detaylarý].Ýndirim, dbo.Satýcýlar.FirmaAdý AS SatýcýFirma
FROM            dbo.Çalýþanlar INNER JOIN
                         dbo.Sipariþler ON dbo.Çalýþanlar.ÇalýþanNo = dbo.Sipariþler.ÇalýþanNo INNER JOIN
                         dbo.Müþteriler ON dbo.Sipariþler.MüþteriNO = dbo.Müþteriler.MüþteriNo INNER JOIN
                         dbo.Nakliyeciler ON dbo.Sipariþler.Nakliyeci = dbo.Nakliyeciler.NAKLÝYECÝNO INNER JOIN
                         dbo.[Sipariþ Detaylarý] ON dbo.Sipariþler.SipariþNo = dbo.[Sipariþ Detaylarý].SipariþNo INNER JOIN
                         dbo.Ürünler ON dbo.[Sipariþ Detaylarý].ÜrünNo = dbo.Ürünler.ÜrünNo INNER JOIN
                         dbo.Satýcýlar ON dbo.Ürünler.SatýcýFirmaNo = dbo.Satýcýlar.SatýcýFirmaNo INNER JOIN
                         dbo.Kategoriler ON dbo.Ürünler.KategoriNo = dbo.Kategoriler.KategoriNo