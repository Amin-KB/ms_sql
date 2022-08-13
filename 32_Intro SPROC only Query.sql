SELECT CompanyName, Phone, 'SUP' AS CompanyType
FROM Suppliers
UNION
SELECT CompanyName, Phone, 'CUS'
FROM Customers
UNION
SELECT CompanyName, Phone, 'SHI'
FROM Shippers

CREATE VIEW TelefonbuchView
AS
(
SELECT CompanyName, Phone, 'SUP' AS CompanyType
FROM Suppliers
UNION
SELECT CompanyName, Phone, 'CUS'
FROM Customers
UNION
SELECT CompanyName, Phone, 'SHI'
FROM Shippers
)
GO

CREATE FUNCTION TelefonbuchFunc()
RETURNS TABLE
AS RETURN
	SELECT CompanyName, Phone, 'SUP' AS CompanyType
	FROM Suppliers
	UNION
	SELECT CompanyName, Phone, 'CUS'
	FROM Customers
	UNION
	SELECT CompanyName, Phone, 'SHI'
	FROM Shippers
GO

--Syntax zum Erstellen einer Prozedur
--CREATE PROCEDURE <name> <parameter> 
--AS
--<code>

--Ganz wichtig: Die Parameter einer SPROC werden OHNE einer Klammer angegeben

--Aufrufen einer Stored Procedure: EXEC <name>

CREATE PROCEDURE TelefonbuchProc
AS
	SELECT CompanyName, Phone, 'SUP' AS CompanyType
	FROM Suppliers
	UNION
	SELECT CompanyName, Phone, 'CUS'
	FROM Customers
	UNION
	SELECT CompanyName, Phone, 'SHI'
	FROM Shippers
GO

SELECT * FROM TelefonBuchView
SELECT * FROM TelefonBuchFunc()

--Wichtig: Wenn es wirklich nur darum geht, Daten abzurufen, dann sollte man eher eine View oder eine Funktion verwenden!
EXEC TelefonbuchProc
GO

--Syntax für SPROCs mit Parametern

--Übung: Suchen einer Firma mittels einem String

CREATE OR ALTER PROCEDURE TelefonbuchSuche @name varchar(50), @companyType char(3)
AS
	--Innerhalb einer Prozedure kann man sich natürlich auf Views oder Funktionen beziehen
	--(genauso wie man sich in einer Funktion auf andere Funktionen beziehen konnte)
	SELECT * FROM TelefonBuchFunc()
	WHERE CompanyName LIKE '%' + @name + '%' AND CompanyType = @companyType
GO

EXEC TelefonbuchSuche 'ant', 'CUS'
GO