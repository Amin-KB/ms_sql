--Syntax:

--CREATE [UNIQUE] [CLUSTERED|NONCLUSTERED*] INDEX [name] ON [tabelle]([spalte] [ASC*|DESC])

CREATE NONCLUSTERED INDEX meinIndex ON Customer(Email)
INCLUDE (LastName)

--CREATE UNIQUE NONCLUSTERED INDEX meinIndex ON Customer(Email)
--CREATE UNIQUE NONCLUSTERED INDEX meinIndex ON Customer(Firstname, Lastname, Email)

--CREATE NONCLUSTERED INDEX meinIndex ON Customer(Email DESC)

--Inkludieren von Spalten (die NICHT indiziert sind)
--CREATE INDEX bla ON Tabelle(Spalte(n)) INCLUDE (Spalte(n))



