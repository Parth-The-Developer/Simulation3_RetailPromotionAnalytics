/*======================================================================
    File   : scripts/deployment/deploy_all.sql
    Purpose: Master deployment script. Runs every component in order.
    Author : Parth Patel

    HOW TO RUN (SQLCMD mode required for :r includes):
      - In SSMS:  Query menu -> "SQLCMD Mode", then execute this file.
      - From CLI: sqlcmd -S <server> -d <database> -E -i scripts\deployment\deploy_all.sql

    NOTE: Paths below are relative to this file (scripts/deployment/).
          The :r includes are COMMENTED OUT for the initial structure.
          Each owner uncomments their line once their script is committed,
          following the dependency order.
======================================================================*/

PRINT '== Deploy started ==';
GO

-- 1) Schema (Parth) - DONE, creates DB + schema
:r ..\schema\create_schema.sql
GO

-- 2) Tables (Kelvin) - DONE
:r ..\tables\promotion_campaign.sql
GO
:r ..\tables\product_performance.sql
GO
:r ..\tables\campaign_sales.sql
GO
:r ..\tables\discount_audit.sql
GO

-- 3) Data load (Hassana) - DONE
:r ..\data_load\load_analytics_data.sql
GO

-- 4) Functions (Sahasri) - DONE (2 of 4; Dhruv owns the other 2)
:r ..\functions\ufn_GetDiscountRate.sql
GO
:r ..\functions\ufn_GetCampaignRevenue.sql
GO
-- :r ..\functions\ufn_GetProductsByCategory.sql
-- :r ..\functions\ufn_GetProductsByColor.sql

-- 5) Stored procedures (Joso)
-- :r ..\procedures\usp_GetCampaignRevenue.sql
-- :r ..\procedures\usp_GetTopDiscountedProducts.sql
-- :r ..\procedures\usp_GetCategoryPerformance.sql
-- :r ..\procedures\usp_GetRegionalSales.sql

-- 6) Reports (Brian, Dhruv, Li, Sahil, Parth)
-- :r ..\reports\campaign_revenue_report.sql
:r ..\reports\top_discounted_products_report.sql
GO
-- :r ..\reports\category_performance_report.sql
-- :r ..\reports\regional_sales_report.sql
-- :r ..\reports\discount_validation_report.sql
-- :r ..\reports\variables_demo.sql

-- 7) Validation (team)
:r ..\validation\check_discounts.sql
GO
-- :r ..\validation\constraint_lifecycle_demo.sql

PRINT '== Deploy finished ==';
GO
