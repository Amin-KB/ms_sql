--Vergleiche und Filter mit Datums- und Zeitangaben

SELECT * FROM Orders
WHERE OrderDate = '1996-11-22'

SELECT * FROM Orders
WHERE OrderDate >= '1996-01-01' AND OrderDate <= '1996-12-31'

--Im Zusammenhang mit Datumsangaben (und Zeitangaben) gibt es eine Reihe von Hilfsfunktionen am SQL Server: YEAR(<datumsangabe>), MONTH(...), DAY(...), HOUR(...), MINUTE(...), SECOND(...)

SELECT * FROM Orders
WHERE YEAR(OrderDate) = 1996 AND MONTH(OrderDate) = 8

--Benötigt man das aktuelle Datum, gibt es dafür die Funktion GETDATE()

PRINT MONTH(GETDATE())

SELECT * FROM Orders
WHERE MONTH(OrderDate) = MONTH(GETDATE())