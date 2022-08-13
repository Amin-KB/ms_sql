--Constraints (Einschränkungen)

--Constraints schränken den Wertebereich ein, der in ein Feld eingetragen werden darf

--Constraints kennen wir schon aus der Theorie - zum Beispiel dass der Primärschlüssel eindeutig und immer vorhanden sein muss 

--Wir wollen aber zum Beispiel auch Zahlenwerte auf einen gewissen Bereich einschränken, wie zB die Bewertung, sie sollte nur von 0 bis 10 gehen.

--Außerdem möchten wir vielleicht garantieren, dass wir in Beziehungen, nur gültige Fremd/Primärschlüssel verwenden können

--Schlussendlich macht es manchmal keinen Sinn, wenn wir "nichts" abspeichern (zum Beispiel beim Namen eines Spiels oder ein Plattform)

--Constraints können entweder direkt beim Erstellen der Tabelle (bzw. der einzelnen Spalten) definiert werden, oder aber auch im Nachhinein noch hinzugefügt werden

--Eine wichtige Unterscheidung gibt es noch: manche Constraints haben einen Namen, andere nicht

----PRIMARY KEY Constraint
--Setzt den Primärschlüssel einer Tabelle auf das entsprechende Feld

--Das Feld auf dem der Primärschlüssel liegt, muss fortan IMMER einen Wert haben (darf nicht NULL sein), und die Werte in dieser Spalte dürfen sich nicht wiederholen

--Pro Tabelle kann es nur einen Primärschlüssel geben

CREATE TABLE Genre
(
	Id int constraint PK_Genre_Id primary key,
	Name nvarchar(100) not null
)
GO

--Syntax:
--(
--	<spaltenname> <datentyp> primary key
--)

--Alternativsyntax, falls dem Constraint ein Name vergeben werden soll
--(
--	<spaltenname> <datentyp> constraint <constraintname> primary key
--)

----NOT NULL Constraint
--Zusätzlich wollten wir garantieren, dass der Name eines Genres immer einen Wert haben muss (es soll also nicht "nichts" bzw. NULL abgespeichert werden können)
--Dazu gibt es das Constraints 'not null'

--Syntax:
--(
--	<spaltenname> <datentyp> not null
--)

--Not Null ist ein Constraint welches keinen Namen hat
--Wird bei einer Spalte nicht 'not null' angegeben, so kann die Spalte per Default NULL-Werte annehmen.
--Möchte man das explizit ausdrücken, dass eine Spalte NULL-Werte speichern können soll, kann man auch 'null' als "Constraint" angeben. 

----UNIQUE Constraint

--Manchmal möchte man, dass sich in einer Spalte keine Werte wiederholen dürfen. Um, wie zum Beispiel bei der Plattform, keine zwei Einträge mit dem selben Namen zu haben

--Dies kann mit dem UNIQUE Constraint verhindert werden

--Syntax:
--(
--	<spaltenname> <datentyp> unique
--)

--Alternativsyntax, falls ein Name vergeben werden soll
--(
--	<spaltenname> <datentyp> constraint <constraintname> unique
--)
DROP TABLE Plattform
CREATE TABLE Plattform
(
	Id int constraint PK_Plattform_Id primary key,
	Name nvarchar(100) not null constraint UQ_Plattform_Name unique
)
GO

--Wie verhält sich UNIQUE mit NULL? Wenn eine Spalte als unique und nullable definiert ist, so darf nur einmal NULL abgespeichert werden (Achtung, kann bei anderen DBMS anders sein!)

----FOREIGN KEY Constraint

--Wichtig: RELATIONALE DATENBANKEN FUNKTIONIEREN AUCH OHNE DEM FOREIGN KEY CONSTRAINT. FREMDSCHLÜSSEL SIND EIN ALLGEMEINES KONZEPT, DAS NICHT ERST DURCH DAS FOREIGN KEY CONSTRAINT "AKTIVIERT" WIRD


--Syntax:
--(
--	<spaltenname> <datentyp> foreign key references <AndereTabelle>(<SpalteAusAndererTabelle)
--)

--Wichtig: Die Spalte aus der anderen Tabelle auf die verwiesen wird, MUSS als PRIMARY KEY definiert sein (oder UNIQUE)

CREATE TABLE Genre
(
	Id int constraint PK_Genre_Id primary key,
	Name nvarchar(100) not null
)
GO


CREATE TABLE Spiel
(
	Id int primary key,
	Titel nvarchar(200),
	Bewertung tinyint,
	ZuletztgGespielt date
)
GO

CREATE TABLE SpielGenre
(
	Id int primary key,
	SpielId int constraint FK_SpielGenre_SpielId_Spiel_Id foreign key references Spiel(Id),	
	GenreId int constraint FK_SpielGenre_GenreId_Genre_Id foreign key references Genre(Id)
)
GO

--Alternativ Syntax für benannte FK Constraints:
--(
--	<spaltenname> <datentyp> constraint <nameDesConstraints> foreign key references <AndereTabelle>(<SpalteAusAndererTabelle)
--)

--Achtung: das FOREIGN KEY Constraint verhinder nicht, dass NULL Werte eingetragen werden. Ein NULL Wert in einem Fremdschlüssel-Feld bedeutet einfach, dass der Eintrag (im Moment) keine Beziehung zu einem anderen Eintrag hat.

----AUTO-WERTE

--Für die Primärschlüsselspalte, besonders dann wenn wir einen "künstlichen" Schlüssel nehmen, macht es oft Sinn, nicht einen Anwender den Wert frei wählen zu lassen, sondern automatisch jedem neuen Eintrag eine neue Id zu geben (funktioniert nur für Zahlenwerte)

--Vereinfacht gesagt: ein Auto-Wert ist eine "fortlaufende" Nummer, die zum einen verhindert dass überhaupt selbst ein Wert eingetragen werden kann, und auch, dass der Wert verändert kann.

--Wichtig: Maximal 1 Auto-Wert pro Tabelle

--Syntax:
--(
--	<spaltenname> <datentyp> identity
--)

--Alternativ-Syntax, wenn Startwert und Schrittweite festgelegt werden sollen:
--(
--	<spaltenname> <datentyp> identity(seed, increment)
--)

CREATE TABLE Genre
(
	Id int constraint PK_Genre_Id primary key identity(-10000,1),
	Name nvarchar(100) not null unique
)
GO

DROP TABLE SpielGenre
DROP TABLE Genre
DROP TABLE Spiel