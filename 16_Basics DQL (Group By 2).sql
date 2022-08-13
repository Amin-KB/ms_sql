select Country, City, COUNT(*) as AnzahlKunden
from customers
group by City, Country

--Mit WHERE k�nnen wir einzelne Datens�tze ausschlie�en
--Im Rahmen von GROUP BY schlie�t WHERE Datens�tze aus BEVOR sie gruppiert werden

--Was aber, wenn mich nur gewisse GRUPPEN interessieren?
--Zum Beispiel nur die Gruppen, wo es mehr als einen Kunden gibt

select Country, City, COUNT(*) as AnzahlKunden
from customers
group by City, Country having COUNT(*) > 1

--HAVING schlie�t (nach dem Gruppieren) ganze Gruppen aus dem Ergebnis aus


--�bung: Anzahl der Bestellungen je KundenId

SELECT CustomerID, COUNT(*)
FROM Orders
GROUP BY CustomerID

--�bung: Welche Kunden haben mindestens 15 Bestellungen aufgegeben?

SELECT CustomerID, COUNT(*)
FROM Orders
GROUP BY CustomerID HAVING COUNT(*) >= 15

--�bung: Anzahl der schweren Bestellungen (Fracht > 80) je Kunde

SELECT CustomerID, COUNT(*)
FROM Orders
WHERE Freight > 80 --Fracht bezieht sich noch auf den Order-Datensatz
--Wir wollen nur Orders ber�cksichtigen, die die Bedingung erf�llen (und erst DANACH z�hlen bzw. halt nur diese z�hlen)
GROUP BY CustomerID

--�bung: Welche Kunden haben mindestens 15 schwere Bestellungen (Fracht > 80) aufgegeben?

SELECT CustomerID, COUNT(*) as Anzahl
FROM Orders
WHERE Freight > 80 
GROUP BY CustomerID HAVING COUNT(*) >= 15

