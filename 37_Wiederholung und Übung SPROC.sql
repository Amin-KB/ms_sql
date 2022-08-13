

--Prozedur um den Listenpreis eines Produkts ab heute zu ändern
-- 1) Listenpreis im Produkt anpassen
-- 2) Abändern des letzten Eintrags in der ListPriceHistory (Enddate setzen)
-- 3) Hinzufügen eines neuen Eintrags in die ListPriceHistory
	--(Startdatum heute, Enddatum null, Listenpreis = neuer Preis, Modifieddate = default)

CREATE PROCEDURE Production.UpdateProductListPrice
	@productId int,
	@newListPrice money
AS
BEGIN
	--Prüfen ob es die ProduktID überhaupt gibt
	IF NOT EXISTS (SELECT * FROM Production.Product WHERE ProductID = @productId)
	BEGIN
		PRINT('Produkt nicht gefunden')
		RETURN
	END

	--1: Preis des Produkts selbst aktualisieren
	UPDATE Production.Product
	SET ListPrice = @newListPrice
	WHERE ProductID = @productId

	DECLARE @currentDateTime datetime
	SET @currentDateTime = GETDATE()

	--2: Aktuellen Eintrag in ListPrice History aktualisieren
	UPDATE Production.ProductListPriceHistory
	SET EndDate = @currentDateTime, ModifiedDate = @currentDateTime
	WHERE ProductID = @productId AND EndDate IS NULL

	--3: Neuer Eintrag in ListPrice History mit aktuellem Preis hinzufügen
	INSERT INTO Production.ProductListPriceHistory
	VALUES(@productId, @currentDateTime, NULL, @newListPrice, DEFAULT)

	PRINT('Preis aktualisiert')
END
GO

SELECT * FROM Production.Product WHERE ProductID = 707
SELECT * FROM Production.ProductListPriceHistory WHERE ProductID = 707
GO

EXEC Production.UpdateProductListPrice 707, 35.99
GO

--Prozedur um die Kosten eines Produkts ab heute zu ändern
-- 1) Kosten im Produkt anpassen (StandardCost)
-- 2) Abändern des letzten Eintrags in der CostHistory (Enddate setzen)
-- 3) Hinzufügen eines neuen Eintrags in die CostHistory
	--(Startdatum heute, Enddatum null, Listenpreis = neuer Preis, Modifieddate = default)

CREATE PROCEDURE Production.UpdateProductCost
	@productId int,
	@newCost money
AS
BEGIN
	--Prüfen ob es die ProduktID überhaupt gibt
	IF NOT EXISTS (SELECT * FROM Production.Product WHERE ProductID = @productId)
	BEGIN
		PRINT('Produkt nicht gefunden')
		RETURN
	END

	--1: Preis des Produkts selbst aktualisieren
	UPDATE Production.Product
	SET StandardCost = @newCost
	WHERE ProductID = @productId

	DECLARE @currentDateTime datetime
	SET @currentDateTime = GETDATE()

	--2: Aktuellen Eintrag in Cost History aktualisieren
	UPDATE Production.ProductCostHistory
	SET EndDate = @currentDateTime, ModifiedDate = @currentDateTime
	WHERE ProductID = @productId AND EndDate IS NULL

	--3: Neuer Eintrag in Cost History mit aktuellem Preis hinzufügen
	INSERT INTO Production.ProductCostHistory
	VALUES(@productId, @currentDateTime, NULL, @newCost, DEFAULT)

	PRINT('Kosten aktualisiert')
END
GO

SELECT * FROM Production.Product WHERE ProductID = 707
SELECT * FROM Production.ProductCostHistory WHERE ProductID = 707
GO

EXEC Production.UpdateProductCost 707, 13.751
GO

--Eine Prozedure um sowohl Kosten als auch Preis eines Produkts um x% zu erhöhen
--Name: IncreaseCostAndPriceByPercent

CREATE PROCEDURE Production.IncreaseCostAndPriceByPercent
	@productId int,
	@percentIncrease int
AS
BEGIN
	DECLARE @cost money
	DECLARE @price money

	--Abrufen der aktuellen Preise/Kosten
	SELECT @price = ListPrice, @cost = StandardCost
	FROM Production.Product 
	WHERE ProductID = @productId

	--Erhöhen der Preise/Kosten
	SET @cost = @cost * (1 + @percentIncrease / 100.0)
	SET @price = @price * (1 + @percentIncrease / 100.0)

	--Aufrufen der entsprechenden Prozeduren
	EXEC Production.UpdateProductCost @productId, @cost
	EXEC Production.UpdateProductListPrice @productId, @price
END