--Ziel: Alle Kategorien die noch keine Produkte beinhalten

--Wir k�nnen die Information nicht aus NUR der Kategorie-Tabelle oder NUR der Produkttabelle beziehen - wir m�ssen sie verkn�pfen

--Der JOIN schlie�t aber Daten ohne Verkn�pfung aus - wir ben�tigen also einen andere Art von Join - die OUTER JOINs

select * from categories
insert into categories values ('test','test',null)

select * from products
order by CategoryID
--OUTER JOINS: Gibt es in drei Arten: LEFT, RIGHT, FULL

--Syntax: Wie bei normalen JOIN, aber: "Richtung" wird mit-angegeben

--zB tabelleA LEFT JOIN tabelleB ON ...

SELECT *
FROM Categories JOIN Products ON Categories.CategoryID = Products.CategoryID

SELECT *
FROM Categories LEFT JOIN Products ON Categories.CategoryID = Products.CategoryID

--OUTER Joins inkludieren auch Datens�tze im Ergebnis, auf die die ON Bedingung NICHT zutrifft

--LEFT und RIGHT join machen im Grunde genommen dasselbe, die Richtung bestimmt aber von welcher Tabelle (wortw�rtlich links oder rechts), die Daten zus�tzlich angezeigt werden
--DAHER ACHTUNG!!! Die Reihenfolge (bzw. die RICHTUNG der Outer Joins) hat Auswirkungen auf das Ergebnis (im Gegensatz zum Inner Join)

SELECT *
FROM Products LEFT JOIN Categories  ON Categories.CategoryID = Products.CategoryID

--Wenn wir also davon ausgehen, dass Categories LJ Products das ist was wir haben m�chten, k�nnen wir die Syntax nicht einfach umdrehen (Products LJ Categories ist also falsch).

--Damit wir dasselbe Ergebnis bekommen (bei umgedrehten Tabellen), m�ssen wir auch die Join-Richtung umdrehen. Ergo w�re korrekt: Products RJ Categories

SELECT *
FROM Categories LEFT JOIN Products ON Categories.CategoryID = Products.CategoryID

SELECT *
FROM Products RIGHT JOIN Categories  ON Categories.CategoryID = Products.CategoryID

--Diese Abfragen zeigens uns aber nicht nur die Kategorien ohne Produkte an, sondern auch alle Kategorien mit Produkten

--Wir wollen daher nur jene Eintr�ge behalten, mit denen keine Produkte assoziiert sind - die ProductID wird daher als NULL angegeben. Diese Eintr�ge sollen behalten werden.

SELECT *
FROM Categories LEFT JOIN Products ON Categories.CategoryID = Products.CategoryID
WHERE Products.ProductID IS NULL

--OUTER JOINS mit Where-Bedingungen auf den gegen�berliegenden Schl�ssel werden SUBTRACT JOINs genannt