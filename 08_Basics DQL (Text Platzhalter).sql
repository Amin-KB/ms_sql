--Der normale Textevergleich mit den üblichen Operatoren (=, <, ...) basiert auf exakter Gleichheit (exakt mit Hinblick auf die Sortierung)

--Meistens wollen wir aber nicht exakte Texte suchen, sondern teile von Texten

USE Northwind
GO

SELECT * FROM Products
WHERE ProductName = 'sauce'

--Die obrige Abfrage liefert keine Ergebnisse, da es kein Produkt gibt, das exakt 'sauce' heißt

--Eine Lösung für das Problem sind Platzhalter. Um Platzhalter zu verwenden, muss allerdings ein anderer Vergleichsoperator statt = verwendet werden.
--Der andere Vergleichsoperator heißt LIKE

SELECT * FROM Products
WHERE ProductName LIKE 'sauce'

--Platzhalter (Wildcards) am SQL Server
-- % = 0, 1, oder viele Zeichen (in anderen Sprachen oft *)
-- _ = Exakt 1 Zeichen (in anderen Sprachen oft ?)
-- # = Exakt 1 Ziffer (0-9)
-- [] = Exakt 1 Zeichen derer, die in der Klammer stehen
-- [^] = Exakt 1 Zeichen derer, die NICHT in der Klammer stehen
-- [-] = Exakt 1 Zeichen das sich zwischen den angegebenen Buchstaben befindet

SELECT * FROM Products
WHERE ProductName LIKE '%sauce%' --Findet alle Wörter in denen der Begriff sauce enthalten ist

SELECT * FROM Products
WHERE ProductName LIKE 'Tof_' --Findet alle Wörter die mit Tof beginnen, und dann ein Zeichen extra haben

SELECT * FROM Products
WHERE ProductName LIKE 'Tof[aeiou]' --Findet Tofa, Tofe, Tofi, Tofo, Tofu

SELECT * FROM Products
WHERE ProductName LIKE 'Ch[ai][ai]' --Findet Chai oder Chia

SELECT * FROM Products
WHERE ProductName LIKE 'Tof[^aei]' -- Findet Tofb, Tofc, ...; also alles außer Tofa, Tofe, Tofi

SELECT * FROM Products
WHERE ProductName LIKE 'Tof[a-e]' -- Findet Tofa, Tofb, Tofc, ... bis Tofe

SELECT * FROM Products
WHERE ProductName LIKE 'Tof[a-z]' -- Findet Tofu, Tofv, Tofw, ... bis Tofz