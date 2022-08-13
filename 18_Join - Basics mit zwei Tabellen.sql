--JOINS

--Möchte man Daten aus mehr als einer Tabelle abrufen, so müssen alle Tabellen aus denen Informationen bezogen werden wollen, verknüpft werden.

--Tabellen werden mit sogenannten Joins verknüpft (engl.: to join = verknüpfen/beitreten)

SELECT * FROM Account

SELECT * FROM Payment

--Die wichtigen Informationen die man zum Verknüpfen braucht sind: In welchen TABELLEN stehen die Informationen? Und mit welchen Schlüsselspalten sind diese Verknüpft?

--Tabellen: Account und Payment
--Spalten: Account: Id, Payment: AccountId

SELECT *
FROM Account 
JOIN Payment ON Account.Id = AccountId

--Syntax:

--SELECT * 
--FROM tabelle1 JOIN tabelle2 ON tabelle1.spalte = tabelle2.spalte

--Wichtig: Fürs erste sollten die beiden Spalten in der ON Bedingung jeweils einmal ein Primärschlüssel und einmal ein Fremdschlüssel sein

SELECT *
FROM Customer
JOIN Project ON Customer.Id = CustomerId

SELECT *
FROM Project
JOIN Customer ON Customer.Id = CustomerId

--Die Reihenfolge in der wir die Tabellen joinen, hat beim einfachen JOIN keine Auswirkung auf das Ergebnis (außer die Reihenfolge in der die Spalten angezeigt werden)

SELECT Email, CostEstimate, Name as ProjectName
FROM Project
JOIN Customer ON Customer.Id = CustomerId
WHERE YEAR(StartDate) = 2021
ORDER BY CostEstimate DESC

--Alles "rundherum" um SELECT - also WHERE, ORDER BY, GROUP BY, etc., kann genau so weiterverwendet werden wie bisher

--Tipp: Um sich Tippen zu ersparen, können Tabellen Alias-Namen vergeben werden

--Syntax: SELECT * FROM Tabelle AS alias JOIN OtherTable AS ot ON alias.Id = ot.TabelleId

SELECT pr.Id, cu.Email, pr.Name
FROM Project AS pr
JOIN Customer AS cu ON cu.Id = pr.CustomerId

--Das AS kann auch weggelassen werden (auch im SELECT)

SELECT pr.Id, cu.Email, pr.Name Projektname
FROM Project pr
JOIN Customer cu ON cu.Id = pr.CustomerId