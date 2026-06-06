USE RetailPromotionAnalytics;
GO
-- DATA LOAD SCRIPT

-- 1. PROMOTION CAMPAIGNS

IF NOT EXISTS (SELECT 1 FROM RetailAnalytics.PromotionCampaign)
BEGIN
    INSERT INTO RetailAnalytics.PromotionCampaign
    (CampaignCode, CampaignName, CampaignType, StartDate, EndDate, DiscountRate)
    VALUES
    ('SPRING25','Spring Sale','Seasonal','2025-03-01','2025-03-31',0.25),
    ('SUMMER15','Summer Sale','Seasonal','2025-06-01','2025-06-30',0.15),
    ('BACK2SCH','Back To School','Seasonal','2025-08-01','2025-08-31',0.20),
    ('HOLIDAY20','Holiday Deals','Seasonal','2025-12-01','2025-12-31',0.20),
    ('CLEAR10','Clearance','Inventory','2025-01-01','2025-01-31',0.10);
END
GO

-- 2. PRODUCT PERFORMANCE

IF NOT EXISTS (SELECT 1 FROM RetailAnalytics.ProductPerformance)
BEGIN
    INSERT INTO RetailAnalytics.ProductPerformance
    (
        ProductID, ProductName, ProductNumber,
        ProductCategory, Color,
        StandardCost, ListPrice,
        SafetyStockLevel, ReorderPoint
    )
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
    JOIN AdventureWorks2022.Production.ProductSubcategory ps
        ON p.ProductSubcategoryID = ps.ProductSubcategoryID
    JOIN AdventureWorks2022.Production.ProductCategory pc
        ON ps.ProductCategoryID = pc.ProductCategoryID;
END
GO

-- 3. CAMPAIGN SALES

IF NOT EXISTS (SELECT 1 FROM RetailAnalytics.CampaignSales)
BEGIN
    INSERT INTO RetailAnalytics.CampaignSales
    (
        CampaignID, ProductID,
        SalesOrderID, OrderDate,
        Region,
        QuantitySold, UnitPrice,
        DiscountRate, Revenue
    )
    SELECT
        c.CampaignID,
        sod.ProductID,
        soh.SalesOrderID,
        soh.OrderDate,
        st.Name,
        sod.OrderQty,
        sod.UnitPrice,
        sod.UnitPriceDiscount,
        (sod.OrderQty * sod.UnitPrice * (1 - sod.UnitPriceDiscount))
    FROM AdventureWorks2022.Sales.SalesOrderHeader soh
    JOIN AdventureWorks2022.Sales.SalesOrderDetail sod
        ON soh.SalesOrderID = sod.SalesOrderID
    JOIN AdventureWorks2022.Sales.SalesTerritory st
        ON soh.TerritoryID = st.TerritoryID
    CROSS APPLY
    (
        SELECT TOP 1 pc.CampaignID
        FROM RetailAnalytics.PromotionCampaign pc
        WHERE sod.UnitPriceDiscount <= pc.DiscountRate
        ORDER BY pc.DiscountRate ASC
    ) c;
END
GO

-- 4. DISCOUNT AUDIT

IF NOT EXISTS (SELECT 1 FROM RetailAnalytics.DiscountAudit)
BEGIN
    INSERT INTO RetailAnalytics.DiscountAudit
    (
        CampaignID,
        ProductID,
        DiscountRate,
        ValidationStatus,
        ValidationMessage
    )
    SELECT
        cs.CampaignID,
        cs.ProductID,
        cs.DiscountRate,
        CASE
            WHEN cs.DiscountRate < 0 OR cs.DiscountRate > 0.50 THEN 'INVALID'
            ELSE 'VALID'
        END,
        CASE
            WHEN cs.DiscountRate < 0 THEN 'Negative discount not allowed'
            WHEN cs.DiscountRate > 0.50 THEN 'Discount exceeds limit'
            ELSE 'Valid discount'
        END
    FROM RetailAnalytics.CampaignSales cs;
END
GO

-- Test/Verification queries

SELECT 
    name AS TableName
FROM sys.tables
ORDER BY name;

EXEC sp_help 'RetailAnalytics.PromotionCampaign';
EXEC sp_help 'RetailAnalytics.ProductPerformance';
EXEC sp_help 'RetailAnalytics.CampaignSales';
EXEC sp_help 'RetailAnalytics.DiscountAudit';

SELECT * FROM RetailAnalytics.PromotionCampaign;

SELECT TOP 10 * FROM RetailAnalytics.ProductPerformance;

SELECT TOP 10 * FROM RetailAnalytics.CampaignSales;

SELECT TOP 10 * FROM RetailAnalytics.DiscountAudit;

-- FK relationships working
SELECT 
    cs.CampaignID,
    cs.ProductID,
    pc.CampaignName,
    pp.ProductName
FROM RetailAnalytics.CampaignSales cs
JOIN RetailAnalytics.PromotionCampaign pc
    ON cs.CampaignID = pc.CampaignID
JOIN RetailAnalytics.ProductPerformance pp
    ON cs.ProductID = pp.ProductID;

SELECT TOP 10 *
FROM RetailAnalytics.CampaignSales cs
JOIN RetailAnalytics.PromotionCampaign pc
ON cs.CampaignID = pc.CampaignID;