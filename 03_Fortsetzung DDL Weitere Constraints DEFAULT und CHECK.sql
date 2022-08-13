----DEFAULT-WERTE

--Das Default-Constraint vergibt einen vorher festgelegten Standardwert, wenn beim Erzeugen des Datensatzes kein eigener Wert angegeben wird

--Syntax:
--(
--	<spaltenname> <datentyp> default(standardwert)
--)

--Achtung! Eine Spalte die nullable ist, trag beim einem fehlenden Wert trotzdem NULL ein, selbst wenn ein Default-Wert vorgegeben ist!

DROP TABLE DefaultConstraintTests
CREATE TABLE DefaultConstraintTests
(
	Id int primary key identity,
	Name varchar(50) not null,
	Wert int default(999)
)


----CHECK-Constraint

--Erlaubt es, eigene Bedingungen für eine Spalte, oder mehrere Spalten zusammen, festzulegen. Wird gegen diese Bedingung verstoßen, dann wird der entsprechende Datensatz nicht eingefügt

--Syntax:
--(
--	<spaltenname> <datentyp> check(bedingung)
--)

DROP TABLE CheckConstraintTests
CREATE TABLE CheckConstraintTests
(
	Id int primary key identity,
	Name varchar(50) not null,
	WertA tinyint not null check(WertA <= 10 AND WertA >= 1),
	WertB tinyint not null check(WertB <= 1000 AND WertB >= 100)
)

--Manchmal ist es notwendig, mehrere Spalten gemeinsam zu überprüfen
--Beispiel Wählerverzeichnis: In Land A darf ab 18 gewählt werden, in Land B schon ab 16


--Syntax:
--(
--	<spaltenname> <datentyp>,
--	<spaltenname> <datentyp>,
--	CONSTRAINT name CHECK(bedingung)
--)

CREATE TABLE Geschlecht
(
	Id int primary key identity, 
	Bezeichnung varchar(100) not null
)

DROP TABLE Wahlperson
CREATE TABLE Wahlperson
(
	Id int identity,
	Land varchar(100) not null,
	[Alter] int not null,
	GeschlechtId int not null,
	CONSTRAINT CK_WahlalterJeLand CHECK
	(
		(Land = 'AT' AND [Alter] >= 16) 
		OR 
		(LAND = 'DE' AND [Alter] >= 18)
	),
	CONSTRAINT PK_Wahlperson_Id PRIMARY KEY(Id),
	CONSTRAINT FK_Wahlperson_Geschlecht FOREIGN KEY(GeschlechtId) REFERENCES Geschlecht(Id)
)

--Diese Syntax, dass man Constraints ans Ende der Tabelle stellt, gilt auch für andere Constraints
--Wichtig: Wird ein Constraint nicht in der Spalte definiert, so muss beim Erstellen des Constraints immer auf die Spalte verwiesen werden

--Zusatzhinweis zu FOREIGN KEY Constraint und Namenskonventionen am SQL Server
--Der SQL Server erkennt nämlich automatisch den Primärschlüssel einer Tabelle, wenn im Namen einer Spalte, der Begriff Id am Ende steht (oder die Spalte nur Id heißt)

CREATE TABLE AnderePerson
(
	Id int identity,
	GeschlechtId int not null REFERENCES Geschlecht
)
