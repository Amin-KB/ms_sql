
--Einem Produkt eine neue Kategorie zuweisen; vom Produkt liegt die ID vor, von der Kategorie, der Name
--zB Produkt 15 soll der Kategorie 'Condiments' zugewiesen werden

CREATE OR ALTER PROCEDURE ChangeProductCategory @productId int, @categoryName nvarchar(15)
AS
BEGIN
	--1: Id vom Kategorienamen abrufen

	DECLARE @categoryId int

	SELECT @categoryId = CategoryId
	FROM Categories
	WHERE CategoryName = @categoryName

	--2: Dem Produkt die Kategorie zuweisen

	UPDATE Products
	SET CategoryId = @categoryId
	WHERE ProductId = @productId

END
GO

SELECT * FROM Products WHERE ProductId = 5
SELECT * FROM Categories

EXEC ChangeProductCategory 5, 'Condiments'
GO

--Variante: Wenn der Kategoriename ungültig ist, soll keine Zuweisung erfolgen

CREATE OR ALTER PROCEDURE ChangeProductCategorySafe @productId int, @categoryName nvarchar(15)
AS
BEGIN
	--1: Id vom Kategorienamen abrufen

	DECLARE @categoryId int

	SELECT @categoryId = CategoryId
	FROM Categories
	WHERE CategoryName = @categoryName

	--2: Dem Produkt die Kategorie zuweisen
	IF @categoryId IS NOT NULL
	BEGIN
		UPDATE Products
		SET CategoryId = @categoryId
		WHERE ProductId = @productId
	END
	ELSE
	BEGIN
		PRINT 'Kategorie nicht gefunden'
	END
END
GO

SELECT * FROM Products WHERE ProductId = 5
SELECT * FROM Categories

INSERT INTO Shippers(ShipperID) VALUES('hallo')

EXEC ChangeProductCategorySafe 5, 'Candy and Sweets'
GO

--Variante: Wenn der Kategoriename ungültig ist, soll eine neue Kategorie mit dem Namen angelegt werden und das Produkt dieser neuen Kategorie zugewiesen werden

CREATE OR ALTER PROCEDURE ChangeProductCategoryWithNew @productId int, @categoryName nvarchar(15)
AS
BEGIN
	--1: Id vom Kategorienamen abrufen

	DECLARE @categoryId int

	SELECT @categoryId = CategoryId
	FROM Categories
	WHERE CategoryName = @categoryName

	--2: Dem Produkt die Kategorie zuweisen
	IF @categoryId IS NOT NULL --Wenns die Kategorie gibt
	BEGIN --Zuweisen
		UPDATE Products
		SET CategoryId = @categoryId
		WHERE ProductId = @productId
	END
	ELSE --Wenn nicht
	BEGIN
		--3: Kategorie anlegen
		INSERT INTO Categories(CategoryName) VALUES (@categoryName)
		--4: Dem Produkt die neue Kategorie zuweisen
		
		--Woher bekommen wir den Primär/Fremdschlüssel?
		--Bei Einträgen, bei denen der PK über eine identity definiert ist, gibt es eine spezielle Funktion, die uns die zuletzt eingefügte Identity zurückliefert
		--Diese Funktion ist SCOPE_IDENTITY() - sie liefert die zuletzt eingefügte Identity aus dem aktuellen Scope (Scope = gesamte Prozedur, gesamte Funktion, ...)
		DECLARE @newCategoryId int

		SET @newCategoryId = SCOPE_IDENTITY()
		
		UPDATE Products
		SET CategoryId = @newCategoryId
		WHERE ProductId = @productId
	END
END
GO

SELECT * FROM Products WHERE ProductId = 5
SELECT * FROM Categories

EXEC ChangeProductCategoryWithNew 5, 'Candy and Sweets'
GO
