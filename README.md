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

This simulation implements a reusable retail promotion analytics environment using **Microsoft SQL Server**, **T-SQL**, and **SQLCMD deployment automation** against the **AdventureWorks2022** database. All custom analytics objects are created in the **RetailAnalytics** schema inside the **RetailPromotionAnalytics** database.

The project includes:

- Idempotent schema and table creation with keys, constraints, and joins
- Set-based data loading using `INSERT ... SELECT`
- Scalar-valued and inline table-valued functions
- Parameterized stored procedures
- Operational business reports
- T-SQL variable and control-flow demonstrations
- Validation and constraint lifecycle scripts
- Modular master deployment script (`deploy_all.sql`)

## Folder Structure

```text
scripts/
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
diagrams/
screenshots/
README.md
document.md
```

## Tasks

| Task | Description | Object / Script |
| --- | --- | --- |
| 1 | Create GitHub repo, folder structure, and schema script | `schema/create_schema.sql` |
| 2 | Create 4 analytics tables with PK, FK, CHECK, and DEFAULT constraints | `tables/*.sql` |
| 3 | Load data into all 4 tables from AdventureWorks2022 | `data_load/load_analytics_data.sql` |
| 4 | Campaign revenue stored procedure | `RetailAnalytics.usp_GetCampaignRevenue` |
| 5 | Top discounted products stored procedure | `RetailAnalytics.usp_GetTopDiscountedProducts` |
| 6 | Discount rate scalar function | `RetailAnalytics.ufn_GetDiscountRate` |
| 7 | Campaign revenue scalar function | `RetailAnalytics.ufn_GetCampaignRevenue` |
| 8 | Category performance stored procedure | `RetailAnalytics.usp_GetCategoryPerformance` |
| 9 | Regional sales stored procedure | `RetailAnalytics.usp_GetRegionalSales` |
| 10 | Products by category table-valued function | `RetailAnalytics.ufn_GetProductsByCategory` |
| 11 | Products by color table-valued function | `RetailAnalytics.ufn_GetProductsByColor` |
| 12 | T-SQL variables and control-flow demo | `reports/variables_demo.sql` |
| 13 | Discount validation script | `validation/check_discounts.sql` |
| 14 | Constraint lifecycle demonstration | `validation/constraint_lifecycle_demo.sql` |
| 15 | SQLCMD master deployment script | `deployment/deploy_all.sql` |
| 16 | End-to-end test and sample execution | `deployment/sample_execution.sql` |

## Business Reports

| Report | Description | Script |
| --- | --- | --- |
| 1 | Campaign Revenue Report | `reports/campaign_revenue_report.sql` |
| 2 | Top Discounted Products Report | `reports/top_discounted_products_report.sql` |
| 3 | Product Category Performance Report | `reports/category_performance_report.sql` |
| 4 | Regional Sales Analysis Report | `reports/regional_sales_report.sql` |
| 5 | Discount Validation Report | `reports/discount_validation_report.sql` |

## Deployment Instructions

`scripts/deployment/deploy_all.sql` is the master script. It uses SQLCMD `:r` includes to run all components in dependency order.

**Prerequisites**

- Microsoft SQL Server Developer Edition
- SQL Server Management Studio (SSMS) or Azure Data Studio
- AdventureWorks2022 attached on the same instance
- SQLCMD Mode enabled in SSMS

**Run in SSMS**

1. Open `scripts/deployment/deploy_all.sql`
2. Update `ScriptsRoot` to your local `scripts` folder path
3. Enable **Query → SQLCMD Mode**
4. Execute the script
5. Run `scripts/deployment/sample_execution.sql` to verify results

**Run from CLI**

```powershell
.\scripts\deployment\deploy.ps1
```

## Screenshot Documentation

Step-by-step screenshot instructions for all tasks (Tasks 1–16) and business reports are in **[document.md](document.md)**.

Save all proof-of-execution screenshots in the `screenshots/` folder under each team member's subfolder.

## Submission

Submit only the private GitHub repository link:

`https://github.com/Parth-The-Developer/Simulation3_RetailPromotionAnalytics`

All scripts must execute successfully without manual modification. Enable SQLCMD Mode before running deployment scripts.
