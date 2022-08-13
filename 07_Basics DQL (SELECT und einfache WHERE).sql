--Teilsprachen von SQL

--DDL: Data Definition Language (CREATE ALTER DROP)
----Definiert die Strukturen und Regeln, denen die Daten unterliegen
----Wir können zB Tabellen erstellen, Tabellen um Spalten erweitern oder Spalten löschen
----Außerdem ist es möglich mit Constraints gewisse Regeln für einzelne Spalten festzulegen

--DML: Data Manipulation Language (INSERT UPDATE DELETE)
----Verändert Datensätze (nicht die Strukturen und Regeln)
----Erlaubt es Daten in Tabellen einzufügen, zu ändern, oder zu löschen

--DQL: Data Query Language (SELECT)
----Mit der DQL können Daten aus einer oder mehreren Tabellen abgerufen werden


--Einfachstes Select-Statement das es gibt:

--Syntax: SELECT * FROM <tabellenname>

USE Northwind
GO

SELECT * FROM Products

--Nach dem SELECT kann man jene Spalten anführen, welche ausgewählt werden sollen - alle die nicht angegeben werden, werden auch nicht ins Ergebnis mitgenommen


--Syntax: SELECT <spalte1>, <spalte2>, ..., <spalteN> FROM <tabellenname>
SELECT ProductID, ProductName, UnitPrice FROM Products
 
--Manchmal ist es ganz praktisch, einer Tabelle für eine Abfrage einen Spitznamen zu geben (selten nützlich wenn man nur von einer Tabelle Daten braucht)

--Syntax: SELECT * FROM <tabellenname> AS <spitzname>

--So ein Alias ("Spitzname") erlaubt es, Tabellennamen abzukürzen; dieser Spitzname kann dann in der restlichen Abfrage verwendet werden um den Tabellennamen abzukürzen

SELECT p.ProductID, p.ProductName, p.UnitPrice FROM Products AS p

--Das Schlüsselwort AS kann auch weggelassen werden

SELECT p.ProductID, p.ProductName, p.UnitPrice FROM Products p

--Wie gesagt, wird erst wirklich relevant, wenn wir Daten aus mehreren Tabellen abfragen um die Übersicht zu behalten

--Um ganze Datensätze auszuschließen bzw. herauszufiltern, gibt es die WHERE Bedingung. Diese ist uns schon bei UPDATE und DELETE begegnet

--Syntax:

--SELECT ...
--WHERE <bedingung>

SELECT * FROM Products
WHERE UnitPrice >= 100

--Vergleichsoperatoren für Zahlen und Texte
-- = (ACHTUNG: Nur ein = beim Vergleich in SQL!)
-- >
-- <
-- >=
-- <=
-- <> (Hinweis: Am SQL Server wird auch != als "ungleich" erkannt - der SQL Standard ist aber <> für "ungleich")

SELECT * FROM Products
WHERE SupplierID <> 3


--Beim Datentyp bit gilt zu beachten, dass dieser sowohl mit Zahlen als auch Texten verglichen werden kann. ABER ACHTUNG: gültige Zahlen sind 0 und 1, gültige Texte sind 'true' und 'false'
--Die oben genannten Vergleichsoperatoren verhalten sich dann auch dementsprechend wie bei normalen Zahlen- oder Textvergleichen
--Allerdings ist es sehr unüblich, dass man bei einem bit einen anderen Vergleich macht als = oder <>

SELECT * FROM Products
WHERE Discontinued = 1

SELECT * FROM Products
WHERE Discontinued = 'true'


--WICHTIG: Text wird in SQL nur mit einfachen Anführungsstrichen markiert)
--Hinweis: Die Standard-Einstellung am SQL Server behandelt Texte als case-INsensitive. Dh. 'tofu' ist dasselbe wie 'Tofu', aber accent-sensitive, dh. 'Tofu' ist nicht dasselbe wie 'Tófu'

SELECT * FROM Products
WHERE ProductName = 'Tofu'

SELECT * FROM Products
WHERE ProductName <> 'Schoggi Schokolade'

SELECT * FROM Products
WHERE ProductName = 'Tof'









