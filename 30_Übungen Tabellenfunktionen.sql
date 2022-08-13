--Übung 1: Eine Funktion, die Produkte sucht, die günstiger als ein bestimmter Preis sind

CREATE FUNCTION ProdukteUnterPreis(@maxPreis INT)
RETURNS TABLE
AS
RETURN
	SELECT * FROM Products
	WHERE UnitPrice < @maxPreis
GO

SELECT * FROM ProdukteUnterPreis(50)

--Übung 2: Eine View, die alle Daten aus einer Bestellung mit den Employees und Customers verknüpft
CREATE VIEW BestellView
AS
SELECT os.*, c.CompanyName, c.ContactName, c.ContactTitle, e.FirstName, e.LastName
--Wichtig: SELECT * ist bei mehreren Tabellen in Views und Funktionen nicht möglich, weil sich Spaltennamen nicht wiederholen dürfen
FROM Orders os
JOIN Employees e ON e.EmployeeID = os.EmployeeID
JOIN Customers c ON c.CustomerID = os.CustomerID

SELECT EmployeeId FROM BestellView

--Übung 3: Eine Funktion, die Kunden (Firmenname) in einem bestimmten Land (Country) sucht

CREATE FUNCTION Kundensuche(@land nvarchar(50), @companyname nvarchar(50))
RETURNS TABLE
AS
RETURN
	SELECT * FROM Customers
	WHERE Country = @land AND CompanyName LIKE '%' + @companyname + '%'

SELECT * FROM Kundensuche('USA','food')