/********************************************************************************
-- Report Name:     Product Category Performance Report (Report #3)
-- Purpose:         Analyzes category-level sales performance.
-- Output:          Result set ordered by Total Revenue descending.
********************************************************************************/

USE AdventureWorks2022;
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
