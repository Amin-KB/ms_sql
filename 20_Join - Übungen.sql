use northwind
go

--a) Eine Liste von Bestellungen mit: Firmenname Kunde (CompanyName), Bestelldatum (OrderDate), VersandOrt (ShipCity, ShipCountry), Firmenname Versandfirma (CompanyName)
select 
	cu.CompanyName as Kunde, 
	od.OrderDate as Bestelldatum, 
	od.ShipCity + ', ' + od.ShipCountry as Versandort, 
	sh.CompanyName as Versandfirma
from customers cu 
join orders od on cu.CustomerID = od.CustomerID
join shippers sh on sh.ShipperID = od.ShipVia

--b) Eine Liste von Produkten mit: Produktname (ProductName), Kategoriename (CategoryName), Preis (UnitPrice), von Produkten von Lieferant mit dem Namen (CompanyName) "Tokyo Traders"
select
	pr.ProductName as Produktname,
	ca.CategoryName as CategoryName,
	pr.UnitPrice as Preis
from products pr
join categories ca on pr.CategoryID = ca.CategoryID
join suppliers su on su.SupplierID = pr.SupplierID
where su.CompanyName = 'Tokyo Traders'


--c) Eine Liste der Territorien (TerritoryDescription) inklusive: Name der Region (RegionDescription), und Name der Mitarbeiter (LastName, FirstName), sortiert nach Regionsnamen (RegionDescription) absteigend und Territorium (TerritoryDescription) aufsteigend

select
	te.TerritoryDescription as Territorium,
	re.RegionDescription as Region,
	em.LastName + ', ' + em.FirstName as Mitarbeiter
from territories te
join region re on re.RegionID = te.RegionID
join EmployeeTerritories et on et.TerritoryID = te.TerritoryID
join Employees em on em.EmployeeID = et.EmployeeID
order by 
	re.RegionDescription desc, 
	te.TerritoryDescription