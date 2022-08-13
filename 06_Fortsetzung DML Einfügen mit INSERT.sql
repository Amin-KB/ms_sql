--Um Datensätze zu erstellen gibt es in der DML das INSERT Statement

CREATE TABLE Rennfahrer
(
	Nummer tinyint,
	Name varchar(100),
	Geburtsdatum datetime,
	Rennstall varchar(100),
	Land varchar(100),
	GehaltInMio decimal (6,2), 
	IstAktiv bit
)

--Beim INSERT Statement gibt es zwei Varianten - einmal die Lange, explizite Variante, und einmal die kurze

--Syntax Lange Variante:
--INSERT INTO tabellenname(spalte1, spalte2, spalte3, ...)
--VALUES (wert1, wert2, wert3)

INSERT INTO Rennfahrer(Nummer, Name,              Geburtsdatum, Rennstall,          Land,         GehaltInMio, IstAktiv)
VALUES                (33,     'Max Verstappen', '1997-09-30',  'Red Bull Racing', 'Niederlande', 23.5,        1)

--Die Reihenfolge der Spalten ist nicht wichtig - man muss nur darauf achten, dass die Werte zu den Spalten passen
INSERT INTO Rennfahrer(Name,             Rennstall,   Land,  Geburtsdatum,  GehaltInMio, IstAktiv, Nummer)
VALUES                ('Lewis Hamilton', 'Mercedes', 'UK',  '1985-01-07',   33.4,        1,        44)

--Was passiert, wenn wir Spalten weglassen?
INSERT INTO Rennfahrer(Nummer, Name, Geburtsdatum, Rennstall, Land, GehaltInMio)
VALUES (77, 'Valtteri Bottas', '1989-08-28', 'Mercedes', 'Mercedes', 20.0)

--Es wird versucht NULL einzutragen.
--Was ist aber, wenn die Spalte nicht nullable ist?

UPDATE Rennfahrer
SET IstAktiv = 'true'
WHERE Nummer = 77

ALTER TABLE Rennfahrer
ALTER COLUMN IstAktiv bit not null

--Jetzt MUSS IstAktiv angegeben werden - außer es existiert ein Default-Wert

ALTER TABLE Rennfahrer
ADD CONSTRAINT DF_IstAktiv DEFAULT 0 FOR IstAktiv

--Wir können in der Langfassung Spalten weglassen, solange es sich um nullable Spalten handelt, oder die Spalte einen Default-Wert hat

--Syntax Kurze Variante:
--INSERT INTO tabellenname
--VALUES (wert1, wert2, wert3, ..., wertN)

--In der Kurzfassung des INSERT Statements, kann man auf das Anführen der Spalten verzichten - man muss dann allerdings unbedingt die Werte in der richtigen Reihenfolge angeben

INSERT INTO Rennfahrer
VALUES 
(33, 'Max Verstappen', '1997-09-30', 'Red Bull Racing', 'Niederlande', 23.5, 1),
(77, 'Valtteri Bottas', '1989-08-28', 'Mercedes', 'Mercedes', 20.0, 0)

--Möchte man in der Kurzfassung einer Spalte einen NULL-Wert zuweisen, dann muss dieser explizit angegeben werden
--Das selbe gilt für Default-Werte - dies müssen explizit angegeben werden

INSERT INTO Rennfahrer
VALUES (33, 'Max Verstappen', NULL, 'Red Bull Racing', 'Niederlande', 23.5, DEFAULT)


--Wenn die Tabelle einen Primärschlüssel hat der über einen Autowert gesteuert wird, dann darf die Spalte beim Insert nicht angeführt werden
CREATE TABLE TabelleMitPk
(
	Id int identity primary key,
	Name varchar(100) not null
)

INSERT INTO TabelleMitPk(Name) VALUES('Hallo')
INSERT INTO TabelleMitPk VALUES('Hallo')