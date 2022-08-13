--Schemas sind �hnlich Namespaces aus C#
--Sie helfen uns Tabellen logisch zu gruppieren
--Das kann eine Datenbank �bersichtlicher machen und vermeidet Nameskonflikte

--Das Standardschema hei�t dbo und muss nicht mit angegeben werden
--Ist eine Tabelle (oder View/Funktion/Prozedur) NICHT im Standardschema, so muss die Tabelle immer MIT dem Schemanamen angesprochen werden

--Zus�tzlich ist es auch m�glich Benutzern Zugriff nur auf bestimmte Schemas zu erlauben/verbieten, was die Rechteverwaltung vereinfachts

SELECT prod.Color FROM Production.Product prod

CREATE TABLE Person.Haustier
(
	Id int identity primary key,
	Name varchar(100) not null,
	PersonId int references Person.Person not null
)

CREATE SCHEMA abcd
GO

CREATE TABLE abcd.Test
(
	Id int identity primary key
)