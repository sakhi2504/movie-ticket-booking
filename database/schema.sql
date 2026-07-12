
-- Movie Ticket Booking System
-- Microsoft SQL Server


CREATE DATABASE MovieBookingDB;
GO

USE MovieBookingDB;
GO

-- 1. MOVIES TABLE - Stores basic info about each movie

CREATE TABLE Movies (
    MovieId     INT IDENTITY(1,1) PRIMARY KEY,
    Title       VARCHAR(100) NOT NULL,
    Genre       VARCHAR(50),
    Language    VARCHAR(30),
    Duration    INT,              -- duration in minutes
    Rating      VARCHAR(10)       -- e.g. U, UA, A
);
GO

-- 2. THEATERS TABLE - Stores basic info about each theater/cinema

CREATE TABLE Theaters (
    TheaterId   INT IDENTITY(1,1) PRIMARY KEY,
    Name        VARCHAR(100) NOT NULL,
    City        VARCHAR(50),
    TotalSeats  INT NOT NULL
);
GO

-- 3. CUSTOMERS TABLE - Stores info about people booking tickets

CREATE TABLE Customers (
    CustomerId  INT IDENTITY(1,1) PRIMARY KEY,
    Name        VARCHAR(100) NOT NULL,
    Email       VARCHAR(100),
    Phone       VARCHAR(15)
);
GO


-- 4. SHOWS TABLE - Links a movie to a theater at a specific date/time, and tracks how many seats are still available

CREATE TABLE Shows (
    ShowId          INT IDENTITY(1,1) PRIMARY KEY,
    MovieId         INT NOT NULL,
    TheaterId       INT NOT NULL,
    ShowDate        DATE NOT NULL,
    ShowTime        TIME NOT NULL,
    TicketPrice     DECIMAL(8,2) NOT NULL,
    AvailableSeats  INT NOT NULL,
    FOREIGN KEY (MovieId) REFERENCES Movies(MovieId),
    FOREIGN KEY (TheaterId) REFERENCES Theaters(TheaterId)
);
GO


-- 5. BOOKINGS TABLE - Records each ticket booking made by a customer

CREATE TABLE Bookings (
    BookingId       INT IDENTITY(1,1) PRIMARY KEY,
    CustomerId      INT NOT NULL,
    ShowId          INT NOT NULL,
    NumOfTickets    INT NOT NULL,
    TotalAmount     DECIMAL(8,2) NOT NULL,
    BookingDate     DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CustomerId) REFERENCES Customers(CustomerId),
    FOREIGN KEY (ShowId) REFERENCES Shows(ShowId)
);
GO

-- SAMPLE DATA

INSERT INTO Movies (Title, Genre, Language, Duration, Rating) VALUES
('Skyline Horizon', 'Sci-Fi', 'English', 148, 'UA'),
('The Last Village', 'Drama', 'Hindi', 132, 'U');

INSERT INTO Theaters (Name, City, TotalSeats) VALUES
('CineMax Downtown', 'Pune', 100),
('StarView Cinemas', 'Pune', 80);

INSERT INTO Customers (Name, Email, Phone) VALUES
('Aarav Sharma', 'aarav@example.com', '9876543210'),
('Isha Verma', 'isha@example.com', '9876543211');

INSERT INTO Shows (MovieId, TheaterId, ShowDate, ShowTime, TicketPrice, AvailableSeats) VALUES
(1, 1, '2026-07-15', '18:30:00', 250.00, 100),
(2, 2, '2026-07-15', '20:00:00', 200.00, 80);
GO

-- EXAMPLE: Book 2 tickets for Show 1

-- Step 1: Insert the booking
INSERT INTO Bookings (CustomerId, ShowId, NumOfTickets, TotalAmount)
VALUES (1, 1, 2, 500.00);

-- Step 2: Reduce the available seat count for that show
UPDATE Shows
SET AvailableSeats = AvailableSeats - 2
WHERE ShowId = 1;
GO

-- USEFUL QUERIES 

-- 1. View all upcoming shows with movie and theater names
SELECT m.Title, t.Name AS Theater, s.ShowDate, s.ShowTime, s.TicketPrice, s.AvailableSeats
FROM Shows s
JOIN Movies m ON m.MovieId = s.MovieId
JOIN Theaters t ON t.TheaterId = s.TheaterId;
GO

-- 2. View all bookings made by a specific customer
SELECT b.BookingId, c.Name, m.Title, s.ShowDate, s.ShowTime, b.NumOfTickets, b.TotalAmount
FROM Bookings b
JOIN Customers c ON c.CustomerId = b.CustomerId
JOIN Shows s ON s.ShowId = b.ShowId
JOIN Movies m ON m.MovieId = s.MovieId
WHERE c.CustomerId = 1;
GO

-- 3. Find shows that are almost full (less than 10 seats left)
SELECT m.Title, s.ShowDate, s.ShowTime, s.AvailableSeats
FROM Shows s
JOIN Movies m ON m.MovieId = s.MovieId
WHERE s.AvailableSeats < 10;
GO

-- 4. Total revenue collected so far
SELECT SUM(TotalAmount) AS TotalRevenue FROM Bookings;
GO

-- 5. Number of bookings per movie
SELECT m.Title, COUNT(b.BookingId) AS TotalBookings
FROM Bookings b
JOIN Shows s ON s.ShowId = b.ShowId
JOIN Movies m ON m.MovieId = s.MovieId
GROUP BY m.Title;
GO
