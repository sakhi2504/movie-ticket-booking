# 🎬 Movie Ticket Booking System (SQL Server)

A beginner-level database project that models a simple movie ticket booking
system using **Microsoft SQL Server**. Built as a learning project to
practice database design, relationships (foreign keys), and writing SQL
queries.

## 📌 Features

- Store movies, theaters, customers, shows, and bookings
- Book tickets for a show and automatically track available seats
- Run reporting queries: upcoming shows, customer booking history,
  nearly sold-out shows, total revenue, and bookings per movie

## 🗂️ Project Structure

```
movie-ticket-booking-system/
├── database/
│   └── schema.sql        # Full SQL script: creates DB, tables, sample data, queries
├── docs/
│   └── er-diagram.md     # Entity relationship overview
└── README.md
```

## 🧱 Database Design

The system has 5 tables:

| Table      | Purpose                                              |
|------------|-------------------------------------------------------|
| Movies     | Stores movie details (title, genre, language, etc.)  |
| Theaters   | Stores theater/cinema details                        |
| Customers  | Stores customer details                               |
| Shows      | Links a movie to a theater at a date/time, tracks seats |
| Bookings   | Records ticket bookings made by customers             |

See [`docs/er-diagram.md`](docs/er-diagram.md) for the relationship diagram.

## 🚀 How to Run

1. Install [SQL Server](https://www.microsoft.com/en-us/sql-server/sql-server-downloads) (or use a free edition like SQL Server Express) and [SSMS](https://learn.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms) (SQL Server Management Studio).
2. Open SSMS and connect to your local server.
3. Open `database/schema.sql`.
4. Click **Execute** (or press F5) to run the whole script.
5. This will create a database called `MovieBookingDB` with all tables, sample data, and demo queries.

## 📊 Example Queries

The script includes ready-to-run queries such as:

```sql
-- View all upcoming shows with movie and theater names
SELECT m.Title, t.Name AS Theater, s.ShowDate, s.ShowTime, s.TicketPrice, s.AvailableSeats
FROM Shows s
JOIN Movies m ON m.MovieId = s.MovieId
JOIN Theaters t ON t.TheaterId = s.TheaterId;
```

More examples are in `database/schema.sql`.

## 🔮 Possible Improvements

- Add seat-level booking (instead of just a seat count)
- Add a payments table
- Build a simple front-end (console app or web form) to interact with the database
- Add user authentication for customers

## 📄 License

This project is open source and available under the [MIT License](LICENSE).
