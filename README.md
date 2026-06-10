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

## Simulation Overview

This simulation implements a reusable retail promotion analytics environment using **Microsoft SQL Server**, **T-SQL**, and **SQLCMD deployment automation**. The solution sources operational data from **AdventureWorks2022** and stores all custom analytics objects in the **RetailAnalytics** schema.

The project includes:

- Idempotent schema and table creation with keys, constraints, and joins
- Set-based data loading using `INSERT ... SELECT`
- Scalar-valued and table-valued functions
- Parameterized stored procedures
- Operational business reports
- T-SQL variable and control-flow demonstrations
- Validation and constraint lifecycle scripts
- Modular master deployment script (`deploy_all.sql`)

## Database Architecture

| Database / Schema | Purpose |
| --- | --- |
| `AdventureWorks2022` | **Source database** — read-only; used in Hassana's `INSERT ... SELECT` statements |
| `RetailPromotionAnalytics` | **Project database** — all team scripts run here |
| `RetailAnalytics` | **Required schema** (inside `RetailPromotionAnalytics`) — all tables, functions, procedures, and reports |

> Run every script against **`RetailPromotionAnalytics`**, except data-load `SELECT` statements that reference `AdventureWorks2022`.

## Folder Structure

```text
Simulation3_RetailPromotionAnalytics/
├── README.md
├── diagrams/
│   ├── Simulation-3.drawio
│   └── simulation-3.jpg
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
    │   └── create_schema.sql
    ├── tables/
    │   ├── promotion_campaign.sql
    │   ├── product_performance.sql
    │   ├── campaign_sales.sql
    │   └── discount_audit.sql
    ├── data_load/
    │   └── load_analytics_data.sql
    ├── functions/
    │   ├── ufn_GetDiscountRate.sql
    │   ├── ufn_GetCampaignRevenue.sql
    │   ├── ufn_GetProductsByCategory.sql
    │   └── ufn_GetProductsByColor.sql
    ├── procedures/
    │   ├── usp_GetCampaignRevenue.sql
    │   ├── usp_GetTopDiscountedProducts.sql
    │   ├── usp_GetCategoryPerformance.sql
    │   └── usp_GetRegionalSales.sql
    ├── reports/
    │   ├── campaign_revenue_report.sql
    │   ├── top_discounted_products_report.sql
    │   ├── category_performance_report.sql
    │   ├── regional_sales_report.sql
    │   ├── discount_validation_report.sql
    │   └── variables_demo.sql
    ├── validation/
    │   ├── check_discounts.sql
    │   └── constraint_lifecycle_demo.sql
    └── deployment/
        ├── deploy_all.sql
        └── sample_execution.sql
```

## Tasks

| Task | Description | Owner | Script / Object | Status |
| --- | --- | --- | --- | --- |
| 1 | Create GitHub repo, folder structure, and schema script | Parth | `schema/create_schema.sql` | Done |
| 2 | Create 4 analytics tables with PK, FK, CHECK, and DEFAULT constraints | Kelvin | `tables/*.sql` | Done |
| 3 | Load data into all 4 tables from AdventureWorks2022 | Hassana | `data_load/load_analytics_data.sql` | Done |
| 4 | Campaign revenue stored procedure | Josó | `RetailAnalytics.usp_GetCampaignRevenue` | Pending |
| 5 | Top discounted products stored procedure | Josó | `RetailAnalytics.usp_GetTopDiscountedProducts` | Pending |
| 6 | Discount rate scalar function | Sahasri | `RetailAnalytics.ufn_GetDiscountRate` | Done |
| 7 | Campaign revenue scalar function | Sahasri | `RetailAnalytics.ufn_GetCampaignRevenue` | Done |
| 8 | Category performance stored procedure | Brian | `RetailAnalytics.usp_GetCategoryPerformance` | Done |
| 9 | Regional sales stored procedure | Brian | `RetailAnalytics.usp_GetRegionalSales` | Done |
| 10 | Products by category table-valued function | Dhruv | `RetailAnalytics.ufn_GetProductsByCategory` | Pending |
| 11 | Products by color table-valued function | Dhruv | `RetailAnalytics.ufn_GetProductsByColor` | Pending |
| 12 | T-SQL variables and control-flow demo | Lien | `reports/variables_demo.sql` | In Progress |
| 13 | Discount validation script | Sahil | `validation/check_discounts.sql` | Done |
| 14 | Constraint lifecycle demonstration | Parth | `validation/constraint_lifecycle_demo.sql` | Pending |
| 15 | SQLCMD master deployment script | Parth | `deployment/deploy_all.sql` | Pending |
| 16 | End-to-end test and sample execution | Joshua | `deployment/sample_execution.sql` | Pending |

