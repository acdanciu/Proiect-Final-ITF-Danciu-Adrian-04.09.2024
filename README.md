# Database Project for **Sistem de gestionare al rezervarilor hoteliere**

The purpose of this project is to use all the SQL knowledge gained throught the Software Testing course and apply them in practice.

**Application under test:** Gestiune_hoteluri.sql

**Tools used:** MySQL Workbench

**Database description:**

We will create a Hotel Reservation Management System to manage hotels, rooms, customers, reservations, and payments. This system will include functionalities for adding new hotels and rooms, registering new customers, processing reservations, and tracking payments.

**Database Schema**

You can find below the database schema that was generated through Reverse Engineer and which contains all the tables and the relationships between them.

The tables are connected in the following way:

- **Hoteluri** was implemented through **Hoteluri.HotelID** as a primary key 

- **Camere** was connected with **Hoteluri** through a **One to one** relationship which was implemented through **Camere.CameraID** as a primary key and **Hoteluri.HotelID** as a foreign key

- **Clienti** was implemented through *Clienti.ClientID** as a primary key 

- **Rezervari** is connected with **Clienti** and **Camere** through a **One to many** relationship which was implemented through **Rezervari.RezervareID** as a primary key and **Clienti.ClientID** pluse **Camere.CameraID** as foreign keys

- **Plati** was connected with **Rezervari** through a **One to one** relationship which was implemented through **Plati.PlataID** as a primary key and **Rezervari.RezervareID** as a foreign key

## Database Queries

### DDL (Data Definition Language)

The following instructions were written with the purpose of CREATING the structure of the database (CREATE INSTRUCTIONS):

```
CREATE TABLE Hoteluri (
    HotelID INT AUTO_INCREMENT PRIMARY KEY,
    NumeHotel VARCHAR(30),
    Locatie VARCHAR(20),
    Rating DECIMAL(2, 1),
    Descriere TEXT
);
```
```
CREATE TABLE Camere (
    CameraID INT AUTO_INCREMENT PRIMARY KEY,
    HotelID INT,
    NumarCamera VARCHAR(10),
    TipCamera VARCHAR(20),
    Pret DECIMAL(10, 2),
    StatusDisponibilitate VARCHAR(20),
    FOREIGN KEY (HotelID) REFERENCES Hoteluri(HotelID)
);
```
```
CREATE TABLE Clienti (
    ClientID INT AUTO_INCREMENT PRIMARY KEY,
    Prenume VARCHAR(20),
    Nume VARCHAR(20),
    Adresa VARCHAR(30),
    Telefon VARCHAR(15),
    Email VARCHAR(30)
);
```

```
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
```
```
CREATE TABLE Plati (
    PlataID INT AUTO_INCREMENT PRIMARY KEY,
    RezervareID INT,
    DataPlata DATE,
    Suma DECIMAL(10, 2),
    MetodaPlata VARCHAR(20),
    FOREIGN KEY (RezervareID) REFERENCES Rezervari(RezervareID)
);
```


#### After the database and the tables have been created, a few ALTER instructions were writtenin order to update the structure of the database, as described below:

```sql
# This instruction changes the variable type from 30 to 40 characters and add NOT NULL (cannot have a value of 0):

ALTER TABLE Hoteluri MODIFY NumeHotel VARCHAR(40) NOT NULL; 


# This instruction is adding one column to the table Hoteluri:

ALTER TABLE Hoteluri ADD COLUMN Recenzii VARCHAR (100);

# This instruction is deleting the column Recenzii from the table Hoteluri:

ALTER TABLE Hoteluri DROP COLUMN Recenzii; 

# This instruction is adding a foreign key to the table Plati:

ALTER TABLE Plati ADD FOREIGN KEY (ClientID) REFERENCES Clienti(ClientID);

```

### DML (Data Manipulation Language)
In order to be able to use the database I populated the tables with various data necessary in order to perform queries and manipulate the data. In the testing process, this necessary data is identified in the Test Design phase and created in the Test Implementation phase.

##### Below you can find all the insert instructions that were created in the scope of this project:

