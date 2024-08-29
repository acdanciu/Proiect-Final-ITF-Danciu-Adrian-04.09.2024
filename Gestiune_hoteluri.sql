create database gestiune_hoteluri;
use gestiune_hoteluri;

/*
 Descrierea Proiectului:
Vom crea un Sistem de Gestionare a Rezervărilor Hoteliere pentru a gestiona hoteluri, 
camere, clienți, rezervări și plăți. Acest sistem va include funcționalități pentru 
adăugarea de hoteluri și camere noi, înregistrarea clienților noi, procesarea rezervărilor
și urmărirea plăților.
*/


-- DDL (Data Definition Language)

-- 1. CREAREA TABELELOR:

-- Tabela Hoteluri
CREATE TABLE Hoteluri (
    HotelID INT AUTO_INCREMENT PRIMARY KEY,
    NumeHotel VARCHAR(30),
    Locatie VARCHAR(20),
    Rating DECIMAL(2, 1),
    Descriere TEXT
);

ALTER TABLE Hoteluri MODIFY NumeHotel VARCHAR(40) NOT NULL;
-- modifica tipul tipul de variabila din 30 in 40 caractere si adauga NOT NULL (nu poate avea valoarea 0)

ALTER TABLE Hoteluri ADD COLUMN Recenzii VARCHAR (100);
-- adauga o coloana la tabela Hoteluri

ALTER TABLE Hoteluri DROP COLUMN Recenzii;
 -- sterge coloana Recenzii din tabela Hoteluri

-- DROP TABLE Hoteluri; // sterge o tabela si toate datele
-- TRUNCATE TABLE Hoteluri; // sterge toate randurile dintr_o tabela dar structura ramane
-- RENAME TABLE Hoteluri TO UnitatiCazare; // redenumeste tabela Hoteluri
-- ALTER TABLE Hoteluri RENAME COLUMN Hotel_ID to HotelID; // redenumeste nume coloana


-- Tabela Camere


CREATE TABLE Camere (
    CameraID INT AUTO_INCREMENT PRIMARY KEY,
    HotelID INT,
    NumarCamera VARCHAR(10),
    TipCamera VARCHAR(20),
    Pret DECIMAL(10, 2),
    StatusDisponibilitate VARCHAR(20),
    FOREIGN KEY (HotelID) REFERENCES Hoteluri(HotelID)
);

-- Tabela Clienti
CREATE TABLE Clienti (
    ClientID INT AUTO_INCREMENT PRIMARY KEY,
    Prenume VARCHAR(20),
    Nume VARCHAR(20),
    Adresa VARCHAR(30),
    Telefon VARCHAR(15),
    Email VARCHAR(30)
);

-- Tabela Rezervari
CREATE TABLE Rezervari (
    RezervareID INT AUTO_INCREMENT PRIMARY KEY,
    ClientID INT,
    CameraID INT,
    DataRezervare DATE,
    DataCheckIn DATE,
    DataCheckOut DATE,
    Status VARCHAR(20),
    FOREIGN KEY (ClientID) REFERENCES Clienti(ClientID),
    FOREIGN KEY (CameraID) REFERENCES Camere(CameraID)
);

-- Tabela Plati
CREATE TABLE Plati (
    PlataID INT AUTO_INCREMENT PRIMARY KEY,
    RezervareID INT,
    DataPlata DATE,
    Suma DECIMAL(10, 2),
    MetodaPlata VARCHAR(20),
    FOREIGN KEY (RezervareID) REFERENCES Rezervari(RezervareID)
);

-- adaugarea si stergerea de FOREIGN KEY de la o tabela 

ALTER TABLE Plati
ADD COLUMN ClientID int;

ALTER TABLE Plati
DROP COLUMN ClientID;

ALTER TABLE Plati
ADD FOREIGN KEY (ClientID) REFERENCES Clienti(ClientID);
SHOW CREATE TABLE Plati;
ALTER TABLE Plati 
DROP FOREIGN KEY plati_ibfk_2;


-- instrucțiuni DML (Data Manipulation Language)

-- 1. ADAUGAREA UNUI HOTEL NOU

-- inserarea unui hotel nou în tabela Hoteluri

INSERT INTO Hoteluri (NumeHotel, Locatie, Rating, Descriere)
VALUES 
('Hotel Ocean View', 'Miami Beach, FL', 4.5, 'Un hotel frumos pe malul oceanului, cu vederi uimitoare.'),
('Hotel Marriott', 'Los Angeles, CA', 4.5, 'Un hotel elegant cu vedere la Pacific'),
('Hotel Fairmont', 'Maui, HI', 5.00, 'Un hotel de lux pe malul oceanului'),
('Hotel Morenia Beach Resort', 'Croatia', 4.3, 'Un hotel all inclusive, cu vedere la Marea Adriatica');
    
