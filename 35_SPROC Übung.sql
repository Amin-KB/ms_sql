--Logik zum Nachbestellen eines Produkts
--Die Nachbestellung soll nur erfolgen, wenn das Produkt weniger auf Lager hat als das ReorderLevel vorgibt und noch keine Produkte nachbestellt wurden
--Nachbestellen bedeutet es wird die Nachricht "Produkt wurde Nachbestellt" ausgegeben, und die Anzahl der Produkte die nachbestellt werden, werden um 10 erh�ht (NICHT der Lagerstand)
--Wird versucht ein Produkt nachzubestellen dass es nicht gibt, soll die Meldung "Produkt nicht gefunden" ausgegeben werden

--Aufgabe:

--A) Sich eine passende LOGIK (ohne SQL �berlegen)

--Probierern das Produkt abzurufen (zB ID) ob es existiert
--Wenn nein -> PRINT 'Produkt gibts nicht'
--Wenn ja -> Werte f�r die n�chste �berpr�fung abrufen
	--UnitsOnOrder
	--ReorderLevel
	--UnitsInStock

	--�berpr�fen ob UnitsInStock < ReorderLevel UND UnitsOnOrder = 0
	--Wenn g�ltig:
		--PRINT 'Nachbestellt'
		--UnitsOnOrder um 10 erh�hen
	--Wenn ung�ltig
		--nichts machen

--B) Diese Logik in eine Prozedur �bersetzen

CREATE OR ALTER PROCEDURE ReorderProduct @productId INT
AS
BEGIN
	DECLARE @prodTestId INT
	SELECT @prodTestId = ProductID FROM Products WHERE ProductID = @productID

	IF @prodTestId IS NULL
	BEGIN
		PRINT 'Produkt gibt es nicht'
		RETURN
	END

	DECLARE @unitsOnOrder INT
	DECLARE @reorderLevel INT
	DECLARE @unitsInStock INT

	SELECT @unitsOnOrder = UnitsOnOrder, @reorderLevel = ReorderLevel, @unitsInStock = UnitsInStock
	FROM Products WHERE ProductID = @productId

	IF @unitsInStock < @reorderLevel AND @unitsOnOrder = 0
	BEGIN
		PRINT 'Produkt wurde nachbestellt'
		UPDATE Products
		SET UnitsOnOrder = UnitsOnOrder + 10
		WHERE ProductID = @productId
	END
	ELSE
		PRINT 'Produkt noch ausreichend vorhanden oder schon nachbestellt'
END