```
INSERT INTO Hoteluri (NumeHotel, Locatie, Rating, Descriere)
VALUES 
('Hotel Ocean View', 'Miami Beach, FL', 4.5, 'Un hotel frumos pe malul oceanului, cu vederi uimitoare.'),
('Hotel Marriott', 'Los Angeles, CA', 4.5, 'Un hotel elegant cu vedere la Pacific'),
('Hotel Fairmont', 'Maui, HI', 5.00, 'Un hotel de lux pe malul oceanului'),
('Hotel Morenia Beach Resort', 'Croatia', 4.3, 'Un hotel all inclusive, cu vedere la Marea Adriatica');
```
```
INSERT INTO Camere (HotelID, NumarCamera, TipCamera, Pret, StatusDisponibilitate)
VALUES 
(1, '101', 'Deluxe Suite', 250.00, 'Disponibil'),
(2, '505', 'Standard Room', 200.00, 'Rezervat'),
(3, '303', 'Garden View Room', 190.00, 'Confirmat'),
(4, '808', 'Ocean View Room', 300.00, 'Disponibil');
```

```
INSERT INTO Clienti (Prenume, Nume, Adresa, Telefon, Email, JoinDate)
VALUES
('Ion', 'Popescu', 'Str Principala 123', '0720123456', 'ion.popescu@email.com'),
('Vasile', 'Ionescu', 'Str Nordului 50', '0740123456', 'vasile.ionescu@email.com'),
('Tudor', 'Constantin', 'Str Bucuresti 234', '0750123456', 'tudor.constantin@email.com'),
('Elena', 'Pop', 'Str. Marginasa 25', '0760123456', 'daniel.pop@meial.com'),
('Raluca', 'Ionescu', 'Str Nordului 50', '0740123457', 'raluca.ionescu@email.com'),
('Maria', 'Popescu', 'Str Principala 123', '0720123457', 'maria.popescu@email.com');
```

```
ALTER TABLE Clienti
ADD COLUMN JoinDate DATE;
```

```
UPDATE Clienti SET JoinDate = '2022-02-01' WHERE ClientID = 1;
UPDATE Clienti SET JoinDate = '2022-08-01' WHERE ClientID = 2;
UPDATE Clienti SET JoinDate = '2024-02-01' WHERE ClientID = 3;
UPDATE Clienti SET JoinDate = '2024-08-01' WHERE ClientID = 4;
UPDATE Clienti SET JoinDate = '2024-04-01' WHERE ClientID = 5;
UPDATE Clienti SET JoinDate = '2023-02-01' WHERE ClientID = 6;
```

```
INSERT INTO Rezervari (ClientID, CameraID, DataRezervare, DataCheckIn, DataCheckOut, Status)
VALUES 
(1, 1, CURDATE(), '2024-09-01', '2024-09-07', 'Confirmat'),
(2, 2, CURDATE(), '2024-10-01', '2024-10-08', 'Confirmat'),
(3, 3, CURDATE(), '2025-02-01', '2025-02-07', 'Confirmat'),
(4, 4, CURDATE(), '2024-12-24', '2025-01-02', 'Confirmat'),
(5, 2, CURDATE(), '2024-10-01', '2024-10-08', 'Confirmat'),
(6, 1, CURDATE(), '2024-09-01', '2024-09-07', 'Confirmat');
```

```
INSERT INTO Plati (RezervareID, DataPlata, Suma, MetodaPlata)
VALUES 
(1, CURDATE(), 0.00, 'In asteptare'),
(2, CURDATE(), 1900.00, 'Card de credit'),
(3, CURDATE(), 2200.00, 'Card de credit'),
(4, CURDATE(), 2000.00, 'Card de credit'),
(5, CURDATE(), 1900.00, 'Card de credit'),
(6, CURDATE(), 0.00, 'In asteptare');
```

After the insert, in order to prepare the data to be better suited for the testing process, I have updated some data in the following way:

```sql
UPDATE Rezervari
SET Status = 'In asteptare'
WHERE RezervareID = '1';

UPDATE Rezervari
SET Status = 'In asteptare'
WHERE RezervareID = '6';

UPDATE Camere
SET StatusDisponibilitate = 'Rezervat'
WHERE CameraID = 1;

UPDATE Plati
SET DataPlata = '2025-01-10' 
WHERE RezervareId = 3;

UPDATE Plati SET MetodaPlata = 'Cash';
UPDATE Plati SET MetodaPlata = 'Card de credit';
```

### DQL (Data Query Language)

After the testing process, I deleted the data that was no longer relevant in order to preserve the database clean:

```sql
DELETE FROM Plati WHERE Suma = "1750";

DELETE FROM Plati WHERE Suma BETWEEN 1900 AND 2000;
```

