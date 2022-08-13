--Aus welchen Kategorien wurde noch nichts bestellt?

insert into categories values ('test','test',null)

SELECT *
FROM Categories ca 
LEFT JOIN Products pr ON ca.CategoryID = pr.CategoryID
LEFT JOIN [Order Details] od ON od.ProductID = pr.ProductID
LEFT JOIN Orders os ON od.OrderID = os.OrderID
WHERE os.OrderID IS NULL

--Wir m�ssen in diesem Fall immer mit dem LEFT Join arbeiten, weil wir sonst Kategorien ausschlie�en die Keine Produkte haben (die dann nat�rlich nie bestellt werden konnten, und dadurch auch keine Order-Details haben)