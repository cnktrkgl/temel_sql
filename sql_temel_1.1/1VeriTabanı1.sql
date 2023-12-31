/*
    Açýklama Paragrafý
*/

-- Açýklama Satýrý

SELECT * FROM Müþteriler

-- SELECT SEÇ
-- * : joker tüm kolonlar
-- ALL : Tüm satýrlar, genelde hiç yazýlmaz, varsayýlan tüm satýrlar

açýklamalar ..

SELECT * FROM Ürünler

SELECT 5+7 AS Toplam

SELECT 'Cenk ' + 'Turkoglu' AS AdSoyad
C# java php vb  string s = " SELECT 'cenk'+'turkoglu' ";

-- üstten sadece belirli sayýda satýr getirmek için TOP satýrSayýsý
SELECT TOP 5 * FROM Müþteriler

-- SQL sorgu cümleleri arasýna GO konarak ayrýlýr.
-- GO uzun süren SQL sorgularýnýn beklenmesini, bir sonraki sql komutuna geçilmemesini saðlar.
-- SELECT, insert, update, delete aralarýna konmasa da olur
-- Procedure, fonksiyon vb.. vt nesnelerini yaratan kodun arasýna konmasý gereklidir.


USE VTAdý
: Adý verilen veritabanýna baðlanmayý saðlar

USE master
GO
USE model
GO
USE Bahceisleri
GO
CREATE DATABASE deneme
GO
USE deneme