/*
    A��klama Paragraf�
*/

-- A��klama Sat�r�

SELECT * FROM M��teriler

-- SELECT SE�
-- * : joker t�m kolonlar
-- ALL : T�m sat�rlar, genelde hi� yaz�lmaz, varsay�lan t�m sat�rlar

a��klamalar ..

SELECT * FROM �r�nler

SELECT 5+7 AS Toplam

SELECT 'Cenk ' + 'Turkoglu' AS AdSoyad
C# java php vb  string s = " SELECT 'cenk'+'turkoglu' ";

-- �stten sadece belirli say�da sat�r getirmek i�in TOP sat�rSay�s�
SELECT TOP 5 * FROM M��teriler

-- SQL sorgu c�mleleri aras�na GO konarak ayr�l�r.
-- GO uzun s�ren SQL sorgular�n�n beklenmesini, bir sonraki sql komutuna ge�ilmemesini sa�lar.
-- SELECT, insert, update, delete aralar�na konmasa da olur
-- Procedure, fonksiyon vb.. vt nesnelerini yaratan kodun aras�na konmas� gereklidir.


USE VTAd�
: Ad� verilen veritaban�na ba�lanmay� sa�lar

USE master
GO
USE model
GO
USE Bahceisleri
GO
CREATE DATABASE deneme
GO
USE deneme