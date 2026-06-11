# Simulation 3 — AdventureWorks Retail Promotion Analytics System

## Team Information

| Field | Value |
| --- | --- |
| **Project Title** | AdventureWorks Retail Promotion Analytics System |
| **Course** | SQL Server Database Development (ITE-5223) |
| **Delivery Type** | Group Simulation Project |
| **Repository** | [Simulation3_RetailPromotionAnalytics](https://github.com/Parth-The-Developer/Simulation3_RetailPromotionAnalytics) |
| **Team Members** | Parth Patel, Kelvin Idoko, Hassana, Sahasri, Josó, Brian, Dhruv, Lien, Sahil, Joshua |
| **Instructor** | vbogudskyi |
| **Project Status** | Complete |

---

## Executive Summary

This project delivers a fully automated **Retail Promotion Analytics** solution on **Microsoft SQL Server**. Operational data is sourced from **AdventureWorks2022** (read-only) and transformed into a dedicated analytics database (**RetailPromotionAnalytics**) under the **RetailAnalytics** schema.

The solution includes idempotent DDL, set-based ETL, reusable T-SQL functions, parameterized stored procedures, operational reports, validation scripts, and a master **SQLCMD** deployment pipeline.

---

## Database Architecture

| Database / Schema | Purpose |
| --- | --- |
| `AdventureWorks2022` | **Source database** — read-only; referenced in Hassana's `INSERT ... SELECT` statements |
| `RetailPromotionAnalytics` | **Project database** — all team scripts execute here |
| `RetailAnalytics` | **Required schema** — contains all tables, functions, procedures, and reports |

> Run every script against **`RetailPromotionAnalytics`**, except data-load `SELECT` statements that read from `AdventureWorks2022`.

### Analytics Tables

| Table | Description |
| --- | --- |
| `PromotionCampaign` | Campaign master data with discount rate constraints |
| `ProductPerformance` | Product catalog metrics sourced from AdventureWorks production data |
| `CampaignSales` | Campaign-attributed sales transactions by region |
| `DiscountAudit` | Discount validation audit trail derived from campaign sales |

---

## Folder Structure

```text
Simulation3_RetailPromotionAnalytics/
├── README.md
├── document.md
├── diagrams/
│   ├── Simulation-3.drawio
│   ├── simulation-3.jpg
│   └── retail_analytics_er_diagram.jpg
├── screenshots/
│   ├── Parth/
│   ├── Kelvin/
│   ├── Hassana/
│   ├── Sahasri/
│   ├── Joso/
│   ├── Brian/
│   ├── Dhruv/
│   ├── Lien/
│   ├── Sahil/
│   └── Joshua/
└── scripts/
    ├── schema/
    ├── tables/
    ├── data_load/
    ├── functions/
    ├── procedures/
    ├── reports/
    ├── validation/
    └── deployment/
```

---

## Task Completion Matrix

| Task | Description | Owner | Script / Object | Status |
| --- | --- | --- | --- | --- |
| 1 | GitHub repo, folder structure, and schema script | Parth | `schema/create_schema.sql` | Done |
| 2 | Four analytics tables with PK, FK, CHECK, and DEFAULT constraints | Kelvin | `tables/*.sql` | Done |
| 3 | Load all four tables from AdventureWorks2022 | Hassana | `data_load/load_analytics_data.sql` | Done |
| 4 | Campaign revenue stored procedure | Josó | `RetailAnalytics.usp_GetCampaignRevenue` | Done |
| 5 | Top discounted products stored procedure | Josó | `RetailAnalytics.usp_GetTopDiscountedProducts` | Done |
| 6 | Discount rate scalar function | Sahasri | `RetailAnalytics.ufn_GetDiscountRate` | Done |
| 7 | Campaign revenue scalar function | Sahasri | `RetailAnalytics.ufn_GetCampaignRevenue` | Done |
| 8 | Category performance stored procedure | Brian | `RetailAnalytics.usp_GetCategoryPerformance` | Done |
| 9 | Regional sales stored procedure | Brian | `RetailAnalytics.usp_GetRegionalSales` | Done |
| 10 | Products by category table-valued function | Dhruv | `RetailAnalytics.ufn_GetProductsByCategory` | Done |
| 11 | Products by color table-valued function | Dhruv | `RetailAnalytics.ufn_GetProductsByColor` | Done |
| 12 | T-SQL variables and control-flow demo | Lien | `reports/variables_demo.sql` | Done |
| 13 | Discount validation script | Sahil | `validation/check_discounts.sql` | Done |
| 14 | Constraint lifecycle demonstration | Parth | `validation/constraint_lifecycle_demo.sql` | Done |
| 15 | SQLCMD master deployment script | Parth | `deployment/deploy_all.sql` | Done |
| 16 | End-to-end test and sample execution | Joshua | `deployment/sample_execution.sql` | Done |

---

## Business Reports

| Report | Description | Owner | Script | Status |
| --- | --- | --- | --- | --- |
| 1 | Campaign Revenue Report | Josó | `reports/campaign_revenue_report.sql` | Done |
| 2 | Top Discounted Products Report | Sahasri | `reports/top_discounted_products_report.sql` | Done |
| 3 | Product Category Performance Report | Brian | `reports/category_performance_report.sql` | Done |
| 4 | Regional Sales Analysis Report | Dhruv | `reports/regional_sales_report.sql` | Done |
| 5 | Discount Validation Report | Parth | `reports/discount_validation_report.sql` | Done |

---

## Build and Dependency Workflow

```text
Schema → Tables → Data Load → Functions → Procedures → Reports → Validation → Deployment → Smoke Test
```

| Step | Owner | Deliverable | Depends On |
| --- | --- | --- | --- |
| 1 | Parth | Schema + repository setup | — |
| 2 | Kelvin | Four table scripts | Step 1 |
| 3 | Hassana | Data load script | Step 2 |
| 4 | Josó, Sahasri, Brian, Dhruv, Lien, Sahil | Functions, procedures, reports, validation | Step 3 |
| 5 | Parth | Constraint demo, Report #5, `deploy_all.sql` | Step 3 |
| 6 | Joshua | Full deployment test + `sample_execution.sql` | Steps 1–5 |

---

## Deployment Guide

### Prerequisites

- Microsoft SQL Server Developer Edition (local instance)
- SQL Server Management Studio (SSMS) or Azure Data Studio with SQLCMD support
- **AdventureWorks2022** attached on the same instance
- SQLCMD Mode enabled when running deployment scripts in SSMS

### Option A — SSMS / Azure Data Studio (Recommended)

1. Clone the repository locally.
2. Open `scripts/deployment/deploy_all.sql`.
3. Update **`ScriptsRoot`** (line 19) to your local `scripts` folder path:

   ```sql
   :setvar ScriptsRoot "C:\path\to\Simulation_3\scripts"
   ```

4. Enable **Query → SQLCMD Mode**.
5. Execute the script.
6. Run `scripts/deployment/sample_execution.sql` to verify end-to-end results.

### Option B — PowerShell Helper

From the repository root:

```powershell
.\scripts\deployment\deploy.ps1
```

This sets `ScriptsRoot` automatically and invokes `sqlcmd`.

### Option C — Manual sqlcmd

```powershell
cd C:\path\to\Simulation_3
sqlcmd -S localhost -E -v ScriptsRoot="C:\path\to\Simulation_3\scripts" -i scripts\deployment\deploy_all.sql
```

### Deployment Order (via `deploy_all.sql`)

1. Schema creation
2. Table creation (Kelvin)
3. Data load (Hassana)
4. Functions (Sahasri, Dhruv)
5. Stored procedures (Josó, Brian)
6. Reports (all owners)
7. Validation scripts (Sahil, Parth)

---

## Screenshot Documentation

Step-by-step screenshot instructions for all tasks (Tasks 1–16) and business reports are in **[document.md](document.md)**.

Save all proof-of-execution screenshots in the `screenshots/` folder under each team member's subfolder.

---

## Verification Checklist

After deployment, confirm the following:

- [ ] Database `RetailPromotionAnalytics` exists
- [ ] Schema `RetailAnalytics` exists
- [ ] All four tables contain data
- [ ] All four functions compile and execute
- [ ] All four stored procedures compile and execute
- [ ] All five reports return results
- [ ] `check_discounts.sql` passes validation steps
- [ ] `constraint_lifecycle_demo.sql` completes without errors
- [ ] `sample_execution.sql` smoke test completes successfully

---

## Submission

Submit only the private GitHub repository link:

`https://github.com/Parth-The-Developer/Simulation3_RetailPromotionAnalytics`

All scripts must execute successfully. Enable **SQLCMD Mode** before running `deploy_all.sql`, and set `ScriptsRoot` to your local `scripts` folder path.

---

## License and Academic Use

This repository was developed as a group simulation project for **ITE-5223 — SQL Server Database Development**. For academic review and course submission only.
