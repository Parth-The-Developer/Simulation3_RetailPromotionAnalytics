/********************************************************************************
    File   : scripts/reports/top_discounted_products_report.sql
    Owner  : Sahasri (Step 4, Report #2)
    Purpose: Report #2 - top discounted products (joins Kelvin tables + Hassana data)
********************************************************************************/

USE RetailPromotionAnalytics;
GO

SET NOCOUNT ON;

SELECT TOP 20
    pp.ProductName                          AS [Product Name],
    pp.ProductCategory                      AS [Product Category],
    MAX(cs.DiscountRate)                    AS [Discount Rate],
    pp.ListPrice                            AS [List Price],
    (pp.ListPrice * (1 - MAX(cs.DiscountRate))) AS [Discounted Price]
FROM
    RetailAnalytics.CampaignSales cs
    INNER JOIN RetailAnalytics.ProductPerformance pp
        ON cs.ProductID = pp.ProductID
GROUP BY
    pp.ProductName,
    pp.ProductCategory,
    pp.ListPrice
ORDER BY
    [Discount Rate] DESC;
GO
