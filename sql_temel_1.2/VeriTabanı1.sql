DELETE FROM Çalýþanlar WHERE ÇalýþanNo=13

-- Yabancý Anahtar Kýsýtlamasý:
-- Foregin Key Constraint ile
-- eþleþen alanlarý koruma altýna alalým


-- sipariþler tablosundaki müþteriler :
SELECT MüþteriNo FROM Sipariþler  --87
-- acaba bunlardan hangilerinin Müþteriler
-- tablosunda karþýlýðý var??
SELECT MüþteriNo FROM Müþteriler  --113
WHERE MüþteriNo IN (SELECT MüþteriNo FROM Sipariþler)
                    -- sipariþler tablosunda olanlar
-- sipariþler tablosundaki müþteri numaralarýndan
-- hangileri Müþteriler tablosunda yoktur
SELECT MüþteriNo FROM Sipariþler
WHERE MüþteriNo NOT IN (SELECT MüþteriNo FROM Müþteriler)