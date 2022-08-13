--�bung: Wie oft wurden Bestellungen in die jeweiligen L�nder verschifft?

SELECT ShipCountry, COUNT(*) as AnzahlBestellungen
FROM Orders
GROUP BY ShipCountry

--�bung: Wie viel Fracht wurde insgesamt mit jedem Shipper (ShipVia) verschifft?

SELECT ShipVia, SUM(Freight) as GesamtFracht
FROM Orders
GROUP BY ShipVia

--�bung: Wie viel Fracht wurde 1996 (ShippedDate) in jede Stadt verschifft?

SELECT ShipCity, SUM(Freight) as GesamtFracht
FROM Orders
WHERE YEAR(ShippedDate) = 1996
GROUP BY ShipCity


--�bung: Wer sind die Mitarbeiter (EmployeeID), die mindestens 45 Bestellungen �ber M�glichkeit 2 verschifft (ShipVia) haben?

SELECT EmployeeId, COUNT(*)
FROM Orders
WHERE ShipVia = 2
GROUP BY EmployeeID HAVING COUNT(*) >= 45