select * from Hoteluri;


-- 2. ADAUGAREA UNEI CAMERE NOI LA UN HOTEL

-- Adăugarea unei camere noi în tabela Camere:

INSERT INTO Camere (HotelID, NumarCamera, TipCamera, Pret, StatusDisponibilitate)
VALUES 
(1, '101', 'Deluxe Suite', 250.00, 'Disponibil'),
(2, '505', 'Standard Room', 200.00, 'Rezervat'),
(3, '303', 'Garden View Room', 190.00, 'Confirmat'),
(4, '808', 'Ocean View Room', 300.00, 'Disponibil');

select * from Camere;


-- 3. INREGISTRAREA UNUI CLIENT NOU

-- Inserarea unui client nou în tabela Clienti
INSERT INTO Clienti (Prenume, Nume, Adresa, Telefon, Email)
VALUES
('Ion', 'Popescu', 'Str Principala 123', '0720123456', 'ion.popescu@email.com'),
('Vasile', 'Ionescu', 'Str Nordului 50', '0740123456', 'vasile.ionescu@email.com'),
('Tudor', 'Constantin', 'Str Bucuresti 234', '0750123456', 'tudor.constantin@email.com'),
('Elena', 'Pop', 'Str. Marginasa 25', '0760123456', 'daniel.pop@meial.com'),
('Raluca', 'Ionescu', 'Str Nordului 50', '0740123457', 'raluca.ionescu@email.com'),
('Maria', 'Popescu', 'Str Principala 123', '0720123457', 'maria.popescu@email.com') ;

select * from Clienti;

-- 4. PROCESAREA UNEI REZERVARI

-- Inserarea unei rezervări noi în tabela Rezervari
INSERT INTO Rezervari (ClientID, CameraID, DataRezervare, DataCheckIn, DataCheckOut, Status)
VALUES 
(1, 1, CURDATE(), '2024-09-01', '2024-09-07', 'Confirmat'),
(2, 2, CURDATE(), '2024-10-01', '2024-10-08', 'Confirmat'),
(3, 3, CURDATE(), '2025-02-01', '2025-02-07', 'Confirmat'),
(4, 4, CURDATE(), '2024-12-24', '2025-01-02', 'Confirmat'),
(5, 2, CURDATE(), '2024-10-01', '2024-10-08', 'Confirmat'),
(6, 1, CURDATE(), '2024-09-01', '2024-09-07', 'Confirmat');

SELECT * FROM Rezervari;

-- Actualizarea statusului de disponibilitate al camerei
UPDATE Camere
SET StatusDisponibilitate = 'Rezervat'
WHERE CameraID = 1;

-- 5. PROCESAREA UNEI PLATI

-- Inserarea unei plăți noi în tabela Plati
INSERT INTO Plati (RezervareID, DataPlata, Suma, MetodaPlata)
VALUES 
(1, CURDATE(), 0.00, 'In asteptare'),
(2, CURDATE(), 1900.00, 'Card de credit'),
(3, CURDATE(), 2200.00, 'Card de credit'),
(4, CURDATE(), 2000.00, 'Card de credit'),
(5, CURDATE(), 1900.00, 'Card de credit'),
(6, CURDATE(), 0.00, 'In asteptare');

UPDATE Plati
SET DataPlata = '2025-01-10' 
WHERE RezervareId = 3;

-- Pentru a descrie tabela Plati:

DESC Plati;
SELECT * FROM Plati;

-- Sterge toata informatia in functie de instructiuni
 
DELETE FROM Plati WHERE Suma = "1750";
DELETE FROM Plati;

DELETE FROM Plati WHERE Suma BETWEEN 1900 AND 2000;


-- INSTRUCTIUNI DQL (Data Query Language):

-- 1. Vizualizarea detaliilor unei rezervări:

-- Interogarea pentru vizualizarea detaliilor unei rezervări
SELECT Rezervari.RezervareID, Clienti.Prenume, Clienti.Nume, Hoteluri.NumeHotel, Camere.NumarCamera, Camere.TipCamera, 
       Rezervari.DataCheckIn, Rezervari.DataCheckOut, Plati.Suma, Plati.DataPlata
FROM Rez	ervari
JOIN Clienti ON Rezervari.ClientID = Clienti.ClientID
JOIN Camere ON Rezervari.CameraID = Camere.CameraID
JOIN Hoteluri ON Camere.HotelID = Hoteluri.HotelID
LEFT JOIN Plati ON Rezervari.RezervareID = Plati.RezervareID
WHERE Rezervari.RezervareID = 2;