##### In order to simulate various scenarios that might happen in real life I have created the following queries that would cover multiple potential real-life situations:

```sql
SELECT * FROM Plati;

# Finding payments where the Reservation ID is 1:

SELECT * FROM Plati WHERE RezervareID = 1;

# Finding payments where the amount is 0:

SELECT * FROM Plati WHERE Suma = 0;

# Finding payments where the amount is grater or equal to 2000 or the reservation ID is 6:

SELECT * FROM Plati WHERE Suma >= 2000 or RezervareID = 6; 

SELECT * FROM Hoteluri;

# Finding hotels with grater than 4.5 stars:

SELECT * FROM Hoteluri WHERE Rating >4.5;

# Finding hotels with description that contains the word "lux" and they are located in Croatia:

SELECT * FROM Hoteluri WHERE Descriere like '%lux%' and Locatie = 'Croatia';

# Finding hotels with description that contains the word "lux" or they are located in Croatia:

SELECT * FROM Hoteluri WHERE Descriere like '%lux%' or Locatie = 'Croatia';

# Results in descending order:

SELECT * FROM Plati ORDER BY Suma DESC;

# Finding payments where the amount starts with "2" (a hotel policy to offer a gift basket in the higher rates rooms)

SELECT * FROM Plati WHERE Suma like '2%';

# Finding names containing word "pop":

SELECT * FROM Clienti WHERE Nume like '%pop%';

# Finding names containing word "pop" with phone numbers ending in "456":

SELECT * FROM Clienti WHERE Nume like '%pop%' and Telefon like '%456';

# Finding rooms in certain hotels:

SELECT * FROM Camere WHERE HotelID IN (1,2,3);

# Count the number of rooms:

SELECT COUNT(CameraID) FROM Camere;

# Calculate the payments sum where payment year is 2024:

SELECT SUM(Suma) FROM Plati WHERE DataPlata like '2024%';  

# Filtering data created by the GROUP BY condition using the HAVING clause:

SELECT NumarCamera, SUM(Pret) AS suma_totala
FROM Camere
GROUP BY NumarCamera
HAVING SUM(Pret) > 200;
```

## Subqueries:

##### 1. Query to find hotels with available rooms
```
SELECT Hoteluri.NumeHotel, Hoteluri.Locatie, COUNT(Camere.CameraID) AS CamereDisponibile
FROM Hoteluri
JOIN Camere ON Hoteluri.HotelID = Camere.HotelID
WHERE Camere.StatusDisponibilitate = 'Disponibil'
GROUP BY Hoteluri.HotelID;
```
##### 2. Query to find customers who registered in the year 2023 or later, made a reservation in the year 2024 or later, and whose reservation status is 'Pending.':
```
SELECT Prenume, Nume, Email
FROM Clienti
WHERE ClientID IN 
(SELECT DISTINCT c.ClientID FROM Clienti c INNER JOIN Rezervari r
			on c.clientId = r.clientId
			WHERE extract(YEAR FROM c.JoinDate) >= 2023
			AND extract(YEAR FROM DataRezervare) >= 2024
			AND STATUS = "In Asteptare");
```

##### 3. Query to view the details of a reservation for customers who have not made a payment:
```
SELECT Prenume, Nume, Email
FROM Clienti
JOIN Plati ON Clienti.ClientID = Plati.RezervareID
WHERE Plati.Suma = 0
GROUP BY Plati.RezervareID
ORDER BY RezervareID DESC;
```

##### 4. Query to find the reservation details:
```
SELECT Rezervari.RezervareID, Clienti.Prenume, Clienti.Nume, Hoteluri.NumeHotel, Camere.NumarCamera, Camere.TipCamera, 
       Rezervari.DataCheckIn, Rezervari.DataCheckOut, Plati.Suma, Plati.DataPlata
FROM Rezervari
JOIN Clienti ON Rezervari.ClientID = Clienti.ClientID
JOIN Camere ON Rezervari.CameraID = Camere.CameraID
JOIN Hoteluri ON Camere.HotelID = Hoteluri.HotelID
LEFT JOIN Plati ON Rezervari.RezervareID = Plati.RezervareID
WHERE Rezervari.RezervareID = 2;
```

## Conclusion

This database project has been a valuable opportunity to apply theoretical knowledge to a practical scenario, reinforcing SQL concepts and skills. It serves as a foundation for further exploration and improvement in database design and management. The experience gained from this project contributes to a broader understanding of software development and database administration.

