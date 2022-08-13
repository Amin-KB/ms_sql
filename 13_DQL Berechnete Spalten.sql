
SELECT ProductID, ProductName, UnitPrice --Anstatt dass wir nur Informationen ausw�hlen die direkt in der Tabelle stehen
FROM Products

--K�nnen wir einfach neue Spalten "erfinden"

SELECT ProductID, ProductName, UnitPrice, 'hallo'
FROM Products

--Da diese neuen Spalten keinen Namen haben (und es immer gut ist, wenn sie einen haben), sollten wir einen vergeben

SELECT ProductID, ProductName, UnitPrice, 'hallo' AS Irgendwas
FROM Products

--Damit k�nnen wir zum Beispiel in unsere Preisliste das aktuelle Datum schreiben, an dem die Preise abgerufen wurden
SELECT ProductID, ProductName, UnitPrice, GETDATE() AS PriceOnDate
FROM Products

--Was wir auch machen k�nnen ist, mit Werten aus der Tabelle neue Werte zu berechnen
SELECT 
	*, 
	UnitPrice * Quantity AS LinePrice, 
	UnitPrice * Quantity * (1 - Discount) AS DiscountedLinePrice --Leider ist es hier nicht m�glich, auf neu berechnete Werte in einem anderen Berechneten Wert zuzugreifen (also die unten auskommentierte Zeile f�hrt zu einem Fehler)
	--LinePrice * (1 - Discount) AS DiscountedLinePrice
FROM [Order Details] 
WHERE OrderID = 10254
ORDER BY DiscountedLinePrice DESC --Im Order By k�nnen wir diese neuen Namen allerdings Problemlos verwenden 


SELECT EmployeeID, FirstName, LastName, BirthDate FROM Employees

SELECT EmployeeID, LastName + ', ' + FirstName AS Name, BirthDate FROM Employees