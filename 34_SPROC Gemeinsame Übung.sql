--Auf der Website können einem Kunden demografische Merkmale zugewiesen werden
--Entweder man wählt eines aus das schon existiert, oder kann auf die schnelle ein neues anlegen

--Die Prozedur nimmt die CustomerID entgegen, und weist dem Kunden das demographische Merkmal zu - wenn es nicht existiert, dann soll es angelegt werden

-- 1) Prüfen ob CustomerID gültig
		--Wenn nein: Fehler ausgeben (PRINT)
		--Wenn ja: weiter
-- 2) Prüfen ob es das demographische Merkmal gibt (indem die Id überprüft wird)
		--Wenn nein: 
			-- 2a) Merkmal eintragen (neuer Eintrag in CustomerDemographics)
			-- 2b) ID des neuen Merkmals abrufen (SCOPE_IDENTITY)
			-- 2c) zuweisen (neuer Eintrag in CustomerCustomerDemo)
		--Wenn ja: weiter
-- 3) Prüfen ob das Merkmal schon zugewiesen wurde
		--Wenn ja: nichts machen
		--Wenn nein: zuweisen (neuer Eintrag in CustomerCustomerDemo)

CREATE PROCEDURE AssignDemographicToCustomer @customerId nchar(5), @demographic nvarchar(100)
AS
BEGIN
	-- 1) Prüfen ob CustomerID gültig
	DECLARE @count INT
	SELECT @count = COUNT(*) FROM Customers WHERE CustomerID = @customerId

	--Wenn nein: Fehler ausgeben (PRINT)
	IF @count <> 1
	BEGIN
		PRINT 'Kunde existiert nicht'
		RETURN
	END
	--Wenn ja: weiter

	-- 2) Prüfen ob es das demographische Merkmal gibt (indem die Id überprüft wird)
	DECLARE @demographicId INT
	SELECT @demographicId = Id FROM CustomerDemo WHERE CustomerDemo = @demographic
	
	--Wenn nein: 
	IF @demographicId IS NULL
		BEGIN
			-- 2a) Merkmal eintragen (neuer Eintrag in CustomerDemographics)
			INSERT INTO CustomerDemo(CustomerDemo) VALUES (@demographic)

			-- 2b) ID des neuen Merkmals abrufen (SCOPE_IDENTITY)
			DECLARE @newDemoId INT
			SET @newDemoId = SCOPE_IDENTITY()

			-- 2c) zuweisen (neuer Eintrag in CustomerCustomerDemo)
			INSERT INTO CustomerCustomerDemo(CustomerId, CustomerDemoId) VALUES(@customerId, @newDemoId)
		END
	ELSE
		BEGIN
		--Wenn ja: weiter
		-- 3) Prüfen ob das Merkmal schon zugewiesen wurde
		DECLARE @demoCount INT
		SELECT @demoCount = COUNT(*) FROM CustomerCustomerDemo WHERE
			@customerId = CustomerId AND @demographicId = CustomerDemoId

		IF @demoCount = 1 --Wenn ja: nichts machen
			PRINT 'Eintrag schon vorhanden'
		ELSE --Wenn nein: zuweisen (neuer Eintrag in CustomerCustomerDemo)
			INSERT INTO CustomerCustomerDemo(CustomerId, CustomerDemoId) VALUES(@customerId, @demographicId)
		END
END

SELECT * FROM Customers
SELECT * FROM CustomerDemo
SELECT * FROM CustomerCustomerDemo


EXEC AssignDemographicToCustomer 'ALFKI', 'EPU' --(gültiger Kunde, neue Demo)									Neue Einträge in beiden Demo Tabellen
EXEC AssignDemographicToCustomer 'ALFKI', 'EPU' --(gültiger Kunde, gültige Demo, Demo schon zugewiesen)			Gar nichts sollte passieren
EXEC AssignDemographicToCustomer 'xxxxx', 'EPU' --(ungültiger Kunde)											Fehler
EXEC AssignDemographicToCustomer 'BERGS', 'EPU' --(gültiger Kunde, gültige Demo, Demo noch nicht zugewiesen)	Nur Eintrag in zwischentabelle
