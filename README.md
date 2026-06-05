# Simulation 3 - RetailAnalytics (SQL Server)

Team project building a `RetailAnalytics` schema sourced from `AdventureWorks2022`.

## Folder structure

```
Simulation_3/
├── deploy_all.sql            # Master script (run in SQLCMD mode)
└── scripts/
    ├── schema/               # create_schema.sql  (Parth)
    ├── tables/               # 4 table scripts     (Kelvin)
    ├── data_load/            # INSERT ... SELECT    (Hassana)
    ├── functions/            # 4 functions          (Sahasri)
    ├── procedures/           # 4 stored procedures  (Joso)
    ├── reports/              # reports              (Brian, Dhruv, Li, Sahil, Parth)
    └── validation/           # validation scripts   (team)
```

## How to deploy

`deploy_all.sql` uses SQLCMD `:r` includes to run every component in dependency order.

- **SSMS:** open `deploy_all.sql`, enable **Query → SQLCMD Mode**, then execute.
- **CLI:** `sqlcmd -S <server> -d <database> -E -i deploy_all.sql`

Each owner uncomments their `:r` line in `deploy_all.sql` once their script is committed.

## Workflow (build order)

1. Schema → 2. Tables → 3. Data load → 4. Functions → 5. Procedures → 6. Reports → 7. Validation.
