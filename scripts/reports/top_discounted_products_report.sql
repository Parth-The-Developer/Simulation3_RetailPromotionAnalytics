/*======================================================================
    File   : scripts/reports/top_discounted_products_report.sql
    Owner  : Sahasri (Step 4, Report #2)
    Purpose: Report #2: top discounted products
    Status : STUB - to be implemented.
======================================================================*/

SELECT TOP 20
    ProductName,
    ProductCategory,
    DiscountRate,
    ListPrice,
    (ListPrice * (1 - DiscountRate)) AS DiscountedPrice
FROM RetailAnalytics.ProductPerformance
ORDER BY DiscountRate DESC;