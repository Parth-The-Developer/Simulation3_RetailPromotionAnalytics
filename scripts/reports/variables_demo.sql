/********************************************************************************
    File   : scripts/reports/variables_demo.sql
    Owner  : Lien (Step 4)
    Purpose: T-SQL variables and control-flow demo (ER diagram with Sahil)
    Database: RetailPromotionAnalytics | Schema: RetailAnalytics
    Source  : Kelvin tables + Hassana data load

    Required variables (spec): @CampaignCode, @ProductCategory, @Region,
                              @MinimumRevenue, @MinimumDiscountRate
    Required statements: DECLARE, SET, PRINT, IF...ELSE, SELECT
********************************************************************************/

USE RetailPromotionAnalytics;
GO

SET NOCOUNT ON;

-- Section 1: DECLARE variables
DECLARE @CampaignCode        NVARCHAR(20);
DECLARE @ProductCategory     NVARCHAR(100);
DECLARE @Region              NVARCHAR(50);
DECLARE @MinimumRevenue      MONEY;
DECLARE @MinimumDiscountRate DECIMAL(4,3);

-- Section 2: SET variable values (Hassana campaign codes)
SET @CampaignCode        = N'SPRING25';
SET @ProductCategory     = N'Bikes';
SET @Region              = N'Northwest';
SET @MinimumRevenue      = 10000;
SET @MinimumDiscountRate = 0.20;

-- Section 3: PRINT variable values
PRINT '=== VARIABLE DEMONSTRATION START ===';
PRINT 'User-defined analysis parameters:';
PRINT '  @CampaignCode        = ' + ISNULL(@CampaignCode, N'NULL');
PRINT '  @ProductCategory     = ' + ISNULL(@ProductCategory, N'NULL');
PRINT '  @Region              = ' + ISNULL(@Region, N'NULL');
PRINT '  @MinimumRevenue      = ' + ISNULL(CONVERT(NVARCHAR(30), @MinimumRevenue), N'NULL');
PRINT '  @MinimumDiscountRate = ' + ISNULL(CONVERT(NVARCHAR(10), @MinimumDiscountRate), N'NULL');
PRINT '';

-- Section 4: IF...ELSE discount threshold validation (Kelvin CK: 0 - 0.50)
IF @MinimumDiscountRate > 0.50
BEGIN
    PRINT 'WARNING: @MinimumDiscountRate exceeds maximum allowed discount (0.50).';
    SET @MinimumDiscountRate = 0.50;
    PRINT 'Adjusted @MinimumDiscountRate to 0.50.';
END
ELSE IF @MinimumDiscountRate < 0
BEGIN
    PRINT 'ERROR: @MinimumDiscountRate cannot be negative.';
    SET @MinimumDiscountRate = 0;
    PRINT 'Adjusted @MinimumDiscountRate to 0.';
END
ELSE
BEGIN
    PRINT 'Discount rate validation: passed.';
    PRINT 'Using discount threshold = ' + CAST(@MinimumDiscountRate AS NVARCHAR(10));
END
PRINT '';

-- Section 5: Campaign revenue for @CampaignCode
IF EXISTS (SELECT 1 FROM RetailAnalytics.PromotionCampaign WHERE CampaignCode = @CampaignCode)
BEGIN
    PRINT '--- Campaign Revenue for ' + @CampaignCode + ' ---';
    SELECT
        pc.CampaignName                         AS [Campaign Name],
        SUM(cs.Revenue)                         AS [Total Revenue],
        SUM(cs.QuantitySold)                    AS [Total Units Sold],
        AVG(cs.DiscountRate)                    AS [Average Discount Rate]
    FROM RetailAnalytics.PromotionCampaign pc
    INNER JOIN RetailAnalytics.CampaignSales cs ON pc.CampaignID = cs.CampaignID
    WHERE pc.CampaignCode = @CampaignCode
    GROUP BY pc.CampaignName;
END
ELSE
BEGIN
    PRINT 'Campaign code ' + @CampaignCode + ' not found. Skipping campaign analysis.';
END
PRINT '';

-- Section 6: Filtered sales by @ProductCategory and @Region
PRINT '--- Filtered Sales (Category = ' + @ProductCategory + ', Region = ' + @Region + ') ---';
SELECT TOP 10
    cs.SalesOrderID                         AS [Sales Order ID],
    cs.OrderDate                            AS [Order Date],
    cs.Region                               AS [Region],
    pp.ProductName                          AS [Product Name],
    cs.QuantitySold                         AS [Quantity Sold],
    cs.Revenue                              AS [Revenue],
    cs.DiscountRate                         AS [Discount Rate]
FROM RetailAnalytics.CampaignSales cs
INNER JOIN RetailAnalytics.ProductPerformance pp ON cs.ProductID = pp.ProductID
WHERE pp.ProductCategory = @ProductCategory
  AND cs.Region = @Region
ORDER BY cs.Revenue DESC;

-- Section 7: Products above @MinimumDiscountRate
PRINT '';
PRINT '--- Products with Discount Rate >= ' + CAST(@MinimumDiscountRate AS NVARCHAR(10)) + ' ---';
SELECT TOP 20
    pp.ProductName                          AS [Product Name],
    pp.ProductCategory                      AS [Product Category],
    cs.DiscountRate                         AS [Discount Rate],
    SUM(cs.Revenue)                         AS [Total Revenue]
FROM RetailAnalytics.CampaignSales cs
INNER JOIN RetailAnalytics.ProductPerformance pp ON cs.ProductID = pp.ProductID
WHERE cs.DiscountRate >= @MinimumDiscountRate
GROUP BY pp.ProductName, pp.ProductCategory, cs.DiscountRate
ORDER BY cs.DiscountRate DESC, [Total Revenue] DESC;

-- Section 8: Campaigns above @MinimumRevenue
PRINT '';
PRINT '--- Campaigns with Revenue >= ' + CAST(@MinimumRevenue AS NVARCHAR(30)) + ' ---';
SELECT
    pc.CampaignName                         AS [Campaign Name],
    pc.CampaignCode                         AS [Campaign Code],
    SUM(cs.Revenue)                         AS [Total Revenue]
FROM RetailAnalytics.PromotionCampaign pc
INNER JOIN RetailAnalytics.CampaignSales cs ON pc.CampaignID = cs.CampaignID
GROUP BY pc.CampaignName, pc.CampaignCode
HAVING SUM(cs.Revenue) >= @MinimumRevenue
ORDER BY [Total Revenue] DESC;

PRINT '=== VARIABLE DEMONSTRATION COMPLETE ===';
GO
