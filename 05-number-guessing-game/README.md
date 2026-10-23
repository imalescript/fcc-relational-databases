# Number Guessing Game

[ English ](README.md) | [ Español ](README.es.md)

A PostgreSQL database dump for the **freeCodeCamp Relational Database Certification** project "Number Guessing Game". This database tracks users and their guessing games, storing usernames and the number of guesses taken to find the secret number.

---

## Overview

- **Table design** with primary keys, foreign keys, and unique constraints
- **Referential integrity** across a 2-table hierarchy (users → games)
- **Data types** including `integer` and `character varying`
- **Sample data** — empty tables ready for gameplay

---

## Schema

### Entity Relationship Diagram

```
┌──────────────────┐         ┌──────────────────────┐
│      users       │         │       games          │
├──────────────────┤         ├──────────────────────┤
│ user_id (PK)     │───┐     │ game_id (PK)         │
│ username (UNIQUE)│   └─────┤ user_id (FK)         │
└──────────────────┘         │ number_of_guesses    │
                             └──────────────────────┘

user_id → users.user_id (FK)
```

### Tables

| Table | Rows | Primary Key | Foreign Keys | Unique Constraints |
|-------|------|-------------|--------------|-------------------|
| `users` | 0 | `user_id` | — | `username` |
| `games` | 0 | `game_id` | `user_id → users.user_id` | — |

### Column Details

#### `users`
| Column | Type | Nullable | Default | Description |
|--------|------|----------|---------|-------------|
| `user_id` | `integer` | NO | `nextval('users_user_id_seq')` | User ID (PK) |
| `username` | `character varying(22)` | NO | — | Username (unique) |

#### `games`
| Column | Type | Nullable | Default | Description |
|--------|------|----------|---------|-------------|
| `game_id` | `integer` | NO | `nextval('games_game_id_seq')` | Game ID (PK) |
| `user_id` | `integer` | NO | — | FK to `users.user_id` |
| `number_of_guesses` | `integer` | NO | — | Guesses taken to win |

---

## Sample Data Highlights

- **users** — new players are added automatically when they enter a username
- **games** — each completed game records the user and guess count
- The secret number is randomly chosen between 1 and 1000

---

## Installation / Usage

### Prerequisites
- [PostgreSQL](https://www.postgresql.org/download/) 12+
- Bash

### Restore the Database

```bash
# Create the database and load the dump
psql -U postgres -f number_guess.sql
```

Or, if you prefer to create the database separately:

```bash
# 1. Create the database
createdb -U postgres number_guess

# 2. Load the schema
psql -U postgres -d number_guess -f number_guess.sql
```

### Connect and Explore

```bash
psql -U freecodecamp -d number_guess
```

```sql
-- List all tables
\dt
```

---

## Scripts

| File | Description |
|------|-------------|
| `number_guess.sql` | PostgreSQL database dump to rebuild the number_guess database |
| `number_guess.sh` | Bash script that runs the number guessing game interactively |

---

## How to Play

Run the interactive script:

```bash
bash number_guess.sh
```

The game prompts for a username, tracks previous games, and asks you to guess a secret number between 1 and 1000. After each guess, it tells you whether the secret is higher or lower. When you guess correctly, it records your score.

---

## Credits

Developed as part of the **freeCodeCamp Relational Database Certification**.

---

## License

This project is licensed under the MIT License – see the [LICENSE](../LICENSE) file for details.
