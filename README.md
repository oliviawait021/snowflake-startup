# Snowflake SQL & Common Table Expressions

This project explores Snowflake's cloud data warehouse platform through twelve progressive SQL exercises against a sample e-commerce dataset. I worked through interface fundamentals, multi-table joins, aggregation, and advanced query composition using Common Table Expressions (CTEs) — the building block of readable, maintainable analytical SQL.

## Tech Stack

- **Snowflake** (cloud data warehouse)
- **Snowsight** (Snowflake web UI)
- **SQL** — joins, aggregations, window functions, CTEs

## Dataset

A standard e-commerce schema with eight tables: `CUSTOMER`, `ORDERS`, `LINEITEM`, `PART`, `SUPPLIER`, `NATION`, `REGION`. Queries span customer segmentation, order analytics, shipping metrics, and regional breakdowns.

## Key Concepts Covered

- **Multi-table joins** — chaining 4+ tables (`CUSTOMER → NATION → REGION`) with INNER and LEFT OUTER joins
- **Aggregation** — `GROUP BY` with `COUNT`, `SUM`, `MAX OVER PARTITION BY`
- **Pattern matching** — `LIKE` and Snowflake's `LIKE ANY` operator
- **Date arithmetic** — `DATEDIFF` for shipping delay calculations
- **CTEs** — progressively complex: single CTEs for filtering, CTEs with aggregation, chained multi-CTE queries for customer segmentation and supplier analysis
- **Snowflake-specific functions** — `DATEDIFF`, `TOP`, `LIKE ANY`

## What I Learned

- How virtual warehouses (compute) are decoupled from storage in Snowflake
- Why CTEs improve query readability over deeply nested subqueries
- How to structure multi-step analytical queries using named intermediate results
- Snowflake's context model: role, warehouse, database, and schema must all be configured before querying

## Exercises

| File | Content |
|---|---|
| `introduction_to_snowflake.sql` | Platform orientation: creating objects, running metadata vs. data queries |
| `sql_exercises.sql` | 12 exercises from basic filtering through chained CTEs |
