SELECT * FROM Territories
SELECT * FROM Region

SELECT TerritoryDescription, RegionDescription 
FROM Territories, Region
ORDER BY TerritoryDescription

--Der Cross Join kombiniert jeden Datensatz mit jedem anderen
--Wir m�ssen daher auch keine ON Bedingung angeben
--Hat eine Tabelle Datens�tz A, B, C und eine andere P und Q, so ist der Cross-Join der beiden: AP, AQ, BP, BQ, CP, CQ

--Wird in der Praxis, au�er in Analyse-F�llen, selten angewandt