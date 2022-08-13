--DatenbankPROGRAMMIERUNG

--SQL selbst ist eine Abfragesprache (keine Variablen, keine Kontrollstrukturen)
--F�r Funktionen und Prozeduren, brauchen wir aber zumindest Variablen

--Die Programmiersprache am SQL Server nennt sich: T-SQL (Transact SQL)

--Funktionen teilen sich in zwei Gruppen 
--Tabellen-Funktionen (Parametrisierte Views): Geben eine Tabelle zur�ck
--Skalare Funktionen: Geben einen einzelnen Wert zur�ck (zB einen int, einen varchar, eine DateTime)

--Table-valued Functions (R�ckgabewert = Tabelle)

--Beispiel Methode C# public static void MeineMethode(int x1, string s1)
--In C# haben Methoden folgende wichtige Eigenschaften: Namen (MeineMethode), Parameterliste (int x1, string s1), R�ckgabewert (void); genau diese drei Eigenschaften haben auch Funktionen am SQL Server

--Ziel: Die untenstehende Abfrage so zu verpacken, sodass man das Jahr beim Abrufen frei w�hlen kann (was mit einer View nicht m�glich ist)

--CREATE VIEW temp AS 
--SELECT * FROM SaleDetails
--WHERE YEAR(OrderDate) = 1996

--Syntax f�r Tabellen-funktionen:
--CREATE FUNCTION <name>(<parameterliste>)
--RETURNS TABLE
--AS
--RETURN
--<abfrage>

CREATE OR ALTER FUNCTION Verk�ufeImJahr(@jahr INT) 
RETURNS TABLE 
AS 
RETURN
	SELECT * FROM SaleDetails
	WHERE YEAR(OrderDate) = @jahr
GO

SELECT * FROM Verk�ufeImJahr(1997) v
JOIN Customers c ON c.CustomerID = v.CustomerID
WHERE ShipCountry = 'Austria'
GO

--�bung: Eine Funktion, die alle Produkte findet, in deren Namen ein bestimmter Begriff vorkommt

--SELECT * FROM Products
--WHERE ProductName LIKE '%new%'


CREATE OR ALTER FUNCTION Produktsuche(@suchbegriff nvarchar(40))
RETURNS TABLE
AS
RETURN
	SELECT * FROM Products
	WHERE ProductName LIKE '%' + @suchbegriff + '%'
GO

SELECT * FROM Produktsuche('new')

--�bung: Eine Funktion, die alle Bestellungen auflistet, die von einem Bestimmten Mitarbeiter, in ein bestimmtes Land verschickt wurden

--Alle Bestellungen die Mitarbeiter 6 ins Land USA verschickt hat

CREATE OR ALTER FUNCTION BestellungenVonMitarbeiterInLand(@mitarbeiterId INT, @land nvarchar(50))
RETURNS TABLE
AS
RETURN
SELECT * FROM Orders
WHERE EmployeeID = @mitarbeiterId AND ShipCountry = @land

SELECT * FROM BestellungenVonMitarbeiterInLand(1,'Germany')