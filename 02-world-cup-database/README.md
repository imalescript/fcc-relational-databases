# World Cup Database

[ English ](README.md) | [ Español ](README.es.md)

A PostgreSQL database dump for the **freeCodeCamp Relational Database Certification** project "World Cup Database". This database models the final three rounds of the World Cup tournament since 2014, including the Quarter-Finals, Semi-Finals, Third Place match, and Final for both the 2014 and 2018 tournaments.

---

## Overview

- **Table design** with primary keys, foreign keys, and unique constraints
- **Referential integrity** across a 2-table hierarchy (teams → games)
- **Data types** including `integer`, `character varying`, and `serial`
- **Auto-incrementing sequences** for surrogate keys
- **Sample data** with 24 teams and 32 games from the 2014 and 2018 World Cups

---

## Schema

### Entity Relationship Diagram

```
┌──────────────┐               ┌────────────────┐
│   teams      │               │   games        │
├──────────────┤               ├────────────────┤
│ team_id (PK) │──┐            │ game_id (PK)   │
│ name         │  └───┐        │ winner_id  ─┐  │
└──────────────┘      └────────┤ opponent_id ┘  │
                               │ winner_goals   │
                               │ opponent_goals │
                               │ year           │
                               │ round          │
                               └────────────────┘

winner_id → teams.team_id (FK)
opponent_id → teams.team_id (FK)
```

### Tables

| Table | Rows | Primary Key | Foreign Keys | Unique Constraints |
|-------|------|-------------|--------------|-------------------|
| `teams` | 24 | `team_id` | — | `name` |
| `games` | 32 | `game_id` | `winner_id → teams.team_id`<br>`opponent_id → teams.team_id` | — |

### Column Details

#### `teams`
| Column | Type | Nullable | Default | Description |
|--------|------|----------|---------|-------------|
| `team_id` | `integer` | NO | `nextval('teams_team_id_seq')` | Surrogate key |
| `name` | `character varying(255)` | NO | — | Team name (unique) |

#### `games`
| Column | Type | Nullable | Default | Description |
|--------|------|----------|---------|-------------|
| `game_id` | `integer` | NO | `nextval('games_game_id_seq')` | Surrogate key |
| `year` | `integer` | NO | — | Year of the World Cup tournament |
| `round` | `character varying(255)` | NO | — | Round of the tournament |
| `winner_id` | `integer` | NO | — | FK to `teams.team_id` |
| `opponent_id` | `integer` | NO | — | FK to `teams.team_id` |
| `winner_goals` | `integer` | NO | — | Goals scored by the winning team |
| `opponent_goals` | `integer` | NO | — | Goals scored by the opponent |

---

## Sample Data Highlights

### Teams
- **France** – 2018 World Cup champion
- **Croatia** – 2018 World Cup runner-up
- **Germany** – 2014 World Cup champion
- **Argentina** – 2014 World Cup runner-up
- **Brazil** – multiple tournament appearances
- **Belgium**, **England**, **Netherlands**, and more (24 teams total)

### Games
- **2018 Final**: France 4 – 2 Croatia
- **2018 Semi-Final**: Croatia 2 – 1 England
- **2014 Semi-Final**: Germany 7 – 1 Brazil
- **2014 Final**: Germany 1 – 0 Argentina

---

## Installation / Usage

### Prerequisites
- [PostgreSQL](https://www.postgresql.org/download/) 12+

### Restore the Database

```bash
# Create the database and load the dump
psql -U postgres -f worldcup.sql
```

Or, if you prefer to create the database separately:

```bash
# 1. Create the database
createdb -U postgres worldcup

# 2. Load the schema and data
psql -U postgres -d worldcup -f worldcup.sql
```

### Connect and Explore

```bash
psql -U freecodecamp -d worldcup
```

```sql
-- List all tables
\dt
```

---

## Scripts

| File | Description |
|------|-------------|
| `games.csv` | Source data: all games from the final three rounds since 2014 |
| `insert_data.sh` | Script to insert all teams and games data into the database |
| `queries.sh` | Script containing analytical queries against the worldcup database |
| `worldcup.sql` | PostgreSQL database dump to rebuild the worldcup database |

---

## Credits

Developed as part of the **freeCodeCamp Relational Database Certification**.  
The data includes results from the 2014 and 2018 FIFA World Cup final three rounds.

---

## License

This project is licensed under the MIT License – see the [LICENSE](../LICENSE) file for details.
