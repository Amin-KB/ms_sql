--Wenn wir noch keine Datenbank haben, müssen wir uns eine erstellen.

--Das passiert mit dem Befehl CREATE DATABASE <name>

CREATE DATABASE TestDatenbank;
GO
--Wenn wir mit einer konkreten Datenbank arbeiten möchten (um zum Beispiel dort Tabellen zu erstellen), dann können wir diese mit USE <name> auswählen.
USE TestDatenbank;
GO

--Zum Erstellen einer Tabelle gibt es den CREATE TABLE Befehl.
--Wenn eine Tabelle erstellt wird muss zumindest ein Name angegeben werden,
--und zumindest eine Spalte definiert werden
--CREATE TABLE <name> 
--(
--  <columnname> <datatype>,
--  <columnname> <datatype>,
--  ...
--  <columnname> <datatype>
--)

CREATE TABLE Genre
(
	Id int,
	Name nvarchar(100)
)
GO

--Wollen wir eine Tabelle löschen, dann können wir das mit DROP TABLE <name>.

DROP TABLE Genre
GO

--Achtung! Wird eine Tabelle gelöscht, werden automatisch alle darin enthaltenen Daten mitgelöscht.

--Wollen wir eine ganze Datenbank löschen, dann gibt es dafür den Befehle DROP DATABASE <name>.

USE master
GO

DROP DATABASE TestDatenbank
GO
--Achtung: Bestand "vor kurzem" eine Verbindung zur Datenbank, so kann es sein, dass aufgrund dieser Verbindung, die Datenbank nicht gelöscht werden kann. In diesem Fall entweder die Verbindung manuell "umstellen" (erfordert SQL auf Fortgeschrittenen Level), oder zunächst vom ganzen Server die Verbindung trennen, und dann den Befehl ausführen.


--SQL Befehle können "optional" mit einem Semikolon beendet werden
--Für die meisten Befehle ist es tatsächlich optional.
--Semikolons sind nur bei komplexen Abfragen wirklich notwendig

--Wenn mehrere SQL-Befehle an den Microsoft SQL Server geschickt werden, dann werden die Befehle grundsätzlich als ein Block interpretiert
--Hierbei kann es zu Problemen kommen - nämlich dann, wenn ein Befehl zu lange braucht um ausgeführt zu werden. Der SQL Server wartet nicht automatisch darauf, dass Befehle fertig ausgeführt werden, und führt weitere Befehle im selben Block direkt hintereinander aus.
--Um sicherzustellen, dass, wenn viele Befehle auf einmal geschickt werden, zwischen kritischen Befehlsgruppen gewartet wird, gibt es am SQL Server einen eigenen Befehl (der NICHT Teil von SQL ist).
--Dieser Befehl nennt sich "GO"
--Begegnet der SQL Server einem GO, so wird mit der Ausführung aller weiteren Befehle gewartet, bis die Befehle vor dem GO abgeschlossen sind.
--Üblicherweise verwendet man nach jedem DDL Befehl ein GO