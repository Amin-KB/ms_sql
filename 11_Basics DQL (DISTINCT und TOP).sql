--Oft erh�lt man Informationen/Datens�tze die sich im Ergebnis einer Abfrage wiederholen
--Um diese Wiederholungen zu eliminieren, kann man mit DISTINCT arbeiten
SELECT ShipCountry FROM Orders
ORDER BY ShipCountry

--Syntax:
--select DISTINCT <spalte1>, <spalte2>, ... FROM <tabelle>

SELECT DISTINCT ShipCountry FROM Orders
ORDER BY ShipCountry

--WICHTIG: Das DISTINCT Schl�sselwort bezieht sich immer auf ALLE Spalten

SELECT DISTINCT ShipCountry, Freight FROM Orders
ORDER BY ShipCountry

--In der Abfrage oben werden also nur Datens�tze gestrichen, die sich sowohl im ShipCountry ALS AUCH in der Freight wiederholen

--Austria, 50 --> OK, keine Wiederholung
--Austria, 70 --> OK, keine Wiederholung
--Germany, 50 --> OK, keine Wiederholung
--Germany, 70 --> OK, keine Wiederholung
--Germany, 70 --> Wird entfernt, da Wiederholung �ber ALLE Spalten


------
--Das Schl�sselwort TOP (in anderen rDBMS auch oft LIMIT genannt) schr�nkt die Anzahl der Ergebnisse ein. Entweder auf eine Absolute Anzahl, oder eine prozentuelle Anzahl
--Syntax:
--select TOP(n) |PERCENT| <spalte1>, <spalte2>, ... FROM <table>

SELECT ProductName, UnitPrice FROM Products
ORDER BY UnitPrice DESC

SELECT TOP(5) ProductName, UnitPrice FROM Products
ORDER BY UnitPrice DESC

SELECT TOP(10) PERCENT ProductName, UnitPrice FROM Products
ORDER BY UnitPrice DESC

--Am h�ufigsten wird das eingesetzt um  herauszufinden welches sind die X gr��ten/teuersten/schwersten/meisten/... Produkte/...
--Da wird es dann zusammen mit einer Sortierung verwendet
