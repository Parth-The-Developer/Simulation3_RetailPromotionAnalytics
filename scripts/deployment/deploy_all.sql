/*======================================================================
    File   : scripts/deployment/deploy_all.sql
    Owner  : Parth (Step 5)
    Purpose: Master deployment script. Runs every component in order.

    HOW TO RUN (SQLCMD mode required for :r includes):
      - In SSMS:  Query menu -> "SQLCMD Mode", then execute this file.
                  Update ScriptsRoot below to your local scripts folder first.
      - From CLI: .\scripts\deployment\deploy.ps1
          (or pass ScriptsRoot with sqlcmd -v)

    Database architecture:
      - RetailPromotionAnalytics  → project database (all scripts run here)
      - RetailAnalytics           → schema (required by spec)
      - AdventureWorks2022        → source only (Hassana data load SELECTs)
======================================================================*/

-- EDIT THIS PATH if your repo is in a different location.
:setvar ScriptsRoot "C:\Users\parth\Desktop\sem-2\SQL_SERVER_DEVELOPMENT\Simulation_3\scripts"

PRINT '== Deploy started ==';
GO

-- 1) Schema (Parth)
:r $(ScriptsRoot)\schema\create_schema.sql

-- 2) Tables (Kelvin)
:r $(ScriptsRoot)\tables\promotion_campaign.sql
:r $(ScriptsRoot)\tables\product_performance.sql
:r $(ScriptsRoot)\tables\campaign_sales.sql
:r $(ScriptsRoot)\tables\discount_audit.sql

-- 3) Data load (Hassana)
:r $(ScriptsRoot)\data_load\load_analytics_data.sql

-- 4) Functions (Sahasri + Dhruv)
:r $(ScriptsRoot)\functions\ufn_GetDiscountRate.sql
:r $(ScriptsRoot)\functions\ufn_GetCampaignRevenue.sql
:r $(ScriptsRoot)\functions\ufn_GetProductsByCategory.sql
:r $(ScriptsRoot)\functions\ufn_GetProductsByColor.sql

-- 5) Stored procedures (Josó + Brian)
:r $(ScriptsRoot)\procedures\usp_GetCampaignRevenue.sql
:r $(ScriptsRoot)\procedures\usp_GetTopDiscountedProducts.sql
:r $(ScriptsRoot)\procedures\usp_GetCategoryPerformance.sql
:r $(ScriptsRoot)\procedures\usp_GetRegionalSales.sql

-- 6) Reports (Josó, Sahasri, Brian, Dhruv, Lien, Parth)
:r $(ScriptsRoot)\reports\campaign_revenue_report.sql
:r $(ScriptsRoot)\reports\top_discounted_products_report.sql
:r $(ScriptsRoot)\reports\category_performance_report.sql
:r $(ScriptsRoot)\reports\regional_sales_report.sql
:r $(ScriptsRoot)\reports\discount_validation_report.sql
:r $(ScriptsRoot)\reports\variables_demo.sql

-- 7) Validation (Sahil + Parth)
:r $(ScriptsRoot)\validation\check_discounts.sql
:r $(ScriptsRoot)\validation\constraint_lifecycle_demo.sql

PRINT '== Deploy finished ==';
GO
