--Oft sind wir nicht nur an den Rohdaten interessiert, sondern an "Statistiken"

--Zum Beispiel: Was war die schwerste Fracht einer Bestellung?

SELECT TOP(1) Freight 
FROM Orders
ORDER BY Freight DESC
 
--Statistiken kann man mit Aggregatsfunktionen berechnen, wie zB MAX(spalte) oder AVG(spalte)
SELECT 
	MIN(Freight) AS MinFreight,
	AVG(Freight) AS AverageFreight,
	MAX(Freight) AS MaxFreight
FROM Orders

--Um Einträge in einer Tabelle zu zählen gibt es COUNT(*)
SELECT COUNT(*) AS OrderCount 
FROM Orders

--Um Werte aufzuaddieren gibt es SUM(spalte)
SELECT 
	*, 
	UnitPrice * Quantity AS LinePrice, 
	UnitPrice * Quantity * (1 - Discount) AS DiscountedLinePrice--,
	--SUM(UnitPrice * Quantity * (1 - Discount)) AS TotalOrderPrice --Aber ACHTUNG! Wir können (mit einer Ausnahme) in einem SELECT Statement Aggregatsfunktionen nicht mit Spalten mischen die nicht in einer Aggergatsfunktion stehen! Entweder nur Aggregatsfunktionen, oder keine
FROM [Order Details] 
WHERE OrderID = 10254
ORDER BY DiscountedLinePrice DESC

--Daher lieber in eine seperate Abfrage
SELECT 
	SUM(UnitPrice * Quantity * (1 - Discount)) AS TotalOrderPrice
FROM [Order Details] 
WHERE OrderID = 10254


SELECT *, UnitPrice * Quantity * (1 - Discount) AS DiscountedLinePrice
FROM [Order Details]