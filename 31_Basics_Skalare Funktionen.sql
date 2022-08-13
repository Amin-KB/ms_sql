--Ziel: Eine Liste von Produkten, die günstiger sind, als der Durchschnittspreis aller Produkte

CREATE VIEW DurchschnittspreisProdukte
AS
SELECT AVG(UnitPrice) AS Durchschnittspreis 
FROM Products

SELECT *
FROM Products
WHERE UnitPrice < 25


--AVG(UnitPrice) ist im WHERE nicht möglich, da Aggregatsfunktionen nur im HAVING vorkommen können

SELECT * 
FROM Products
HAVING UnitPrice < AVG(UnitPrice)

--Das HAVING ist nicht möglich, da es immer ein GROUP BY braucht

--Man müsste also diesen einen Wert, irgendwoher anders bekommen, zB mit einer Unterabfrage
--Da Unterabfragen aber nicht schön sind und schwer zu lesen, sollten wir uns anderweitig helfen

--Lösung: Skalare Funktionen

--Skalare Funktionen sind Funktionen, die genau einen Wert zurückliefern (zB INT, VARCHAR(50), etc.)

CREATE FUNCTION DurchschnittspreisProdukteFunktion()
RETURNS MONEY
AS
BEGIN --{
	DECLARE @wert MONEY

	SELECT @wert = AVG(UnitPrice)
	FROM Products

	RETURN @wert
END --}

SELECT dbo.DurchschnittspreisProdukteFunktion()

--Syntax für Skalare Funktionen
--CREATE FUNCTION <name>(<parameterliste>)
--RETURNS <datentyp>
--AS
--BEGIN
	--DECLARE <name> <datentyp> --Das ist die Variable, die dann den Wert enthält, den wir zurückgeben möchten

	--<query> --In der Abfrage muss der Wert in die Variable gespeichert werden

	--RETURN <name> --Hier geben wir den Wert zurück
--END

--Aufruf selbstdefinierter Skalarer Funktionen: immer mit dbo.<name>

SELECT *
FROM Products
WHERE UnitPrice < dbo.DurchschnittspreisProdukteFunktion()


--Anderes Beispiel: Funktion die uns sagt, ob ein Customer überhaupt schon einmal bestellt hat oder nicht

--Welche Infos geben wir hinein? INT (CustomerID)
--Welche Info geben wir heraus?  BIT (bool'scher Wert; hat bestellt (true) oder nicht (false))
--Woher kommt die Info? Orders

CREATE OR ALTER FUNCTION HatKundeBestellt(@kundeId VARCHAR(50))
RETURNS BIT
AS
BEGIN
	DECLARE @wert BIT

	DECLARE @anzahlBestellungen INT
	--abfrage
	SELECT @anzahlBestellungen = COUNT(*) FROM Orders WHERE CustomerID = @kundeId

	IF @anzahlBestellungen > 0
		SET @wert = 'true'
	ELSE
		SET @wert = 'false'

	RETURN @wert
END

SELECT dbo.HatKundeBestellt('qwe')

--Wert in eine Variable Speichern: Entweder mit SET <name> = <wert>
--Oder in der SELECT Liste: SELECT <variable> = <spalte> FROM ...

--Verzweigungen: IF/ELSE
--Wichtig: Wie in C#, benötigen wir, wenn im IF oder im ELSE Block mehr als ein Statement steht, "Klammern" (in C#: {}) - am SQL Server sind die "Klammern" BEGIN und END
