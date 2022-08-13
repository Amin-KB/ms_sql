--Die DML (Data Manipulation Language) enthält Befehle um Datensätze zu manipulieren, dh. sie zu erstellen, ändern, oder löschen

CREATE TABLE MeineTabelle
(
	Id int primary key identity,
	Wert varchar(100) not null
)

CREATE TABLE FkTabelle
(
	Id int primary key identity,
	MeineTabelleId int references MeineTabelle not null
)


----Um Datensätze zu löschen gibt es das DELETE Statement

--Syntax:
--DELETE FROM tabellenname

DELETE FROM MeineTabelle

--ACHTUNG: DELETE FROM Löscht per Default ALLE Datensätze
--Um nicht ALLE Datensätze zu löschen, sondern nur bestimmte, können wir das DELETE Statement mit einem WHERE Statement ergänzen

DELETE FROM MeineTabelle
WHERE Id = 8

--ACHTUNG: Es können keine Datensätze gelöscht werden, auf die noch von einem Fremdschlüssel aus verwiesen wird! (Verstößt gegen die Referenzielle Integrität)


----Um Datensätze zu bearbeiten oder ändern gibt es das UPDATE Statement

CREATE TABLE Büro
(
	Id int identity primary key,
	Name varchar(100) not null
)

CREATE TABLE Mitarbeiter
(
	Id int identity primary key,
	Name varchar(100) not null,
	BüroId int not null references Büro,
	Gehalt decimal(19,2) not null,
	Mitarbeiterstufe tinyint not null
)

--Syntax:
--UPDATE tabellenname
--SET spalte=neuerwert

UPDATE Mitarbeiter
SET Gehalt = 10000

--ACHTUNG: UPDATE verändert per Default ALLE Datensätze
--Um nicht ALLE Datensätze zu bearbeiten, sondern nur bestimmte, können wir das UPDATEG Statement mit einem WHERE Statement ergänzen


UPDATE Mitarbeiter
SET Gehalt = 4000
WHERE BüroId = 2

--Es ist auch möglich, sich im Update Statement auf den aktuellen Wert zu beziehen um diesen in den neuen Wert einfließen zu lassen

UPDATE Mitarbeiter
SET Gehalt = Gehalt * 1.1

--Außerdem ist es auch möglich, dass mehr als eine Spalte gleichzeitig geupdated wird

UPDATE Mitarbeiter
SET Name = 'Barbara', Gehalt = 3000
WHERE Id = 3