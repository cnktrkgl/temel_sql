-- SQL DIÞ BÝRLEÞTÝRME : Ýç birleþtirme + soldaki
-- tablonun birleþtirme koþuluna uymayan kayýtlarý listelenir

-- Müþterilerin verdiði sipariþler ile birlikte 
-- Sipariþ vermemiþ müþterileri listeleyiniz

SELECT Sipariþler.SipariþNo, Sipariþler.MüþteriNo, Adý, Soyadý
FROM Müþteriler
LEFT OUTER JOIN Sipariþler
ON Sipariþler.MüþteriNO = Müþteriler.MüþteriNo
ORDER BY SipariþNo ASC

-- Not From dan sonra ilk gelen sol dur.

-- SAÐ DIÞ BÝRLEÞTÝRME : Ýç birleþtirme + saðdaki
-- tablonun birleþtirme koþuluna uymayan kayýtlarý listelenir

-- Müþterilerin verdiði sipariþler ile birlikte
-- Kimin verdiði belli olmayan sipariþleri de listeleyiniz

SELECT Sipariþler.SipariþNo, Sipariþler.MüþteriNo, Adý, Soyadý
FROM Müþteriler
RIGHT OUTER JOIN Sipariþler
ON Sipariþler.MüþteriNO = Müþteriler.MüþteriNo
ORDER BY SipariþNo ASC


-- TAM DIÞ BÝRLEÞTÝRME : Ýç birleþtirme + her iki
-- tablonun birleþtirme koþuluna uymayan kayýtlarý listelenir

-- Müþterilerin verdiði sipariþler ile birlikte
-- Sipariþ vermemiþ Müþterileri,
-- Kimin verdiði belli olmayan sipariþleri de listeleyiniz

SELECT Sipariþler.SipariþNo, Sipariþler.MüþteriNo, Adý, Soyadý
FROM Müþteriler
FULL OUTER JOIN Sipariþler
ON Sipariþler.MüþteriNO = Müþteriler.MüþteriNo
ORDER BY SipariþNo ASC

-----------------------
SELECT * FROM Bahceisleri.dbo.Müþteriler
SELECT * FROM Bahceisleri.dbo.Sipariþler