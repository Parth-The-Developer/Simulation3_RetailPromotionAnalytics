/********************************************************************************
    Report : Report #4 - Regional Sales Analysis
    Owner  : Dhruv (Step 4)
    Purpose: Analyze sales performance by region.

    Required output (per spec):
      - Region
      - Total Orders
      - Total Revenue
      - Average Revenue Per Order

    Database: RetailPromotionAnalytics | Schema: RetailAnalytics
    Data source: Kelvin CampaignSales + Hassana data load
********************************************************************************/

USE RetailPromotionAnalytics;
GO

SET NOCOUNT ON;

SELECT
    cs.Region                                                       AS [Region],
    COUNT(DISTINCT cs.SalesOrderID)                                 AS [Total Orders],
    SUM(cs.Revenue)                                                 AS [Total Revenue],
    SUM(cs.Revenue) / NULLIF(COUNT(DISTINCT cs.SalesOrderID), 0)    AS [Average Revenue Per Order]
FROM
    RetailAnalytics.CampaignSales cs
GROUP BY
    cs.Region
ORDER BY
    [Total Revenue] DESC;
GO

PRINT 'Report #4 (Regional Sales Analysis) executed successfully.';
GO