SELECT Rezervari.RezervareID, Clienti.Prenume, Clienti.Nume, Hoteluri.NumeHotel, Camere.NumarCamera, Camere.TipCamera, 
       Rezervari.DataCheckIn, Rezervari.DataCheckOut, Plati.Suma, Plati.DataPlata
FROM Rezervari
JOIN Clienti ON Rezervari.ClientID = Clienti.ClientID
JOIN Camere ON Rezervari.CameraID = Camere.CameraID
JOIN Hoteluri ON Camere.HotelID = Hoteluri.HotelID
CROSS JOIN Plati ON Rezervari.RezervareID = Plati.RezervareID
WHERE Rezervari.RezervareID = 3;


-- Afisarea unui rand sau coloane in functie de instructiune:

SELECT * FROM Plati;
SELECT * FROM Plati WHERE RezervareID = 1;
SELECT * FROM Plati WHERE Suma = 0;
SELECT * FROM Plati WHERE Suma >= 2000 or RezervareID = 6; 
SELECT * FROM Hoteluri;
SELECT * FROM Hoteluri WHERE Rating >4.5;
SELECT * FROM Hoteluri WHERE Descriere like '%lux%' and Locatie = 'Croatia';
SELECT * FROM Hoteluri WHERE Descriere like '%lux%' or Locatie = 'Croatia';

-- sortarea rezultatelor in ordine descendenta:

SELECT * FROM Plati ORDER BY Suma DESC;

-- sortarea rezultatelor in ordine ascendenta:

SELECT * FROM Plati ORDER BY Suma ASC;

SELECT * FROM Plati;
 UPDATE Plati SET MetodaPlata = 'Cash';
 UPDATE Plati SET MetodaPlata = 'Card de credit';
 
-- selectam din tabela Plati unde suma incepe cu 2;
 
SELECT * FROM Plati WHERE Suma like '2%';

-- selectam din tabela Clienti unde Nume contine cu pop;

SELECT * FROM Clienti WHERE Nume like '%pop%';

-- selectam din tabela Clienti unde Nume contine cu pop si nr de telefon se termina in '456';

SELECT * FROM Clienti WHERE Nume like '%pop%'and Telefon like '%456';

-- Gasirea de camere in anumite hoteluri specifice:

SELECT * FROM Camere;
SELECT * FROM Camere WHERE HotelID IN (1,2,3);

SELECT COUNT(CameraID) FROM Camere; -- numaram camerele
-- SELECT SUM(CameraID) FROM Camere; -- calculam suma parametrilor ceruti
-- SELECT SUM(CameraID) FROM Camere WHERE Pret like '2%';
SELECT SUM(Suma) FROM Plati WHERE Suma like '2%';
SELECT SUM(Suma) FROM Plati WHERE DataPlata like '2024%';

-- Afisarea tuturor coloanelor:
SELECT * FROM Rezervari;

-- Subinterogări (Subqueries):

-- 1. Găsirea hotelurilor cu camere disponibile:

-- Interogare pentru găsirea hotelurilor cu camere disponibile

SELECT Hoteluri.NumeHotel, Hoteluri.Locatie, COUNT(Camere.CameraID) AS CamereDisponibile
FROM Hoteluri
JOIN Camere ON Hoteluri.HotelID = Camere.HotelID
WHERE Camere.StatusDisponibilitate = 'Disponibil'
GROUP BY Hoteluri.HotelID;

-- 2. Găsirea clienților care au efectuat cel puțin o rezervare:

-- Interogare pentru găsirea clienților care au efectuat cel puțin o rezervare
	
SELECT Prenume, Nume, Email
FROM Clienti
WHERE ClientID IN (SELECT DISTINCT ClientID FROM Rezervari);

SELECT RezervareID, SUM(Suma) AS TotalPaid
FROM Plati
GROUP BY RezervareID;

-- Interogarea pentru vizualizarea detaliilor unei rezervări pentru clientii care nu au efectuat plata

SELECT Prenume, Nume, Email
FROM Clienti
JOIN Plati ON Clienti.ClientID = Plati.RezervareID
WHERE Plati.Suma = 0
GROUP BY Plati.RezervareID
ORDER BY RezervareID DESC;

-- Filtrarea datelor create de conditia GROUP BY folosing instructiunea HAVING 

SELECT NumarCamera, SUM(Pret) AS suma_totala
FROM Camere
GROUP BY NumarCamera
HAVING SUM(Pret) > 200;
