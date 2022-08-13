--Übung: Wie oft wurden Bestellungen in die jeweiligen Länder verschifft?

SELECT ShipCountry, COUNT(*) as AnzahlBestellungen
FROM Orders
GROUP BY ShipCountry

--Übung: Wie viel Fracht wurde insgesamt mit jedem Shipper (ShipVia) verschifft?

SELECT ShipVia, SUM(Freight) as GesamtFracht
FROM Orders
GROUP BY ShipVia

--Übung: Wie viel Fracht wurde 1996 (ShippedDate) in jede Stadt verschifft?

SELECT ShipCity, SUM(Freight) as GesamtFracht
FROM Orders
WHERE YEAR(ShippedDate) = 1996
GROUP BY ShipCity


--Übung: Wer sind die Mitarbeiter (EmployeeID), die mindestens 45 Bestellungen über Möglichkeit 2 verschifft (ShipVia) haben?

SELECT EmployeeId, COUNT(*)
FROM Orders
WHERE ShipVia = 2
GROUP BY EmployeeID HAVING COUNT(*) >= 45