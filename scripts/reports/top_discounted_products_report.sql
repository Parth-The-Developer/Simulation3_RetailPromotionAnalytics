/********************************************************************************
    Report : Report #2 - Top Discounted Products
    Owner  : Sahasri (Step 4)
    Purpose: Identify products with the highest discounts.

    Required output (per spec):
      - Product Name
      - Product Category
      - Discount Rate
      - List Price
      - Discounted Price  (ListPrice x (1 - DiscountRate))

    Data source: Kelvin tables + Hassana CampaignSales load
********************************************************************************/

USE RetailPromotionAnalytics;
GO

SET NOCOUNT ON;

SELECT TOP 20
    pp.ProductName                                              AS [Product Name],
    pp.ProductCategory                                          AS [Product Category],
    MAX(cs.DiscountRate)                                        AS [Discount Rate],
    pp.ListPrice                                                AS [List Price],
    (pp.ListPrice * (1 - MAX(cs.DiscountRate)))                 AS [Discounted Price]
FROM
    RetailAnalytics.CampaignSales cs
    INNER JOIN RetailAnalytics.ProductPerformance pp
        ON cs.ProductID = pp.ProductID
WHERE
    cs.DiscountRate > 0                          -- only genuinely discounted sales
GROUP BY
    pp.ProductName,
    pp.ProductCategory,
    pp.ListPrice
HAVING
    MAX(cs.DiscountRate) <= 0.50                  -- Kelvin discount CHECK constraint
    AND RetailAnalytics.ufn_GetDiscountRate(
            pp.ListPrice,
            pp.ListPrice * (1 - MAX(cs.DiscountRate))
        ) IS NOT NULL                             -- validates rate via Sahasri's function
ORDER BY
    [Discount Rate] DESC;
GO

PRINT 'Report #2 (Top Discounted Products) executed successfully.';
GO
