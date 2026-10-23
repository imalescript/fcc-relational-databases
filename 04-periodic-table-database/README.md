# Periodic Table Database

[ English ](README.md) | [ Español ](README.es.md)

A PostgreSQL database dump for the **freeCodeCamp Relational Database Certification** project "Periodic Table Database". This database stores information about chemical elements, including atomic number, symbol, name, atomic mass, melting and boiling points, and element type.

---

## Overview

- **Table design** with primary keys, foreign keys, and unique constraints
- **Referential integrity** across a 3-table hierarchy (elements → properties → types)
- **Data types** including `integer`, `character varying`, `numeric`, and `real`
- **Sample data** with 10 elements and 3 element types (metal, metalloid, nonmetal)

---

## Schema

### Entity Relationship Diagram

```
┌────────────────┐         ┌──────────────────────┐         ┌────────────────┐
│    elements    │         │      properties      │         │     types      │
├────────────────┤         ├──────────────────────┤         ├────────────────┤
│ atomic_number  │───┐     │ atomic_number        │───┐     │ type_id (PK)   │
│ symbol (UNIQUE)│   └─────┤ atomic_mass          │   └─────┤ type (NOT NULL)│
│ name (UNIQUE)  │         │ melting_point_celsius│         └────────────────┘
└────────────────┘         │ boiling_point_celsius│
                           │ type_id (FK)         │
                           └──────────────────────┘

type_id → types.type_id (FK)
```

### Tables

| Table | Rows | Primary Key | Foreign Keys | Unique Constraints |
|-------|------|-------------|--------------|-------------------|
| `elements` | 10 | `atomic_number` | — | `symbol`, `name` |
| `properties` | 10 | `atomic_number` | `atomic_number → elements.atomic_number`<br>`type_id → types.type_id` | `atomic_number` |
| `types` | 3 | `type_id` | — | — |

### Column Details

#### `elements`
| Column | Type | Nullable | Default | Description |
|--------|------|----------|---------|-------------|
| `atomic_number` | `integer` | NO | — | Atomic number (PK) |
| `symbol` | `character varying(2)` | NO | — | Chemical symbol (unique) |
| `name` | `character varying(40)` | NO | — | Element name (unique) |

#### `properties`
| Column | Type | Nullable | Default | Description |
|--------|------|----------|---------|-------------|
| `atomic_number` | `integer` | NO | — | FK to `elements.atomic_number` |
| `atomic_mass` | `real` | NO | — | Atomic mass in amu |
| `melting_point_celsius` | `numeric` | NO | — | Melting point in °C |
| `boiling_point_celsius` | `numeric` | NO | — | Boiling point in °C |
| `type_id` | `integer` | NO | — | FK to `types.type_id` |

#### `types`
| Column | Type | Nullable | Default | Description |
|--------|------|----------|---------|-------------|
| `type_id` | `integer` | NO | `nextval('types_type_id_seq')` | Surrogate key |
| `type` | `character varying(30)` | NO | — | Element type |

---

## Sample Data Highlights

### Elements
- **Hydrogen (H)** – atomic number 1, nonmetal
- **Helium (He)** – atomic number 2, nonmetal
- **Lithium (Li)** – atomic number 3, metal
- **Fluorine (F)** – atomic number 9, nonmetal
- **Neon (Ne)** – atomic number 10, nonmetal

### Types
- **metal** – elements that are metals
- **metalloid** – elements with intermediate properties
- **nonmetal** – elements that are nonmetals

---

## Installation / Usage

### Prerequisites
- [PostgreSQL](https://www.postgresql.org/download/) 12+

### Restore the Database

```bash
# Create the database and load the dump
psql -U postgres -f periodic_table.sql
```

Or, if you prefer to create the database separately:

```bash
# 1. Create the database
createdb -U postgres periodic_table

# 2. Load the schema and data
psql -U postgres -d periodic_table -f periodic_table.sql
```

### Connect and Explore

```bash
psql -U freecodecamp -d periodic_table
```

```sql
-- List all tables
\dt
```

---

## Scripts

| File | Description |
|------|-------------|
| `periodic_table.sql` | PostgreSQL database dump to rebuild the periodic_table database |
| `element.sh` | Bash script to query element information by atomic number, symbol, or name |

---

## Credits

Developed as part of the **freeCodeCamp Relational Database Certification**.

---

## License

This project is licensed under the MIT License – see the [LICENSE](../LICENSE) file for details.
