--Constraints (Einschr�nkungen)

--Constraints schr�nken den Wertebereich ein, der in ein Feld eingetragen werden darf

--Constraints kennen wir schon aus der Theorie - zum Beispiel dass der Prim�rschl�ssel eindeutig und immer vorhanden sein muss 

--Wir wollen aber zum Beispiel auch Zahlenwerte auf einen gewissen Bereich einschr�nken, wie zB die Bewertung, sie sollte nur von 0 bis 10 gehen.

--Au�erdem m�chten wir vielleicht garantieren, dass wir in Beziehungen, nur g�ltige Fremd/Prim�rschl�ssel verwenden k�nnen

--Schlussendlich macht es manchmal keinen Sinn, wenn wir "nichts" abspeichern (zum Beispiel beim Namen eines Spiels oder ein Plattform)

--Constraints k�nnen entweder direkt beim Erstellen der Tabelle (bzw. der einzelnen Spalten) definiert werden, oder aber auch im Nachhinein noch hinzugef�gt werden

--Eine wichtige Unterscheidung gibt es noch: manche Constraints haben einen Namen, andere nicht

----PRIMARY KEY Constraint
--Setzt den Prim�rschl�ssel einer Tabelle auf das entsprechende Feld

--Das Feld auf dem der Prim�rschl�ssel liegt, muss fortan IMMER einen Wert haben (darf nicht NULL sein), und die Werte in dieser Spalte d�rfen sich nicht wiederholen

--Pro Tabelle kann es nur einen Prim�rschl�ssel geben

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
--Zus�tzlich wollten wir garantieren, dass der Name eines Genres immer einen Wert haben muss (es soll also nicht "nichts" bzw. NULL abgespeichert werden k�nnen)
--Dazu gibt es das Constraints 'not null'

--Syntax:
--(
--	<spaltenname> <datentyp> not null
--)

--Not Null ist ein Constraint welches keinen Namen hat
--Wird bei einer Spalte nicht 'not null' angegeben, so kann die Spalte per Default NULL-Werte annehmen.
--M�chte man das explizit ausdr�cken, dass eine Spalte NULL-Werte speichern k�nnen soll, kann man auch 'null' als "Constraint" angeben. 

----UNIQUE Constraint

--Manchmal m�chte man, dass sich in einer Spalte keine Werte wiederholen d�rfen. Um, wie zum Beispiel bei der Plattform, keine zwei Eintr�ge mit dem selben Namen zu haben

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

--Wie verh�lt sich UNIQUE mit NULL? Wenn eine Spalte als unique und nullable definiert ist, so darf nur einmal NULL abgespeichert werden (Achtung, kann bei anderen DBMS anders sein!)

----FOREIGN KEY Constraint

--Wichtig: RELATIONALE DATENBANKEN FUNKTIONIEREN AUCH OHNE DEM FOREIGN KEY CONSTRAINT. FREMDSCHL�SSEL SIND EIN ALLGEMEINES KONZEPT, DAS NICHT ERST DURCH DAS FOREIGN KEY CONSTRAINT "AKTIVIERT" WIRD


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

--Alternativ Syntax f�r benannte FK Constraints:
--(
--	<spaltenname> <datentyp> constraint <nameDesConstraints> foreign key references <AndereTabelle>(<SpalteAusAndererTabelle)
--)

--Achtung: das FOREIGN KEY Constraint verhinder nicht, dass NULL Werte eingetragen werden. Ein NULL Wert in einem Fremdschl�ssel-Feld bedeutet einfach, dass der Eintrag (im Moment) keine Beziehung zu einem anderen Eintrag hat.

----AUTO-WERTE

--F�r die Prim�rschl�sselspalte, besonders dann wenn wir einen "k�nstlichen" Schl�ssel nehmen, macht es oft Sinn, nicht einen Anwender den Wert frei w�hlen zu lassen, sondern automatisch jedem neuen Eintrag eine neue Id zu geben (funktioniert nur f�r Zahlenwerte)

--Vereinfacht gesagt: ein Auto-Wert ist eine "fortlaufende" Nummer, die zum einen verhindert dass �berhaupt selbst ein Wert eingetragen werden kann, und auch, dass der Wert ver�ndert kann.

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