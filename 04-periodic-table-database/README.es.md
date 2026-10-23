# Periodic Table Database

[ English ](README.md) | [ Español ](README.es.md)

Un volcado de base de datos PostgreSQL para el proyecto **"Periodic Table Database"** de la **certificación de Bases de Datos Relacionales de freeCodeCamp**. Esta base de datos almacena información sobre elementos químicos, incluyendo número atómico, símbolo, nombre, masa atómica, puntos de fusión y ebullición, y tipo de elemento.

---

## Descripción General

- **Diseño de tablas** con claves primarias, claves foráneas y restricciones únicas
- **Integridad referencial** en una jerarquía de 3 tablas (elements → properties → types)
- **Tipos de datos** incluyendo `integer`, `character varying`, `numeric` y `real`
- **Datos de muestra** con 10 elementos y 3 tipos de elementos (metal, metalloid, nonmetal)

---

## Esquema

### Diagrama Entidad-Relación

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

### Tablas

| Tabla | Filas | Clave Primaria | Claves Foráneas | Restricciones Únicas |
|-------|-------|----------------|-----------------|---------------------|
| `elements` | 10 | `atomic_number` | — | `symbol`, `name` |
| `properties` | 10 | `atomic_number` | `atomic_number → elements.atomic_number`<br>`type_id → types.type_id` | `atomic_number` |
| `types` | 3 | `type_id` | — | — |

### Detalles de Columnas

#### `elements`
| Columna | Tipo | Nulo | Por defecto | Descripción |
|---------|------|------|-------------|-------------|
| `atomic_number` | `integer` | NO | — | Número atómico (PK) |
| `symbol` | `character varying(2)` | NO | — | Símbolo químico (único) |
| `name` | `character varying(40)` | NO | — | Nombre del elemento (único) |

#### `properties`
| Columna | Tipo | Nulo | Por defecto | Descripción |
|---------|------|------|-------------|-------------|
| `atomic_number` | `integer` | NO | — | FK a `elements.atomic_number` |
| `atomic_mass` | `real` | NO | — | Masa atómica en amu |
| `melting_point_celsius` | `numeric` | NO | — | Punto de fusión en °C |
| `boiling_point_celsius` | `numeric` | NO | — | Punto de ebullición en °C |
| `type_id` | `integer` | NO | — | FK a `types.type_id` |

#### `types`
| Columna | Tipo | Nulo | Por defecto | Descripción |
|---------|------|------|-------------|-------------|
| `type_id` | `integer` | NO | `nextval('types_type_id_seq')` | Clave sustituta |
| `type` | `character varying(30)` | NO | — | Tipo de elemento |

---

## Datos de Muestra Destacados

### Elementos
- **Hydrogen (H)** – número atómico 1, nonmetal
- **Helium (He)** – número atómico 2, nonmetal
- **Lithium (Li)** – número atómico 3, metal
- **Fluorine (F)** – número atómico 9, nonmetal
- **Neon (Ne)** – número atómico 10, nonmetal

### Tipos
- **metal** – elementos metálicos
- **metalloid** – elementos con propiedades intermedias
- **nonmetal** – elementos no metálicos

---

## Instalación / Uso

### Requisitos Previos
- [PostgreSQL](https://www.postgresql.org/download/) 12+

### Restaurar la Base de Datos

```bash
# Crear la base de datos y cargar el volcado
psql -U postgres -f periodic_table.sql
```

O, si prefieres crear la base de datos por separado:

```bash
# 1. Crear la base de datos
createdb -U postgres periodic_table

# 2. Cargar el esquema y los datos
psql -U postgres -d periodic_table -f periodic_table.sql
```

### Conectar y Explorar

```bash
psql -U freecodecamp -d periodic_table
```

```sql
-- Listar todas las tablas
\dt
```

---

## Scripts

| Archivo | Descripción |
|---------|-------------|
| `periodic_table.sql` | Volcado de base de datos PostgreSQL para reconstruir la base de datos periodic_table |
| `element.sh` | Script de bash para consultar información de elementos por número atómico, símbolo o nombre |

---

## Créditos

Desarrollado como parte de la **Certificación de Bases de Datos Relacionales de freeCodeCamp**.

---

## Licencia

Este proyecto está licenciado bajo la Licencia MIT – consulta el archivo [LICENSE](../LICENSE) para más detalles.
