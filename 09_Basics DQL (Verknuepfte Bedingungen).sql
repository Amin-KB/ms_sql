--Bis jetzt kennen wir einfache WHERE Bedingungen

SELECT * FROM Employees
WHERE ReportsTo = 2

--Bedingungen können mit AND (C#: &&) und OR (C#: ||) verknüft werden

SELECT * FROM Employees
WHERE ReportsTo = 2 AND City = 'London'

SELECT * FROM Orders
WHERE Freight > 50 AND ShipCountry = 'Germany' OR EmployeeID = 4

SELECT * FROM Orders
WHERE Freight > 50 AND (ShipCountry = 'Germany' OR EmployeeID = 4)

--Beim Mischen von AND und OR auf die Reihenfolge achten bzw. mit Klammern arbeiten (wie in C# !)

