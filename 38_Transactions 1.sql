
--Beispiel wo eine Transaktion helfen w�rde

--Das erste Update wird ausgef�hrt, danach wird eine Berechnung gemacht die einen Fehler verursacht
--Wodurch das zweite Update nicht mehr ausgef�hrt wird - und daher werden die Daten inkonsistent

--Eine Transaktion kann mit BEGIN TRANSACTION gestartet werden
BEGIN TRANSACTION

UPDATE Production.Product
SET ListPrice = 50
WHERE ProductID = 707

UPDATE Person.Person
SET FirstName = 'Nicole'
WHERE BusinessEntityID = 707

ROLLBACK	--Rollback beendet eine Transaktion, aber nimmt alle �nderunge zur�ck	
COMMIT		--Commit beendet eine Transaktion und speichert die �nderungen final ab

--Transaktionen werden nat�rlich nicht einfach mit einem COMMIT oder ROLLBACK am Ende geschrieben - man m�chte ja nur COMMITen wenn alle Befehle erfolgreich waren, und nur ROLLBACKen, wenn es einen Fehler gegeben hat

SELECT * FROM Production.Product WHERE ProductID = 707
SELECT * FROM Person.Person WHERE BusinessEntityID = 707

SELECT @@TRANCOUNT

UPDATE Production.Product
SET ListPrice = 123
WHERE ProductID = 707

INSERT INTO Production.ProductListPriceHistory VALUES ('Hallo')

UPDATE Production.ProductListPriceHistory
SET EndDate = GETDATE(), ModifiedDate = GETDATE()
WHERE ProductID = 707 AND EndDate IS NULL



SELECT * FROM Production.ProductListPriceHistory WHERE ProductID = 707
