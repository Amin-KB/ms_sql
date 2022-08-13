--Neben CREATE und DROP gibt es in der DDL auch noch das ALTER Statement

--Damit lassen sich die Datenstrukutren, wie zB Tabellen, verändern

--Zum Beispiel ist es möglich im Nachhinein Spalten einer Tabelle hinzuzufügen oder zu löschen

CREATE TABLE MeineTabelle
(
	Id int primary key identity,
	Wert varchar(100) not null
)

ALTER TABLE MeineTabelle
ADD NeueSpalte int not null

ALTER TABLE MeineTabelle
DROP COLUMN NeueSpalte

--Wichtig: Sind für die Spalte Constraints definiert, müssen diese zunächst gelöscht werden

ALTER TABLE MeineTabelle
ADD AndereSpalte int not null CONSTRAINT CK_Test CHECK(AndereSpalte < 10)

ALTER TABLE MeineTabelle
DROP CONSTRAINT CK_Test

--Constraints können natürlich auch im Nachhinein hinzufügen

ALTER TABLE MeineTabelle
ADD CONSTRAINT CK_Test CHECK(AndereSpalte < 10) 

--Es kann auch der Datentyp einer Spalte geändert werden - Achtung! Die Datentypen müssen miteinander kompatibel sein (dh. es muss möglich sein, den einen Datentypen in den anderen umzuwandeln)

ALTER TABLE MeineTabelle ALTER COLUMN AndereSpalte tinyint

ALTER TABLE MeineTabelle ALTER COLUMN Wert varchar(10)

--Zb ein Text ist zu lange für die neue Vorgabe, oder Zahlen sind zu groß
--Möglichkeit um die Umwandlung doch durchzuführen: Problematische Datensätze ganz löschen, oder Problematische Daten manuell so abändern, dass sie in das neue Format passen (zB Text kürzen, Zahlen kleiner machen)