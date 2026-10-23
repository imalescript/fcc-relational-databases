# Celestial Bodies Database

[ English ](README.md) | [ Español ](README.es.md)

Un volcado de base de datos PostgreSQL para el proyecto **"Celestial Bodies Database"** de la **certificación de Bases de Datos Relacionales de freeCodeCamp**. Esta base de datos modela un universo de horror cósmico con galaxias, estrellas, planetas, lunas y anomalías, todas referenciando la mitología de Lovecraft.

---

## Descripción General

- **Diseño de tablas** con claves primarias, claves foráneas y restricciones únicas
- **Integridad referencial** en una jerarquía de 5 tablas (Galaxia → Estrella → Planeta → Luna, más Anomalía independiente)
- **Tipos de datos** incluyendo `integer`, `numeric`, `boolean`, `character varying` y `text`
- **Secuencias autoincrementales** para claves sustitutas
- **Datos de muestra** con 6 galaxias, 6 estrellas, 12 planetas, 20 lunas y 3 anomalías

---

## Esquema

### Diagrama Entidad-Relación

```
┌─────────────┐       ┌─────────────┐       ┌─────────────┐       ┌─────────────┐
│   Galaxia   │       │   Estrella  │       │  Planeta    │       │    Luna     │
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
│  Anomalía   │   (tabla independiente, sin relaciones FK)
├─────────────┤
│ anomaly_id  │
│ name        │
│ description │
└─────────────┘
```

### Tablas

| Tabla | Filas | Clave Primaria | Claves Foráneas | Restricciones Únicas |
|-------|-------|----------------|-----------------|---------------------|
| `galaxy` | 6 | `galaxy_id` | — | `name` |
| `star` | 6 | `star_id` | `galaxy_id → galaxy.galaxy_id` | `name` |
| `planet` | 12 | `planet_id` | `star_id → star.star_id` | `name` |
| `moon` | 20 | `moon_id` | `planet_id → planet.planet_id` | `name` |
| `anomaly` | 3 | `anomaly_id` | — | `name` |

### Detalles de Columnas

#### `galaxy`
| Columna | Tipo | Nulo | Por defecto | Descripción |
|---------|------|------|-------------|-------------|
| `galaxy_id` | `integer` | NO | `nextval('galaxy_galaxy_id_seq')` | Clave sustituta |
| `name` | `character varying(255)` | NO | — | Nombre de la galaxia (único) |
| `distance_from_earth` | `numeric` | NO | — | Distancia en años luz (ficticia) |
| `has_life` | `boolean` | NO | — | Si la galaxia alberga vida |
| `madness_level` | `integer` | SÍ | — | Intensidad de horror cósmico (0–100) |

#### `star`
| Columna | Tipo | Nulo | Por defecto | Descripción |
|---------|------|------|-------------|-------------|
| `star_id` | `integer` | NO | `nextval('star_star_id_seq')` | Clave sustituta |
| `name` | `character varying(255)` | NO | — | Nombre de la estrella (único) |
| `is_dormant` | `boolean` | NO | — | Si la estrella está dormida |
| `age_in_millions_of_years` | `integer` | SÍ | — | Edad estelar |
| `galaxy_id` | `integer` | SÍ | — | FK a `galaxy.galaxy_id` |

#### `planet`
| Columna | Tipo | Nulo | Por defecto | Descripción |
|---------|------|------|-------------|-------------|
| `planet_id` | `integer` | NO | `nextval('planet_planet_id_seq')` | Clave sustituta |
| `name` | `character varying(255)` | NO | — | Nombre del planeta (único) |
| `has_cult` | `boolean` | NO | — | Si un culto venera este planeta |
| `planet_type` | `character varying(100)` | SÍ | — | Clasificación (ej. Ice Rock, Gas Giant, Oceanic) |
| `star_id` | `integer` | SÍ | — | FK a `star.star_id` |

#### `moon`
| Columna | Tipo | Nulo | Por defecto | Descripción |
|---------|------|------|-------------|-------------|
| `moon_id` | `integer` | NO | `nextval('moon_moon_id_seq')` | Clave sustituta |
| `name` | `character varying(255)` | NO | — | Nombre de la luna (único) |
| `is_cursed` | `boolean` | NO | — | Si la luna está maldita |
| `orbital_period_days` | `integer` | SÍ | — | Período orbital en días |
| `planet_id` | `integer` | SÍ | — | FK a `planet.planet_id` |

#### `anomaly`
| Columna | Tipo | Nulo | Por defecto | Descripción |
|---------|------|------|-------------|-------------|
| `anomaly_id` | `integer` | NO | `nextval('anomaly_anomaly_id_seq')` | Clave sustituta |
| `name` | `character varying(255)` | NO | — | Nombre de la anomalía (único) |
| `description` | `text` | NO | — | Descripción de la anomalía cósmica |

---

## Datos de Muestra Destacados

### Galaxias
- **Void-of-Rlyeh** – 1.000,5 al, tiene vida, nivel de locura 99
- **End-of-Reason** – 2.500 al, sin vida, nivel de locura 80
- **Azathoth-Dream** – 10.000,1 al, sin vida, nivel de locura 100 (máximo)

### Estrellas
- **Azathoth-Eye** (dormida, 5.000 Ma) en Void-of-Rlyeh
- **Dormant Ember** (dormida, 8.000 Ma) en Azathoth-Dream
- **Silent Flare** (dormida, 4.000 Ma) en Forgotten Cosmos

### Planetas
- **Yuggoth-Prime** (Roca de Hielo, tiene culto) orbitando Azathoth-Eye
- **Innsmouth-Sphere** (Oceánico, tiene culto) orbitando Dormant Ember
- **Ulthar-Mass** (Bosque, tiene culto) orbitando Silent Flare

### Anomalías
1. **Euclidean Distortion** – El espacio se dobla en ángulos imposibles, volviendo locos a los observadores.
2. **Whisper Resonance** – La radiación de fondo suena como lenguas antiguas y prohibidas.
3. **Abyssal Rift** – Un desgarro en el tejido del espacio que filtra materia oscura.

---

## Instalación / Uso

### Requisitos Previos
- [PostgreSQL](https://www.postgresql.org/download/) 12+

### Restaurar la Base de Datos

```bash
# Crear la base de datos y cargar el volcado
psql -U postgres -f universe.sql
```

O, si prefieres crear la base de datos por separado:

```bash
# 1. Crear la base de datos
createdb -U postgres universe

# 2. Cargar el esquema y los datos
psql -U postgres -d universe -f universe.sql
```

### Conectar y Explorar

```bash
psql -U postgres -d universe
```

```sql
-- Listar todas las tablas
\dt
```

---

## Créditos

Desarrollado como parte de la **Certificación de Bases de Datos Relacionales de freeCodeCamp**.  
El tema de horror cósmico y la nomenclatura son elecciones creativas originales para el proyecto.

---

## Licencia

Este proyecto está licenciado bajo la Licencia MIT – consulta el archivo [LICENSE](../LICENSE) para más detalles.