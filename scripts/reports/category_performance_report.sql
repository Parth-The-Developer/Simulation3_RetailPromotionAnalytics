/********************************************************************************
    Report : Report #3 - Product Category Performance
    Owner  : Brian (Step 4)
    Purpose: Analyzes category-level sales performance.
    Database: RetailPromotionAnalytics (Kelvin tables + Hassana data)
    Source data originally loaded from AdventureWorks2022.
********************************************************************************/

USE RetailPromotionAnalytics;
GO

SET NOCOUNT ON;

SELECT
    pp.ProductCategory                      AS [Product Category],
    SUM(cs.Revenue)                         AS [Total Revenue],
    SUM(cs.QuantitySold)                    AS [Total Units Sold],
    AVG(cs.DiscountRate)                    AS [Average Discount Rate]
FROM
    RetailAnalytics.CampaignSales cs
    INNER JOIN RetailAnalytics.ProductPerformance pp
        ON cs.ProductID = pp.ProductID
GROUP BY
    pp.ProductCategory
ORDER BY
    [Total Revenue] DESC;
GO

PRINT 'Report #3 (Category Performance) executed successfully.';
GO
