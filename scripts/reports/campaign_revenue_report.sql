/********************************************************************************
    Report : Report #1 - Campaign Revenue Report
    Owner  : Josó (Step 4)
    Purpose: Campaign revenue by campaign name and product category.
    Database: RetailPromotionAnalytics | Schema: RetailAnalytics
    Source  : Kelvin tables + Hassana data load
********************************************************************************/

USE RetailPromotionAnalytics;
GO

SET NOCOUNT ON;

SELECT
    pc.CampaignName,
    pp.ProductCategory,
    SUM(cs.Revenue) AS TotalRevenue,
    AVG(cs.DiscountRate) AS AverageDiscountRate,
    SUM(cs.QuantitySold) AS UnitsSold
FROM RetailAnalytics.CampaignSales cs
INNER JOIN RetailAnalytics.PromotionCampaign pc
    ON cs.CampaignID = pc.CampaignID
INNER JOIN RetailAnalytics.ProductPerformance pp
    ON cs.ProductID = pp.ProductID
GROUP BY
    pc.CampaignName,
    pp.ProductCategory
ORDER BY
    TotalRevenue DESC;
GO

PRINT 'Report #1 (Campaign Revenue) executed successfully.';
GO
