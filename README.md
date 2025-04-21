Hecho por Juan Esteban Jimenez Cardona
# 🚗 Vehicle Sales Management System - Prolog

Este proyecto es parte de la **Práctica II** del curso _Lenguajes de Programación_ (ST0244) de la Universidad EAFIT. El objetivo es implementar un sistema en **Prolog** para gestionar un catálogo de vehículos y realizar consultas específicas sobre el inventario de una concesionaria.

---

## 📋 Descripción del Proyecto

El sistema permite:

- Registrar vehículos por marca, referencia, tipo, precio y año.
- Filtrar vehículos según presupuesto y tipo.
- Agrupar vehículos por marca, tipo y año.
- Generar reportes estructurados con restricciones de valor máximo del inventario.

---

## 🧠 Estructura del sistema

### 🔹 Base de datos

Definida con el predicado:

```prolog
vehicle(Brand, Reference, Type, Price, Year).

