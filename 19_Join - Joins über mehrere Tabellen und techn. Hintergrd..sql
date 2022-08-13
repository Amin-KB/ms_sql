--Oft ist es notwendig, mehr als nur zwei Tabellen zu verknüpfen
--Dazu werden einfach beliebig viele JOIN Statements aneinandergereiht (ohne Beistriche!)
--Die Syntax bleibt gleich

--SELECT *
--FROM table1 
--JOIN table2 ON table1.pk = table2.t1fk
--JOIN table3 ON table2.pk = table3.t2fk
--JOIN table4 ON table3.pk = table4.t3fk


SELECT Amount, ProjectId, Email, ac.Name, pr.*
FROM Payment pa 
JOIN Project pr ON pa.ProjectId = pr.Id
JOIN Customer cu ON cu.Id = pr.CustomerId
JOIN Account ac ON ac.Id = pa.AccountId

--Die Reihenfolge ist egal - wichtig ist nur, dass immer zwei "benachbarte" Tabellen gejoint werden

--Technisch gesehen, müssen nicht zusammenhängende Primär- und Fremdschlüssel gejoint werden - aber solche Joins ergeben IMMER Sinn!

SELECT * FROM
Account JOIN Customer ON Name = LastName

SELECT * FROM 
Payment pa JOIN Project pr ON Amount = CostEstimate

SELECT * FROM
Account ac JOIN Customer cu ON ac.Id = cu.Id

--Genauso können Primär und Fremdschlüssel gejoint werden, die NICHT im Diagramm verbunden sind

--Gemeinsame Übung

--Kundenname, Projektname, Zahlungsdatum, Betrag, Kontoname

SELECT 
	Customer.FirstName + ' ' + Customer.LastName as Kundenname, 
	Project.Name as Projektname,
	Payment.ReceivedOn as Zahlungsdatum,
	Payment.Amount as Betrag,
	Account.name as Kontoname
FROM Customer
JOIN Project ON Customer.Id = Project.CustomerId
JOIN Payment ON Project.Id = Payment.ProjectId
JOIN Account ON Payment.AccountId = Account.Id
