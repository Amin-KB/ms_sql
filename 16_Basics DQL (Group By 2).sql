select Country, City, COUNT(*) as AnzahlKunden
from customers
group by City, Country

--Mit WHERE können wir einzelne Datensätze ausschließen
--Im Rahmen von GROUP BY schließt WHERE Datensätze aus BEVOR sie gruppiert werden

--Was aber, wenn mich nur gewisse GRUPPEN interessieren?
--Zum Beispiel nur die Gruppen, wo es mehr als einen Kunden gibt

select Country, City, COUNT(*) as AnzahlKunden
from customers
group by City, Country having COUNT(*) > 1

--HAVING schließt (nach dem Gruppieren) ganze Gruppen aus dem Ergebnis aus


--Übung: Anzahl der Bestellungen je KundenId

SELECT CustomerID, COUNT(*)
FROM Orders
GROUP BY CustomerID

--Übung: Welche Kunden haben mindestens 15 Bestellungen aufgegeben?

SELECT CustomerID, COUNT(*)
FROM Orders
GROUP BY CustomerID HAVING COUNT(*) >= 15

--Übung: Anzahl der schweren Bestellungen (Fracht > 80) je Kunde

SELECT CustomerID, COUNT(*)
FROM Orders
WHERE Freight > 80 --Fracht bezieht sich noch auf den Order-Datensatz
--Wir wollen nur Orders berücksichtigen, die die Bedingung erfüllen (und erst DANACH zählen bzw. halt nur diese zählen)
GROUP BY CustomerID

--Übung: Welche Kunden haben mindestens 15 schwere Bestellungen (Fracht > 80) aufgegeben?

SELECT CustomerID, COUNT(*) as Anzahl
FROM Orders
WHERE Freight > 80 
GROUP BY CustomerID HAVING COUNT(*) >= 15

