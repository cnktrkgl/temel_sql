-- SQL DI� B�RLE�T�RME : �� birle�tirme + soldaki
-- tablonun birle�tirme ko�uluna uymayan kay�tlar� listelenir

-- M��terilerin verdi�i sipari�ler ile birlikte 
-- Sipari� vermemi� m��terileri listeleyiniz

SELECT Sipari�ler.Sipari�No, Sipari�ler.M��teriNo, Ad�, Soyad�
FROM M��teriler
LEFT OUTER JOIN Sipari�ler
ON Sipari�ler.M��teriNO = M��teriler.M��teriNo
ORDER BY Sipari�No ASC

-- Not From dan sonra ilk gelen sol dur.

-- SA� DI� B�RLE�T�RME : �� birle�tirme + sa�daki
-- tablonun birle�tirme ko�uluna uymayan kay�tlar� listelenir

-- M��terilerin verdi�i sipari�ler ile birlikte
-- Kimin verdi�i belli olmayan sipari�leri de listeleyiniz

SELECT Sipari�ler.Sipari�No, Sipari�ler.M��teriNo, Ad�, Soyad�
FROM M��teriler
RIGHT OUTER JOIN Sipari�ler
ON Sipari�ler.M��teriNO = M��teriler.M��teriNo
ORDER BY Sipari�No ASC


-- TAM DI� B�RLE�T�RME : �� birle�tirme + her iki
-- tablonun birle�tirme ko�uluna uymayan kay�tlar� listelenir

-- M��terilerin verdi�i sipari�ler ile birlikte
-- Sipari� vermemi� M��terileri,
-- Kimin verdi�i belli olmayan sipari�leri de listeleyiniz

SELECT Sipari�ler.Sipari�No, Sipari�ler.M��teriNo, Ad�, Soyad�
FROM M��teriler
FULL OUTER JOIN Sipari�ler
ON Sipari�ler.M��teriNO = M��teriler.M��teriNo
ORDER BY Sipari�No ASC

-----------------------
SELECT * FROM Bahceisleri.dbo.M��teriler
SELECT * FROM Bahceisleri.dbo.Sipari�ler