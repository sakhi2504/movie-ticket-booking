# Entity Relationship Diagram

This diagram shows how the tables in the Movie Ticket Booking System relate
to each other. It renders automatically on GitHub since GitHub supports
Mermaid diagrams in markdown files.

```mermaid
erDiagram
    MOVIES ||--o{ SHOWS : "has"
    THEATERS ||--o{ SHOWS : "hosts"
    SHOWS ||--o{ BOOKINGS : "has"
    CUSTOMERS ||--o{ BOOKINGS : "makes"

    MOVIES {
        int MovieId PK
        varchar Title
        varchar Genre
        varchar Language
        int Duration
        varchar Rating
    }

    THEATERS {
        int TheaterId PK
        varchar Name
        varchar City
        int TotalSeats
    }

    CUSTOMERS {
        int CustomerId PK
        varchar Name
        varchar Email
        varchar Phone
    }

    SHOWS {
        int ShowId PK
        int MovieId FK
        int TheaterId FK
        date ShowDate
        time ShowTime
        decimal TicketPrice
        int AvailableSeats
    }

    BOOKINGS {
        int BookingId PK
        int CustomerId FK
        int ShowId FK
        int NumOfTickets
        decimal TotalAmount
        datetime BookingDate
    }
```

## Relationship Summary

- One **Movie** can have many **Shows** (different theaters/times)
- One **Theater** can host many **Shows**
- One **Show** can have many **Bookings**
- One **Customer** can make many **Bookings**
