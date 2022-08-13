--Ergebnisse sortieren

SELECT * FROM Products

--Per Default ist eine Tabelle nach dem Primärschlüssel sortiert (bzw. genauer genommen, nach dem Clustered-Index). Will man die Ergebnisse in einer anderen Reihenfolge gibt es dazu ORDER BY

--Syntax:
--SELECT * FROM <table> WHERE <condition> ORDER BY <spalte> <ASC|DESC>

--ASC = Ascending (aufsteigend), ist der Default und muss nicht angegeben werden
--DESC = Descending (absteigend)

SELECT * FROM Products
ORDER BY UnitPrice DESC

--Es ist auch möglich mehrere Spalten anzugeben
--Syntax:
--SELECT * FROM <table> WHERE <condition> ORDER BY <spalte1> <ASC|DESC>, <spalte2> <ASC|DESC>

SELECT * FROM Products
WHERE UnitPrice <= 18
ORDER BY UnitPrice, ProductName DESC
