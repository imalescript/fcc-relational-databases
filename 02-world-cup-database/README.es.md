# World Cup Database

[ English ](README.md) | [ Español ](README.es.md)

Un volcado de base de datos PostgreSQL para el proyecto **"World Cup Database"** de la **certificación de Bases de Datos Relacionales de freeCodeCamp**. Esta base de datos modela las tres últimas rondas del torneo de la Copa Mundial desde 2014, incluyendo los Cuartos de Final, Semifinales, partido por el Tercer Puesto y la Final de los torneos de 2014 y 2018.

---

## Descripción General

- **Diseño de tablas** con claves primarias, claves foráneas y restricciones únicas
- **Integridad referencial** en una jerarquía de 2 tablas (equipos → partidos)
- **Tipos de datos** incluyendo `integer`, `character varying` y `serial`
- **Secuencias autoincrementales** para claves sustitutas
- **Datos de muestra** con 24 equipos y 32 partidos de las Copas Mundiales de 2014 y 2018

---

## Esquema

### Diagrama Entidad-Relación

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

### Tablas

| Tabla | Filas | Clave Primaria | Claves Foráneas | Restricciones Únicas |
|-------|-------|----------------|-----------------|---------------------|
| `teams` | 24 | `team_id` | — | `name` |
| `games` | 32 | `game_id` | `winner_id → teams.team_id`<br>`opponent_id → teams.team_id` | — |

### Detalles de Columnas

#### `teams`
| Columna | Tipo | Nulo | Por defecto | Descripción |
|---------|------|------|-------------|-------------|
| `team_id` | `integer` | NO | `nextval('teams_team_id_seq')` | Clave sustituta |
| `name` | `character varying(255)` | NO | — | Nombre del equipo (único) |

#### `games`
| Columna | Tipo | Nulo | Por defecto | Descripción |
|---------|------|------|-------------|-------------|
| `game_id` | `integer` | NO | `nextval('games_game_id_seq')` | Clave sustituta |
| `year` | `integer` | NO | — | Año del torneo de la Copa Mundial |
| `round` | `character varying(255)` | NO | — | Ronda del torneo |
| `winner_id` | `integer` | NO | — | FK a `teams.team_id` |
| `opponent_id` | `integer` | NO | — | FK a `teams.team_id` |
| `winner_goals` | `integer` | NO | — | Goles anotados por el equipo ganador |
| `opponent_goals` | `integer` | NO | — | Goles anotados por el oponente |

---

## Datos de Muestra Destacados

### Equipos
- **Francia** – campeón de la Copa Mundial 2018
- **Croacia** – subcampeón de la Copa Mundial 2018
- **Alemania** – campeón de la Copa Mundial 2014
- **Argentina** – subcampeón de la Copa Mundial 2014
- **Brasil** – múltiples apariciones en el torneo
- **Bélgica**, **Inglaterra**, **Países Bajos**, y más (24 equipos en total)

### Partidos
- **Final 2018**: Francia 4 – 2 Croacia
- **Semifinal 2018**: Croacia 2 – 1 Inglaterra
- **Semifinal 2014**: Alemania 7 – 1 Brasil
- **Final 2014**: Alemania 1 – 0 Argentina

---

## Instalación / Uso

### Requisitos Previos
- [PostgreSQL](https://www.postgresql.org/download/) 12+

### Restaurar la Base de Datos

```bash
# Crear la base de datos y cargar el volcado
psql -U postgres -f worldcup.sql
```

O, si prefieres crear la base de datos por separado:

```bash
# 1. Crear la base de datos
createdb -U postgres worldcup

# 2. Cargar el esquema y los datos
psql -U postgres -d worldcup -f worldcup.sql
```

### Conectar y Explorar

```bash
psql -U freecodecamp -d worldcup
```

```sql
-- Listar todas las tablas
\dt
```

---

## Scripts

| Archivo | Descripción |
|---------|-------------|
| `games.csv` | Datos fuente: todos los partidos de las tres últimas rondas desde 2014 |
| `insert_data.sh` | Script para insertar todos los equipos y partidos en la base de datos |
| `queries.sh` | Script con consultas analíticas contra la base de datos worldcup |
| `worldcup.sql` | Volcado de base de datos PostgreSQL para reconstruir la base de datos worldcup |

---

## Créditos

Desarrollado como parte de la **Certificación de Bases de Datos Relacionales de freeCodeCamp**.  
Los datos incluyen resultados de las tres últimas rondas de la Copa Mundial de la FIFA de 2014 y 2018.

---

## Licencia

Este proyecto está licenciado bajo la Licencia MIT – consulta el archivo [LICENSE](../LICENSE) para más detalles.
