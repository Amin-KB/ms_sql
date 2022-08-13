SELECT * FROM Territories
SELECT * FROM Region

SELECT TerritoryDescription, RegionDescription 
FROM Territories, Region
ORDER BY TerritoryDescription

--Der Cross Join kombiniert jeden Datensatz mit jedem anderen
--Wir müssen daher auch keine ON Bedingung angeben
--Hat eine Tabelle Datensätz A, B, C und eine andere P und Q, so ist der Cross-Join der beiden: AP, AQ, BP, BQ, CP, CQ

--Wird in der Praxis, außer in Analyse-Fällen, selten angewandt