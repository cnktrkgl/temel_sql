DELETE FROM �al��anlar WHERE �al��anNo=13

-- Yabanc� Anahtar K�s�tlamas�:
-- Foregin Key Constraint ile
-- e�le�en alanlar� koruma alt�na alal�m


-- sipari�ler tablosundaki m��teriler :
SELECT M��teriNo FROM Sipari�ler  --87
-- acaba bunlardan hangilerinin M��teriler
-- tablosunda kar��l��� var??
SELECT M��teriNo FROM M��teriler  --113
WHERE M��teriNo IN (SELECT M��teriNo FROM Sipari�ler)
                    -- sipari�ler tablosunda olanlar
-- sipari�ler tablosundaki m��teri numaralar�ndan
-- hangileri M��teriler tablosunda yoktur
SELECT M��teriNo FROM Sipari�ler
WHERE M��teriNo NOT IN (SELECT M��teriNo FROM M��teriler)