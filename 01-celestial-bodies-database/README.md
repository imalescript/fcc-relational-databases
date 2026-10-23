# Celestial Bodies Database

[ English ](README.md) | [ Español ](README.es.md)

A PostgreSQL database dump for the **freeCodeCamp Relational Database Certification** project "Celestial Bodies Database". This database models a cosmic horror-themed universe with galaxies, stars, planets, moons, and anomalies — all referencing Lovecraftian lore.

---

## Overview

- **Table design** with primary keys, foreign keys, and unique constraints
- **Referential integrity** across a 5-table hierarchy (Galaxy → Star → Planet → Moon, plus standalone Anomaly)
- **Data types** including `integer`, `numeric`, `boolean`, `character varying`, and `text`
- **Auto-incrementing sequences** for surrogate keys
- **Sample data** with 6 galaxies, 6 stars, 12 planets, 20 moons, and 3 anomalies

---

## Schema

### Entity Relationship Diagram

```
┌─────────────┐       ┌─────────────┐       ┌─────────────┐       ┌─────────────┐
│   Galaxy    │       │    Star     │       │   Planet    │       │    Moon     │
├─────────────┤       ├─────────────┤       ├─────────────┤       ├─────────────┤
│ galaxy_id   │◄──────│ galaxy_id   │       │             │       │             │
│ name        │       │ star_id     │◄──────│ star_id     │       │             │
│ distance_...│       │ name        │       │ planet_id   │◄──────│ planet_id   │
│ has_life    │       │ is_dormant  │       │ name        │       │ moon_id     │
│ madness_... │       │ age_in_...  │       │ has_cult    │       │ name        │
└─────────────┘       └─────────────┘       │ planet_type │       │ is_cursed   │
                                            └─────────────┘       │ orbital_... │
                                                                  └─────────────┘

┌─────────────┐
│  Anomaly    │   (standalone table, no FK relationships)
├─────────────┤
│ anomaly_id  │
│ name        │
│ description │
└─────────────┘
```

### Tables

| Table | Rows | Primary Key | Foreign Keys | Unique Constraints |
|-------|------|-------------|--------------|-------------------|
| `galaxy` | 6 | `galaxy_id` | — | `name` |
| `star` | 6 | `star_id` | `galaxy_id → galaxy.galaxy_id` | `name` |
| `planet` | 12 | `planet_id` | `star_id → star.star_id` | `name` |
| `moon` | 20 | `moon_id` | `planet_id → planet.planet_id` | `name` |
| `anomaly` | 3 | `anomaly_id` | — | `name` |

### Column Details

#### `galaxy`
| Column | Type | Nullable | Default | Description |
|--------|------|----------|---------|-------------|
| `galaxy_id` | `integer` | NO | `nextval('galaxy_galaxy_id_seq')` | Surrogate key |
| `name` | `character varying(255)` | NO | — | Galaxy name (unique) |
| `distance_from_earth` | `numeric` | NO | — | Distance in light-years (fictional) |
| `has_life` | `boolean` | NO | — | Whether the galaxy harbors life |
| `madness_level` | `integer` | YES | — | Cosmic horror intensity (0–100) |

#### `star`
| Column | Type | Nullable | Default | Description |
|--------|------|----------|---------|-------------|
| `star_id` | `integer` | NO | `nextval('star_star_id_seq')` | Surrogate key |
| `name` | `character varying(255)` | NO | — | Star name (unique) |
| `is_dormant` | `boolean` | NO | — | Whether the star is dormant |
| `age_in_millions_of_years` | `integer` | YES | — | Stellar age |
| `galaxy_id` | `integer` | YES | — | FK to `galaxy.galaxy_id` |

#### `planet`
| Column | Type | Nullable | Default | Description |
|--------|------|----------|---------|-------------|
| `planet_id` | `integer` | NO | `nextval('planet_planet_id_seq')` | Surrogate key |
| `name` | `character varying(255)` | NO | — | Planet name (unique) |
| `has_cult` | `boolean` | NO | — | Whether a cult worships this planet |
| `planet_type` | `character varying(100)` | YES | — | Classification (e.g., Ice Rock, Gas Giant, Oceanic) |
| `star_id` | `integer` | YES | — | FK to `star.star_id` |

#### `moon`
| Column | Type | Nullable | Default | Description |
|--------|------|----------|---------|-------------|
| `moon_id` | `integer` | NO | `nextval('moon_moon_id_seq')` | Surrogate key |
| `name` | `character varying(255)` | NO | — | Moon name (unique) |
| `is_cursed` | `boolean` | NO | — | Whether the moon is cursed |
| `orbital_period_days` | `integer` | YES | — | Orbital period in days |
| `planet_id` | `integer` | YES | — | FK to `planet.planet_id` |

#### `anomaly`
| Column | Type | Nullable | Default | Description |
|--------|------|----------|---------|-------------|
| `anomaly_id` | `integer` | NO | `nextval('anomaly_anomaly_id_seq')` | Surrogate key |
| `name` | `character varying(255)` | NO | — | Anomaly name (unique) |
| `description` | `text` | NO | — | Description of the cosmic anomaly |

---

## Sample Data Highlights

### Galaxies
- **Void-of-Rlyeh** – 1,000.5 ly, has life, madness level 99
- **End-of-Reason** – 2,500 ly, no life, madness level 80
- **Azathoth-Dream** – 10,000.1 ly, no life, madness level 100 (maximum)

### Stars
- **Azathoth-Eye** (dormant, 5,000 Myr) in Void-of-Rlyeh
- **Dormant Ember** (dormant, 8,000 Myr) in Azathoth-Dream
- **Silent Flare** (dormant, 4,000 Myr) in Forgotten Cosmos

### Planets
- **Yuggoth-Prime** (Ice Rock, has cult) orbiting Azathoth-Eye
- **Innsmouth-Sphere** (Oceanic, has cult) orbiting Dormant Ember
- **Ulthar-Mass** (Forest, has cult) orbiting Silent Flare

### Anomalies
1. **Euclidean Distortion** – Space bends at impossible angles, driving observers mad.
2. **Whisper Resonance** – Background radiation sounds like ancient, forbidden tongues.
3. **Abyssal Rift** – A tear in the fabric of space leaking dark matter.

---

## Installation / Usage

### Prerequisites
- [PostgreSQL](https://www.postgresql.org/download/) 12+

### Restore the Database

```bash
# Create the database and load the dump
psql -U postgres -f universe.sql
```

Or, if you prefer to create the database separately:

```bash
# 1. Create the database
createdb -U postgres universe

# 2. Load the schema and data
psql -U postgres -d universe -f universe.sql
```

### Connect and Explore

```bash
psql -U postgres -d universe
```

```sql
-- List all tables
\dt
```

---

## Credits

Developed as part of the **freeCodeCamp Relational Database Certification**.  
The cosmic horror theme and naming are original creative choices for the project.

---

## License

This project is licensed under the MIT License – see the [LICENSE](../LICENSE) file for details.