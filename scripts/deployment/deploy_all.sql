/*======================================================================
    File   : scripts/deployment/deploy_all.sql
    Owner  : Parth (Step 5)
    Purpose: Master deployment script. Runs every component in order.

    HOW TO RUN (SQLCMD mode required for :r includes):
      - In SSMS:  Query menu -> "SQLCMD Mode", then execute this file.
      - From CLI: cd to the PROJECT ROOT (Simulation_3), then run:
          sqlcmd -S localhost -E -i scripts\deployment\deploy_all.sql

    NOTE: All :r paths below are relative to the PROJECT ROOT folder
          (Simulation_3), not the deployment subfolder.

    Database architecture:
      - RetailPromotionAnalytics  → project database (all scripts run here)
      - RetailAnalytics           → schema (required by spec)
      - AdventureWorks2022        → source only (Hassana data load SELECTs)
======================================================================*/

PRINT '== Deploy started ==';
GO

-- 1) Schema (Parth)
:r scripts\schema\create_schema.sql

-- 2) Tables (Kelvin)
:r scripts\tables\promotion_campaign.sql
:r scripts\tables\product_performance.sql
:r scripts\tables\campaign_sales.sql
:r scripts\tables\discount_audit.sql

-- 3) Data load (Hassana)
:r scripts\data_load\load_analytics_data.sql

-- 4) Functions (Sahasri + Dhruv)
:r scripts\functions\ufn_GetDiscountRate.sql
:r scripts\functions\ufn_GetCampaignRevenue.sql
:r scripts\functions\ufn_GetProductsByCategory.sql
:r scripts\functions\ufn_GetProductsByColor.sql

-- 5) Stored procedures (Josó + Brian)
:r scripts\procedures\usp_GetCampaignRevenue.sql
:r scripts\procedures\usp_GetTopDiscountedProducts.sql
:r scripts\procedures\usp_GetCategoryPerformance.sql
:r scripts\procedures\usp_GetRegionalSales.sql

-- 6) Reports (Josó, Sahasri, Brian, Dhruv, Lien, Parth)
:r scripts\reports\campaign_revenue_report.sql
:r scripts\reports\top_discounted_products_report.sql
:r scripts\reports\category_performance_report.sql
:r scripts\reports\regional_sales_report.sql
:r scripts\reports\discount_validation_report.sql
:r scripts\reports\variables_demo.sql

-- 7) Validation (Sahil + Parth)
:r scripts\validation\check_discounts.sql
:r scripts\validation\constraint_lifecycle_demo.sql

PRINT '== Deploy finished ==';
GO
