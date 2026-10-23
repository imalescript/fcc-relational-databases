# Salon Appointment Scheduler

Un volcado de base de datos y una aplicación de línea de comandos para gestionar turnos de salón de belleza. Este proyecto implementa los requisitos de la **Certificación de Bases de Datos Relacionales de freeCodeCamp** para crear un esquema de base de datos, insertar datos y proporcionar un script de usuario para agendar turnos.

---

## Descripción General

- **Esquema de base de datos** con tablas para clientes, turnos y servicios
- **Claves primarias y foráneas** con restricciones y relaciones adecuadas
- **Secuencias autoincrementales** para claves sustitutas
- **Script de línea de comandos** para que los clientes agenden turnos de forma interactiva
- **Datos de muestra** con múltiples servicios e historial de turnos

---

## Esquema

### Diagrama Entidad-Relación

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

### Tablas

| Tabla | Filas | Clave Primaria | Claves Foráneas | Restricciones Únicas |
|-------|-------|----------------|-----------------|---------------------|
| `customers` | TBD | `customer_id` | — | `phone` |
| `appointments` | TBD | `appointment_id` | `customer_id → customers.customer_id`<br>`service_id → services.service_id` | — |
| `services` | 5 | `service_id` | — | — |

### Detalles de Columnas

#### `customers`

| Columna | Tipo | Nulo | Por defecto | Descripción |
|---------|------|------|-------------|-------------|
| `customer_id` | `integer` | NO | `nextval('customers_customer_id_seq')` | Clave sustituta |
| `phone` | `character varying(20)` | NO | — | Número de teléfono (único) |
| `name` | `character varying(50)` | NO | — | Nombre del cliente |

#### `appointments`

| Columna | Tipo | Nulo | Por defecto | Descripción |
|---------|------|------|-------------|-------------|
| `appointment_id` | `integer` | NO | `nextval('appointments_appointment_id_seq')` | Clave sustituta |
| `customer_id` | `integer` | NO | — | FK a `customers.customer_id` |
| `service_id` | `integer` | NO | — | FK a `services.service_id` |
| `time` | `character varying(20)` | NO | — | Hora del turno |

#### `services`

| Columna | Tipo | Nulo | Por defecto | Descripción |
|---------|------|------|-------------|-------------|
| `service_id` | `integer` | NO | `nextval('services_service_id_seq')` | Clave sustituta |
| `name` | `character varying(50)` | NO | — | Nombre del servicio |

---

## Datos de Muestra

### Servicios

- **1.** corte (cut)
- **2.** color (color)
- **3.** permanente (perm)
- **4.** peinado (style)
- **5.** recorte (trim)

### Clientes

| customer_id | phone | name |
|-------------|-------|------|
| 1 | 555-555-5555 | Fabio |

### Turnos

| appointment_id | customer_id | service_id | time |
|---------------|-------------|------------|------|
| 1 | 1 | 1 | 10:30 |

---

## Instalación / Uso

### Requisitos Previos

- [PostgreSQL](https://www.postgresql.org/download/) 12+
- `psql` cliente de línea de comandos

### Restaurar la Base de Datos

```bash
# Crear la base de datos y cargar el volcado
psql -U postgres -f salon.sql
```

O, si prefieres crear la base de datos por separado:

```bash
# 1. Crear la base de datos
createdb -U postgres salon

# 2. Cargar el esquema y los datos
psql -U postgres -d salon -f salon.sql
```

### Conectar y Explorar

```bash
psql -U freecodecamp -d salon
```

```sql
-- Listar todas las tablas
\dt

-- Ver clientes
SELECT * FROM customers;

-- Ver turnos
SELECT * FROM appointments;

-- Ver servicios
SELECT * FROM services;
```

---

## Scripts

| Archivo | Descripción |
|---------|-------------|
| `salon.sh` | Script de línea de comandos para que los clientes agenden turnos |
| `salon.sql` | Volcado de base de datos PostgreSQL para reconstruir la base de datos salon |

---

## Uso

El script `salon.sh` permite a los clientes:

1. Ver los servicios disponibles
2. Seleccionar un servicio por ID
3. Ingresar su número de teléfono
4. Proporcionar su nombre (si no está en la base de datos)
5. Especificar la hora del turno
6. Confirmar el turno

Flujo de ejemplo:

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

## Créditos

Desarrollado como parte de la **Certificación de Bases de Datos Relacionales de freeCodeCamp**.  
El esquema de la base de datos y la aplicación están diseñados para cumplir con los requisitos de certificación para crear bases de datos relacionales normalizadas con restricciones adecuadas.

---

## Licencia

Este proyecto está licenciado bajo la Licencia MIT – consulta el archivo [LICENSE](../LICENSE) para más detalles.