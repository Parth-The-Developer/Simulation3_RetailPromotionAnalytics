# Simulation - Retail Promotion Analytics (SQL Server)

Team project building a `RetailAnalytics` schema sourced from `AdventureWorks2022`.

## Folder structure

```
Simulation_3/
├── README.md
├── diagrams/
│   └── retail_analytics_er_diagram.png        # ER diagram (to be added)
├── screenshots/                                # final proof, per member
│   ├── Parth/  Kelvin/  Hassana/  Sahasri/  Joso/
│   └── Brian/  Dhruv/   Li/       Sahil/    Joshua/
└── scripts/
    ├── schema/
    │   └── create_schema.sql                   # Parth
    ├── tables/                                 # Kelvin
    │   ├── promotion_campaign.sql
    │   ├── product_performance.sql
    │   ├── campaign_sales.sql
    │   └── discount_audit.sql
    ├── data_load/                              # Hassana
    │   └── load_analytics_data.sql
    ├── functions/                              # Sahasri
    │   ├── ufn_GetDiscountRate.sql
    │   ├── ufn_GetCampaignRevenue.sql
    │   ├── ufn_GetProductsByCategory.sql
    │   └── ufn_GetProductsByColor.sql
    ├── procedures/                             # Joso
    │   ├── usp_GetCampaignRevenue.sql
    │   ├── usp_GetTopDiscountedProducts.sql
    │   ├── usp_GetCategoryPerformance.sql
    │   └── usp_GetRegionalSales.sql
    ├── reports/                                # Brian, Dhruv, Li, Sahil, Parth
    │   ├── campaign_revenue_report.sql
    │   ├── top_discounted_products_report.sql
    │   ├── category_performance_report.sql
    │   ├── regional_sales_report.sql
    │   ├── discount_validation_report.sql
    │   └── variables_demo.sql
    ├── validation/                            # team
    │   ├── check_discounts.sql
    │   └── constraint_lifecycle_demo.sql
    └── deployment/
        └── deploy_all.sql
```

## How to deploy

`scripts/deployment/deploy_all.sql` uses SQLCMD `:r` includes to run every component in dependency order.

- **SSMS:** open `scripts/deployment/deploy_all.sql`, enable **Query → SQLCMD Mode**, then execute.
- **CLI:** `sqlcmd -S <server> -d <database> -E -i scripts\deployment\deploy_all.sql`

Each owner uncomments their `:r` line in `deploy_all.sql` once their script is committed.

## Workflow (build order)

1. Schema → 2. Tables → 3. Data load → 4. Functions → 5. Procedures → 6. Reports → 7. Validation.
