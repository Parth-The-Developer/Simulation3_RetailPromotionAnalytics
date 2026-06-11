
/********************************************************************************
    File   : scripts/reports/top_discounted_products_report.sql
    Owner  : Sahasri (Step 4, Report #2)
    Purpose: Report #2 - top discounted products (joins Kelvin tables + Hassana data)
********************************************************************************/

﻿SELECT TOP 20
    p.ProductName,
    p.ProductCategory,
    c.DiscountRate,
    p.ListPrice,
    (p.ListPrice * (1 - c.DiscountRate)) AS DiscountedPrice
FROM RetailAnalytics.ProductPerformance p
JOIN RetailAnalytics.CampaignSales c
    ON p.ProductID = c.ProductID;

