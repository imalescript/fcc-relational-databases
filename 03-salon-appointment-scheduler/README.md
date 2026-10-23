# Salon Appointment Scheduler

A PostgreSQL database and CLI application for managing salon appointments. This project implements the **freeCodeCamp Relational Database Certification** requirements for creating a database schema, inserting data, and providing a user-facing script for booking appointments.

---

## Overview

- **Database schema** with tables for customers, appointments, and services
- **Primary and foreign keys** with proper constraints and relationships
- **Auto-incrementing sequences** for surrogate keys
- **CLI script** for customers to book appointments interactively
- **Sample data** with multiple services and appointment history

---

## Schema

### Entity Relationship Diagram

```
┌──────────────┐              ┌────────────────┐
│   customers  │              │   appointments │
├──────────────┤              ├────────────────┤
│ customer_id  │──┐           │ appointment_id │
│ phone        │  └───┐       │ customer_id ─┐ │
│ name         │      └───────┤ service_id ──┘ │
└──────────────┘              │ time           │
                              └────────────────┘

customer_id → customers.customer_id (FK)
service_id → services.service_id (FK)
```

### Tables

| Table | Rows | Primary Key | Foreign Keys | Unique Constraints |
|-------|------|-------------|--------------|-------------------|
| `customers` | TBD | `customer_id` | — | `phone` |
| `appointments` | TBD | `appointment_id` | `customer_id → customers.customer_id`<br>`service_id → services.service_id` | — |
| `services` | 5 | `service_id` | — | — |

### Column Details

#### `customers`

| Column | Type | Nullable | Default | Description |
|--------|------|----------|---------|-------------|
| `customer_id` | `integer` | NO | `nextval('customers_customer_id_seq')` | Surrogate key |
| `phone` | `character varying(20)` | NO | — | Phone number (unique) |
| `name` | `character varying(50)` | NO | — | Customer name |

#### `appointments`

| Column | Type | Nullable | Default | Description |
|--------|------|----------|---------|-------------|
| `appointment_id` | `integer` | NO | `nextval('appointments_appointment_id_seq')` | Surrogate key |
| `customer_id` | `integer` | NO | — | FK to `customers.customer_id` |
| `service_id` | `integer` | NO | — | FK to `services.service_id` |
| `time` | `character varying(20)` | NO | — | Appointment time |

#### `services`

| Column | Type | Nullable | Default | Description |
|--------|------|----------|---------|-------------|
| `service_id` | `integer` | NO | `nextval('services_service_id_seq')` | Surrogate key |
| `name` | `character varying(50)` | NO | — | Service name |

---

## Sample Data

### Services

- **1.** cut
- **2.** color
- **3.** perm
- **4.** style
- **5.** trim

### Customers

| customer_id | phone | name |
|-------------|-------|------|
| 1 | 555-555-5555 | Fabio |

### Appointments

| appointment_id | customer_id | service_id | time |
|---------------|-------------|------------|------|
| 1 | 1 | 1 | 10:30 |

---

## Installation / Usage

### Prerequisites

- [PostgreSQL](https://www.postgresql.org/download/) 12+
- `psql` command-line client

### Restore the Database

```bash
# Create the database and load the dump
psql -U postgres -f salon.sql
```

Or, if you prefer to create the database separately:

```bash
# 1. Create the database
createdb -U postgres salon

# 2. Load the schema and data
psql -U postgres -d salon -f salon.sql
```

### Connect and Explore

```bash
psql -U freecodecamp -d salon
```

```sql
-- List all tables
\dt

-- View customers
SELECT * FROM customers;

-- View appointments
SELECT * FROM appointments;

-- View services
SELECT * FROM services;
```

---

## Scripts

| File | Description |
|------|-------------|
| `salon.sh` | CLI script for customers to book appointments |
| `salon.sql` | PostgreSQL database dump to rebuild the salon database |

---

## Usage

The `salon.sh` script allows customers to:

1. View available services
2. Select a service by ID
3. Enter their phone number
4. Provide their name (if not in database)
5. Specify appointment time
6. Confirm the appointment

Example session flow:

```
~~~~~ MY SALON ~~~~~

Welcome to My Salon, how can I help you?
1) cut
2) color
3) perm
4) style
5) trim
2

What's your phone number?
555-555-5555

What time would you like your color?
11am

I have put you down for a color at 11am.
```

---

## Credits

Developed as part of the **freeCodeCamp Relational Database Certification**.  
The database schema and application are designed to meet the certification requirements for creating normalized relational databases with proper constraints.

---

## License

This project is licensed under the MIT License – see the [LICENSE](../LICENSE) file for details.