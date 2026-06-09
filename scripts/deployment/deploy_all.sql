/*======================================================================
    File   : scripts/deployment/deploy_all.sql
    Owner  : Parth (Step 5 - finalize after everyone completes)
    Purpose: Master deployment script. Runs every component in order.

    HOW TO RUN (SQLCMD mode required for :r includes):
      - In SSMS:  Query menu -> "SQLCMD Mode", then execute this file.
      - From CLI: sqlcmd -S <server> -d <database> -E -i scripts\deployment\deploy_all.sql

    Database architecture:
      - RetailPromotionAnalytics  → project database (all scripts run here)
      - RetailAnalytics           → schema (required by spec)
      - AdventureWorks2022        → source only (Hassana data load SELECTs)

    NOTE: All :r includes are COMMENTED OUT until Parth finalizes deploy_all.sql
          after the team finishes their scripts. Uncomment each line in order
          once that script is complete and tested.
======================================================================*/

PRINT '== Deploy started ==';
GO

-- 1) Schema (Parth)
-- :r ..\schema\create_schema.sql

-- 2) Tables (Kelvin)
-- :r ..\tables\promotion_campaign.sql
-- :r ..\tables\product_performance.sql
-- :r ..\tables\campaign_sales.sql
-- :r ..\tables\discount_audit.sql

-- 3) Data load (Hassana)
-- :r ..\data_load\load_analytics_data.sql

-- 4) Functions (Sahasri + Dhruv)
-- :r ..\functions\ufn_GetDiscountRate.sql
-- :r ..\functions\ufn_GetCampaignRevenue.sql
-- :r ..\functions\ufn_GetProductsByCategory.sql
-- :r ..\functions\ufn_GetProductsByColor.sql

-- 5) Stored procedures (Joso + Brian)
-- :r ..\procedures\usp_GetCampaignRevenue.sql
-- :r ..\procedures\usp_GetTopDiscountedProducts.sql
-- :r ..\procedures\usp_GetCategoryPerformance.sql
-- :r ..\procedures\usp_GetRegionalSales.sql

-- 6) Reports (Joso, Sahasri, Brian, Dhruv, Li, Parth)
-- :r ..\reports\campaign_revenue_report.sql
-- :r ..\reports\top_discounted_products_report.sql
-- :r ..\reports\category_performance_report.sql
-- :r ..\reports\regional_sales_report.sql
-- :r ..\reports\discount_validation_report.sql
-- :r ..\reports\variables_demo.sql

-- 7) Validation (Sahil + Parth)
-- :r ..\validation\check_discounts.sql
-- :r ..\validation\constraint_lifecycle_demo.sql

PRINT '== Deploy finished ==';
GO