## Business Reports

| Report | Description | Owner | Script | Status |
| --- | --- | --- | --- | --- |
| 1 | Campaign Revenue Report | Josó | `reports/campaign_revenue_report.sql` | Pending |
| 2 | Top Discounted Products Report | Sahasri | `reports/top_discounted_products_report.sql` | Done |
| 3 | Product Category Performance Report | Brian | `reports/category_performance_report.sql` | Done |
| 4 | Regional Sales Analysis Report | Dhruv | `reports/regional_sales_report.sql` | Pending |
| 5 | Discount Validation Report | Parth | `reports/discount_validation_report.sql` | Pending |

## Build Order (Dependency Workflow)

1. Schema → 2. Tables → 3. Data Load → 4. Functions → 5. Procedures → 6. Reports → 7. Validation → 8. Deployment

| Step | Person | Starts After |
| --- | --- | --- |
| 1 | Parth — schema + repo setup | Immediately |
| 2 | Kelvin — 4 table scripts | Step 1 |
| 3 | Hassana — data load | Step 2 |
| 4 | Josó, Sahasri, Brian, Dhruv, Lien, Sahil (parallel) | Step 3 |
| 5 | Parth — constraint demo, Report #5, finalize `deploy_all.sql` | Step 3 |
| 6 | Joshua — full deployment test + screenshots (check) | Everyone else |

## Deployment Instructions

`scripts/deployment/deploy_all.sql` is the master script. It uses SQLCMD `:r` includes to run all components in dependency order.

**Prerequisites**

- Microsoft SQL Server Developer Edition
- SQL Server Management Studio (SSMS)
- AdventureWorks2022 attached on the same instance
- SQLCMD Mode enabled in SSMS

**Run in SSMS**

1. Open `scripts/deployment/deploy_all.sql`
2. Enable **Query → SQLCMD Mode**
3. Execute the script

**Run from CLI**

```bash
sqlcmd -S localhost -E -i scripts\deployment\deploy_all.sql
```

> `deploy_all.sql` is finalized by Parth after all team scripts are complete and tested. Individual scripts can be run separately in SSMS for development and screenshots.

## Screenshot Documentation

Save all proof-of-execution screenshots in the `screenshots/` folder under each team member's subfolder.

| Member | What to Capture |
| --- | --- |
| Parth | Schema creation, constraint lifecycle demo, Report #5 |
| Kelvin | Table creation scripts (4 tables) |
| Hassana | Data load execution and row counts for all 4 tables |
| Sahasri | Both functions and Report #2 |
| Josó | Both procedures and Report #1 |
| Brian | Both procedures and Report #3 |
| Dhruv | Both functions and Report #4 |
| Lien | Variables demo script output |
| Sahil | Discount validation script output |
| Joshua | Full `deploy_all.sql` execution and `sample_execution.sql` |

## Submission

Submit only the private GitHub repository link:

`https://github.com/Parth-The-Developer/Simulation3_RetailPromotionAnalytics`

All scripts must execute successfully without manual modification. Enable SQLCMD Mode before running deployment scripts.
