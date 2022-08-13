--Eine View, die sämtliche Informationen aus den Tabellen Region, Territories, Employeeterritories, Employees vereint

CREATE OR ALTER VIEW EmployeeDetails
AS
SELECT 
	e.*, 
	et.TerritoryID, 
	t.TerritoryDescription, 
	t.RegionID, 
	r.RegionDescription
FROM 
	EmployeeTerritories et
	JOIN Territories t ON t.TerritoryID = et.TerritoryID
	JOIN Region r ON r.RegionID = t.RegionID
	JOIN Employees e ON e.EmployeeID = et.EmployeeID
GO

SELECT * FROM EmployeeDetails

-- 

--Saledetails nur von einem Jahr
SELECT * FROM SaleDetails
WHERE YEAR(OrderDate) = 1996
GO
--Wie könnten wir die Abfrage so verpacken, dass wir das Jahr beliebig wählen können?

--
CREATE VIEW temp AS 
SELECT * FROM SaleDetails
WHERE YEAR(OrderDate) = 1996
--Das würde nicht funktionieren, da diese View für IMMER auf das Jahr 1996 beschränkt ist

--Was wir bräuchten, wären Views, in denen man Variablen festlegen kann
CREATE VIEW temp AS 
SELECT * FROM SaleDetails
WHERE YEAR(OrderDate) = userDefiniertesJahr

--Was wir brauchen sind: Funktionen
--Funktionen sind parametrisierte Views

--Funktionen sind der Einstieg in die DatenbankPROGRAMMIERUNG
