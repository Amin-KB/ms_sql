--VIEWS

--Eine View ist eine gespeicherte SELECT Abfrage

--Eine View ist im Endeffekt ein Name f�r eine SQL Abfrage

--Eine View wird mit 
--	CREATE VIEW <name> AS <query> 
--erstellt und kann danach wie eine Tabelle in der FROM Klausel eingebaut werden

CREATE VIEW ProduktInfo 
AS 
SELECT
	ProductID,
	ProductName,
	QuantityPerUnit,
	UnitPrice,
	UnitsInStock,
	CategoryName
FROM Products p
	JOIN Categories c ON c.CategoryID = p.CategoryID
--ORDER BY CategoryName
GO

SELECT * FROM ProduktInfo

--Eine View kann im FROM anstelle einer Tabelle verwendet werden

SELECT * FROM ProduktInfo 
WHERE UnitPrice < 20

SELECT AVG(UnitPrice), CategoryName 
FROM ProduktInfo 
GROUP BY CategoryName

--Views werden haupts�chlich dazu verwendet, Daten abzufragen - theoretisch kann man sie auch verwenden, um Daten einzuf�gen - dabei muss aber vieles ber�cksichtigt werden (speziell wenn die View mehr als eine Tabelle beinh�lt)



-------

--Jahresumsatz 1996

SELECT SUM(od.UnitPrice*(1-Discount)*Quantity)
FROM [Order Details] od
JOIN Orders os ON os.OrderID = od.OrderID
WHERE YEAR(os.OrderDate) = 1996

--Jahresumsatz pro Jahr

SELECT SUM(od.UnitPrice*(1-Discount)*Quantity), YEAR(os.OrderDate)
FROM [Order Details] od
JOIN Orders os ON os.OrderID = od.OrderID
GROUP BY YEAR(os.OrderDate)

--Umsatz pro Kategorie

SELECT SUM(od.UnitPrice*(1-Discount)*Quantity), c.CategoryName
FROM [Order Details] od
JOIN Orders os ON os.OrderID = od.OrderID
JOIN Products p ON p.ProductID = od.ProductID
JOIN Categories c ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryName

CREATE OR ALTER VIEW SaleDetails
AS
SELECT os.*, 
	od.ProductID, od.UnitPrice*(1-Discount)*Quantity AS Zeilenpreis
FROM [Order Details] od
JOIN Orders os ON os.OrderID = od.OrderID

SELECT * FROM SaleDetails

--Selbe Abfragen wie oben, nur mit der View - sie werden k�rzer und lesbarer
--Plus, sollten wir uns wo Verrechnet haben, m�ssen wir den Fehler nur 1x ausbessern! (N�mlich in der View)

--Jahresumsatz 1996

SELECT SUM(Zeilenpreis)
FROM SaleDetails
WHERE YEAR(OrderDate) = 1996

--Jahresumsatz pro Jahr
SELECT SUM(Zeilenpreis), YEAR(OrderDate)
FROM SaleDetails
GROUP BY YEAR(OrderDate)

--Umsatz pro Kategorie

SELECT SUM(Zeilenpreis) AS Umsatz, c.CategoryName
FROM SaleDetails sd
JOIN Products p ON p.ProductID = sd.ProductID
JOIN Categories c ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryName

--Worauf gilt es zu achten?

----Erstellen wir aus einer Abfrage eine View, so ist das nur m�glich, wenn jede Spalte einen Namen hat (Spalten die durch Aggregatsfunktionen erzeugt werden haben per Default keinen Namen), und diese Namen alle einzigartig sind

----ORDER BY ist in einer View nur im Zusammenhang mit TOP erlaubt - sonst nicht
----(Warum? Damit keine doppelte Sortierung vorgenommen wird, wenn die View abgerufen und auch wieder sortiert wird)

--Ansonsten: M�chte man eine View �ndern gibt es zwei M�glichkeiten: ALTER oder DROP + CREATE (oder man hat gleich ein CREATE OR ALTER Statement)



