--Ziel: Eine Liste von Produkten, die g�nstiger sind, als der Durchschnittspreis aller Produkte

CREATE VIEW DurchschnittspreisProdukte
AS
SELECT AVG(UnitPrice) AS Durchschnittspreis 
FROM Products

SELECT *
FROM Products
WHERE UnitPrice < 25


--AVG(UnitPrice) ist im WHERE nicht m�glich, da Aggregatsfunktionen nur im HAVING vorkommen k�nnen

SELECT * 
FROM Products
HAVING UnitPrice < AVG(UnitPrice)

--Das HAVING ist nicht m�glich, da es immer ein GROUP BY braucht

--Man m�sste also diesen einen Wert, irgendwoher anders bekommen, zB mit einer Unterabfrage
--Da Unterabfragen aber nicht sch�n sind und schwer zu lesen, sollten wir uns anderweitig helfen

--L�sung: Skalare Funktionen

--Skalare Funktionen sind Funktionen, die genau einen Wert zur�ckliefern (zB INT, VARCHAR(50), etc.)

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

--Syntax f�r Skalare Funktionen
--CREATE FUNCTION <name>(<parameterliste>)
--RETURNS <datentyp>
--AS
--BEGIN
	--DECLARE <name> <datentyp> --Das ist die Variable, die dann den Wert enth�lt, den wir zur�ckgeben m�chten

	--<query> --In der Abfrage muss der Wert in die Variable gespeichert werden

	--RETURN <name> --Hier geben wir den Wert zur�ck
--END

--Aufruf selbstdefinierter Skalarer Funktionen: immer mit dbo.<name>

SELECT *
FROM Products
WHERE UnitPrice < dbo.DurchschnittspreisProdukteFunktion()


--Anderes Beispiel: Funktion die uns sagt, ob ein Customer �berhaupt schon einmal bestellt hat oder nicht

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
--Wichtig: Wie in C#, ben�tigen wir, wenn im IF oder im ELSE Block mehr als ein Statement steht, "Klammern" (in C#: {}) - am SQL Server sind die "Klammern" BEGIN und END
