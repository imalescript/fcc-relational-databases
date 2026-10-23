# Number Guessing Game

[ English ](README.md) | [ Español ](README.es.md)

Un volcado de base de datos PostgreSQL para el proyecto **"Number Guessing Game"** de la **certificación de Bases de Datos Relacionales de freeCodeCamp**. Esta base de datos registra usuarios y sus juegos de adivinanza, almacenando nombres de usuario y la cantidad de intentos necesarios para encontrar el número secreto.

---

## Descripción General

- **Diseño de tablas** con claves primarias, claves foráneas y restricciones únicas
- **Integridad referencial** en una jerarquía de 2 tablas (users → games)
- **Tipos de datos** incluyendo `integer` y `character varying`
- **Datos de muestra** — tablas vacías listas para jugar

---

## Esquema

### Diagrama Entidad-Relación

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

### Tablas

| Tabla | Filas | Clave Primaria | Claves Foráneas | Restricciones Únicas |
|-------|-------|----------------|-----------------|---------------------|
| `users` | 0 | `user_id` | — | `username` |
| `games` | 0 | `game_id` | `user_id → users.user_id` | — |

### Detalles de Columnas

#### `users`
| Columna | Tipo | Nulo | Por defecto | Descripción |
|---------|------|------|-------------|-------------|
| `user_id` | `integer` | NO | `nextval('users_user_id_seq')` | ID de usuario (PK) |
| `username` | `character varying(22)` | NO | — | Nombre de usuario (único) |

#### `games`
| Columna | Tipo | Nulo | Por defecto | Descripción |
|---------|------|------|-------------|-------------|
| `game_id` | `integer` | NO | `nextval('games_game_id_seq')` | ID del juego (PK) |
| `user_id` | `integer` | NO | — | FK a `users.user_id` |
| `number_of_guesses` | `integer` | NO | — | Intentos para ganar |

---

## Datos de Muestra Destacados

- **users** — los jugadores nuevos se agregan automáticamente al ingresar un nombre
- **games** — cada juego completado guarda el usuario y la cantidad de intentos
- El número secreto se elige al azar entre 1 y 1000

---

## Instalación / Uso

### Requisitos Previos
- [PostgreSQL](https://www.postgresql.org/download/) 12+
- Bash

### Restaurar la Base de Datos

```bash
# Crear la base de datos y cargar el volcado
psql -U postgres -f number_guess.sql
```

O, si prefieres crear la base de datos por separado:

```bash
# 1. Crear la base de datos
createdb -U postgres number_guess

# 2. Cargar el esquema
psql -U postgres -d number_guess -f number_guess.sql
```

### Conectar y Explorar

```bash
psql -U freecodecamp -d number_guess
```

```sql
-- Listar todas las tablas
\dt
```

---

## Scripts

| Archivo | Descripción |
|---------|-------------|
| `number_guess.sql` | Volcado de base de datos PostgreSQL para reconstruir la base de datos number_guess |
| `number_guess.sh` | Script de bash que ejecuta el juego de adivinanza de forma interactiva |

---

## Cómo Jugar

Ejecuta el script interactivo:

```bash
bash number_guess.sh
```

El juego solicita un nombre de usuario, recuerda juegos anteriores y te pide que adivines un número secreto entre 1 y 1000. Después de cada intento, te indica si el secreto es mayor o menor. Cuando aciertas, guarda tu puntuación.

---

## Créditos

Desarrollado como parte de la **Certificación de Bases de Datos Relacionales de freeCodeCamp**.

---

## Licencia

Este proyecto está licenciado bajo la Licencia MIT – consulta el archivo [LICENSE](../LICENSE) para más detalles.
