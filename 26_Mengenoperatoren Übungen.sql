--Zu Lösen mit den Set-Operatoren

--Tabelle: Orders

--Eine Liste aller Länder, in die sowohl 1997 als auch 1998 verschifft wurde (ShipDate)

SELECT ShipCountry
FROM Orders
WHERE YEAR(ShippedDate) = 1997
INTERSECT
SELECT ShipCountry
FROM Orders
WHERE YEAR(ShippedDate) = 1998

--Eine Liste aller Länder, in die 1996 verschifft wurde, aber nicht in 1998 (ShipDate)

SELECT ShipCountry
FROM Orders
WHERE YEAR(ShippedDate) = 1996
EXCEPT
SELECT ShipCountry
FROM Orders
WHERE YEAR(ShippedDate) = 1998



