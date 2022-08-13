SELECT * FROM Products
SELECT * FROM Categories

SELECT * 
FROM 
	Products p 
	JOIN Categories c ON c.CategoryID = p.CategoryId
------
SELECT * FROM Customers, Shippers --Das ist ein Cross Join! (Jeder Datensatz wird mit jedem anderen Verknüpft)

--Verknüpfen von ABFRAGE-ERGEBNISSEN

SELECT CompanyName, Phone FROM Customers
SELECT CompanyName, Phone FROM Shippers
SELECT CompanyName, Phone FROM Suppliers

SELECT CompanyName, Phone FROM Customers
UNION
SELECT CompanyName, Phone FROM Shippers
UNION
SELECT CompanyName, Phone FROM Suppliers

--Technisch gesehenn, benötigt Union nur die selbe Anzahl der Spalten in allen Abfragen, und pro Spalte kompatible Datentypen

--Selbe Anzahl von Spalten, selbe Datentypen --> Funktioniert (auch wenn das Ergebnis nicht Sinnvoll ist)
SELECT FirstName, BirthDate FROM Employees
UNION
SELECT ShipCountry, OrderDate FROM Orders

--Unterschiedliche Anzahl von Spalten --> Fehler
SELECT CompanyName, Phone, CustomerID FROM Customers
UNION
SELECT CompanyName, Phone FROM Shippers

--FirstName und Freight sind nicht kompatibel (nvarchar und money) --> Fehler
SELECT FirstName, BirthDate, LastName FROM Employees
UNION
SELECT Freight, OrderDate, ShipCity FROM Orders

SELECT DISTINCT ShipCountry FROM Orders


-----UNION hat ein automatisches Distinct eingebaut - kommt ein Datensatz in mehreren Abfrageergebnissen vor, so elimniert UNION die Wiederholung

SELECT CompanyName, Phone FROM Customers
UNION
SELECT CompanyName, Phone FROM Shippers

--Möchte man das nicht, so muss man UNION ALL einsetzen

SELECT CompanyName, Phone FROM Customers
UNION ALL
SELECT CompanyName, Phone FROM Shippers