--Um "sinnvolle" Transactions zu schreiben, m�ssen wir �berpr�fen ob es zu einem Fehler gekommen ist oder nicht.

--Daf�r verwenden wir ein �hnliches Konzept wie in C#, n�mlich TRY und CATCH

BEGIN TRY
BEGIN TRANSACTION

	UPDATE Production.Product
	SET ListPrice = 999
	WHERE ProductID = 707
	PRINT('Preis geaendert')

	INSERT INTO Production.ProductListPriceHistory VALUES (-5,GETDATE(),GETDATE(),123,DEFAULT)
	PRINT('Wert eingefuegt')
	
COMMIT
END TRY
BEGIN CATCH
	PRINT('Es gab einen Fehler')
--ROLLBACK
END CATCH

SELECT @@TRANCOUNT
SELECT * FROM Production.Product WHERE ProductID = 707