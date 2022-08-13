--Wir k�nnen die Summe ALLER Order-Details berechnen
SELECT SUM(Unitprice * Quantity)
FROM [Order Details]

--Oder die Summe der Order-Details EINER Order
SELECT OrderID, SUM(Unitprice * Quantity)
FROM [Order Details]
WHERE OrderID = 10250

--Aber wie die Summen oder Order-Details f�r JEDE Bestellung

SELECT 
	OrderId, 
	UnitPrice,
	SUM(UnitPrice * Quantity) as BestellSumme, 
	COUNT(ProductId) as AnzahlProdukte, 
	SUM(Quantity) as AnzahlSt�ck
FROM [Order Details]
--WHERE
GROUP BY OrderId

--M�chte man Daten innerhalb von "Kategorien"/"Gruppen" zusammenfassen, ben�tigt man das GROUP BY Schl�sselwort

--Syntax:
--SELECT ...
--FROM ...
--WHERE ...
--GROUP BY <spalte1, spalte2, ...>
--ORDER BY ...

--Wichtig: Wird GROUP BY in einer Abfrage verwendet, so d�rfen nur die Spalten nach denen gruppiert wird im SELECT stehen - andere Spalten m�ssen mit einer Aggregatsfunktion (COUNT, MIN, MAX, SUM, AVG, ...) zusammengefasst werden

--Aufgabe: Die Anzahl der Lieferanten (Suppliers) pro Land

select Country, COUNT(*) as AnzahlSupplier
from suppliers
group by Country

--M�chten wir nur die Lieferanten z�hlen, die eine Homepage haben:

select Country, COUNT(*) as AnzahlSupplier
from suppliers
where homepage is not null
group by Country

--WHERE schlie�t Datens�tze vor der Gruppierung aus!

select Country, City, COUNT(*) as AnzahlKunden
from customers
group by City, Country

--Eine Abfrage kann auch nach mehreren Spalten gruppiert werden
--Die Default-Sortierung ist dabei "umgekehrt" (dh. Das Ergebnis ist aufsteigend nach der Spalte sortiert, die im GroupBy als Letztes vorkommt)

select Country, City, COUNT(*) as AnzahlKunden
from customers
where fax is not null
group by City, Country