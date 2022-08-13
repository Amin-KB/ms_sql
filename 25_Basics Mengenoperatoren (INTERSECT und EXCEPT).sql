--Alle Customers, die 1996 Dairy Products bestellt haben
SELECT DISTINCT cu.CompanyName
FROM 
	Customers cu
	JOIN Orders os on cu.CustomerID = os.CustomerID
	JOIN [Order Details] od on od.OrderID = os.OrderID
	JOIN Products pr on  pr.ProductID = od.ProductID
	JOIN Categories ca on ca.CategoryID = pr.CategoryID
WHERE YEAR(os.OrderDate) = 1996 AND ca.CategoryName = 'Dairy Products'
UNION
--Und alle Customers die 1997 Condiments bestellt haben
SELECT DISTINCT cu.CompanyName
FROM 
	Customers cu
	JOIN Orders os on cu.CustomerID = os.CustomerID
	JOIN [Order Details] od on od.OrderID = os.OrderID
	JOIN Products pr on  pr.ProductID = od.ProductID
	JOIN Categories ca on ca.CategoryID = pr.CategoryID
WHERE YEAR(os.OrderDate) = 1997 AND ca.CategoryName = 'Condiments'

--UNION fässt quasi beide Abfrageergebnisse, in einer zusammen (und eliminiert Wiederholungen)

--INTERSECT folgt dem selben Prinzip wie UNION: Es werden zwei Abfrageergebnisse (vertikal) verbunden. INTERSECT gibt aber nur jene Ergebnisse zurück, die in BEIDEN Abfrageergebnissen vorkommen

--zB Ergebnis Abfrage Q1: A, B, F, S, T
--zB Ergebnis Abfrage Q2: A, C, D, F, S
--Q1 INTERSECT Q2 --> A, F, S (da nur diese Datensätze in beiden Ergebnissen vorkommen)



--Welche Kunden, die 1996 Dairy Products bestellt haben, haben 1997 Condiments bestellt?
SELECT DISTINCT cu.CompanyName
FROM 
	Customers cu
	JOIN Orders os on cu.CustomerID = os.CustomerID
	JOIN [Order Details] od on od.OrderID = os.OrderID
	JOIN Products pr on  pr.ProductID = od.ProductID
	JOIN Categories ca on ca.CategoryID = pr.CategoryID
WHERE YEAR(os.OrderDate) = 1996 AND ca.CategoryName = 'Dairy Products'
INTERSECT
SELECT DISTINCT cu.CompanyName
FROM 
	Customers cu
	JOIN Orders os on cu.CustomerID = os.CustomerID
	JOIN [Order Details] od on od.OrderID = os.OrderID
	JOIN Products pr on  pr.ProductID = od.ProductID
	JOIN Categories ca on ca.CategoryID = pr.CategoryID
WHERE YEAR(os.OrderDate) = 1997 AND ca.CategoryName = 'Condiments'


--Mini-Übung: Was ist das Jahr in dem überhaupt zuletzt bestellt wurde

SELECT MAX(YEAR(OrderDate)) FROM Orders

--Alle Kunden die 1998 Neukunden waren (also vorher nichts bestellt hatten)

--Alle Kunden, die 1998 etwas bestellt haben
SELECT DISTINCT cu.CompanyName
FROM 
	Customers cu
	JOIN Orders os on cu.CustomerID = os.CustomerID
WHERE YEAR(os.OrderDate) = 1998
EXCEPT
--Alle Kunden, die VOR 1998 schon bestellt haben
SELECT DISTINCT cu.CompanyName
FROM 
	Customers cu
	JOIN Orders os on cu.CustomerID = os.CustomerID
WHERE YEAR(os.OrderDate) < 1998
