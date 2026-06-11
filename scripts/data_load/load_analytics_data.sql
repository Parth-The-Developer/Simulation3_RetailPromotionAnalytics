/********************************************************************************
    File   : scripts/data_load/load_analytics_data.sql
    Owner  : Hassana (Step 3)
    Purpose: Load all 4 tables (INSERT ... SELECT from AdventureWorks2022)
    Database: RetailPromotionAnalytics | Schema: RetailAnalytics
    Source  : AdventureWorks2022 (read-only source for SELECT statements)
    Notes   : Idempotent. Run after create_schema.sql + Kelvin table scripts.
********************************************************************************/

USE RetailPromotionAnalytics;
GO

----------------------------------------------------------------------
-- 1) PromotionCampaign (seed campaigns - not in AdventureWorks2022)
----------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM RetailAnalytics.PromotionCampaign)
BEGIN
    INSERT INTO RetailAnalytics.PromotionCampaign
        (CampaignCode, CampaignName, CampaignType, StartDate, EndDate, DiscountRate)
    VALUES
        ('SPRING25',  'Spring Sale',      'Seasonal',  '2025-03-01', '2025-03-31', 0.25),
        ('SUMMER15',  'Summer Sale',      'Seasonal',  '2025-06-01', '2025-06-30', 0.15),
        ('BACK2SCH',  'Back To School',   'Seasonal',  '2025-08-01', '2025-08-31', 0.20),
        ('HOLIDAY20', 'Holiday Deals',    'Seasonal',  '2025-12-01', '2025-12-31', 0.20),
        ('CLEAR10',   'Clearance',        'Inventory', '2025-01-01', '2025-01-31', 0.10);

    PRINT 'PromotionCampaign: 5 rows loaded.';
END
ELSE
    PRINT 'PromotionCampaign: already has data - skipped.';
GO

----------------------------------------------------------------------
-- 2) ProductPerformance (from AdventureWorks2022.Production)
----------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM RetailAnalytics.ProductPerformance)
BEGIN
    INSERT INTO RetailAnalytics.ProductPerformance
        (ProductID, ProductName, ProductNumber, ProductCategory, Color,
         StandardCost, ListPrice, SafetyStockLevel, ReorderPoint)
    SELECT
        p.ProductID,
        p.Name,
        p.ProductNumber,
        pc.Name,
        p.Color,
        p.StandardCost,
        p.ListPrice,
        p.SafetyStockLevel,
        p.ReorderPoint
    FROM AdventureWorks2022.Production.Product p
    INNER JOIN AdventureWorks2022.Production.ProductSubcategory ps
        ON p.ProductSubcategoryID = ps.ProductSubcategoryID
    INNER JOIN AdventureWorks2022.Production.ProductCategory pc
        ON ps.ProductCategoryID = pc.ProductCategoryID;

    PRINT 'ProductPerformance: loaded from AdventureWorks2022.';
END
ELSE
    PRINT 'ProductPerformance: already has data - skipped.';
GO

----------------------------------------------------------------------
-- 3) CampaignSales (from AdventureWorks2022.Sales)
----------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM RetailAnalytics.CampaignSales)
BEGIN
    INSERT INTO RetailAnalytics.CampaignSales
        (CampaignID, ProductID, SalesOrderID, OrderDate, Region,
         QuantitySold, UnitPrice, DiscountRate, Revenue)
    SELECT
        c.CampaignID,
        sod.ProductID,
        soh.SalesOrderID,
        soh.OrderDate,
        st.Name,
        sod.OrderQty,
        sod.UnitPrice,
        sod.UnitPriceDiscount,
        sod.OrderQty * sod.UnitPrice * (1 - sod.UnitPriceDiscount)
    FROM AdventureWorks2022.Sales.SalesOrderHeader soh
    INNER JOIN AdventureWorks2022.Sales.SalesOrderDetail sod
        ON soh.SalesOrderID = sod.SalesOrderID
    INNER JOIN AdventureWorks2022.Sales.SalesTerritory st
        ON soh.TerritoryID = st.TerritoryID
    CROSS APPLY
    (
        SELECT TOP 1 pc.CampaignID
        FROM RetailAnalytics.PromotionCampaign pc
        WHERE sod.UnitPriceDiscount <= pc.DiscountRate
        ORDER BY pc.DiscountRate ASC
    ) c
    WHERE sod.ProductID IN (SELECT ProductID FROM RetailAnalytics.ProductPerformance);

    PRINT 'CampaignSales: loaded from AdventureWorks2022.';
END
ELSE
    PRINT 'CampaignSales: already has data - skipped.';
GO

----------------------------------------------------------------------
-- 4) DiscountAudit (derived from CampaignSales)
----------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM RetailAnalytics.DiscountAudit)
BEGIN
    INSERT INTO RetailAnalytics.DiscountAudit
        (CampaignID, ProductID, DiscountRate, ValidationStatus, ValidationMessage)
    SELECT
        cs.CampaignID,
        cs.ProductID,
        cs.DiscountRate,
        CASE
            WHEN cs.DiscountRate < 0 OR cs.DiscountRate > 0.50 THEN 'INVALID'
            ELSE 'VALID'
        END,
        CASE
            WHEN cs.DiscountRate < 0   THEN 'Negative discount not allowed'
            WHEN cs.DiscountRate > 0.50 THEN 'Discount exceeds limit'
            ELSE 'Valid discount'
        END
    FROM RetailAnalytics.CampaignSales cs;

    PRINT 'DiscountAudit: loaded from CampaignSales.';
END
ELSE
    PRINT 'DiscountAudit: already has data - skipped.';
GO

----------------------------------------------------------------------
-- Verification (for screenshot / testing)
----------------------------------------------------------------------
PRINT '--- Row counts ---';
SELECT 'PromotionCampaign'  AS TableName, COUNT(*) AS [Row Count] FROM RetailAnalytics.PromotionCampaign
UNION ALL
SELECT 'ProductPerformance', COUNT(*) FROM RetailAnalytics.ProductPerformance
UNION ALL
SELECT 'CampaignSales',      COUNT(*) FROM RetailAnalytics.CampaignSales
UNION ALL
SELECT 'DiscountAudit',      COUNT(*) FROM RetailAnalytics.DiscountAudit;
GO

SELECT TOP 5
    cs.CampaignSalesID,
    pc.CampaignName,
    pp.ProductName,
    cs.Region,
    cs.QuantitySold,
    cs.Revenue
FROM RetailAnalytics.CampaignSales cs
INNER JOIN RetailAnalytics.PromotionCampaign pc ON cs.CampaignID = pc.CampaignID
INNER JOIN RetailAnalytics.ProductPerformance pp ON cs.ProductID = pp.ProductID;
GO

PRINT 'Data load complete. Step 4 team can start their work.';
GO
