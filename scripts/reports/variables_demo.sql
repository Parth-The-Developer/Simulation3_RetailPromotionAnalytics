/********************************************************************************
    File: scripts/reports/variables_demo.sql
    Owner: Lien (Step 4)
    Purpose: Variables / control-flow demo (ER diagram with Sahil)
    Database: RetailPromotionAnalytics | Schema: RetailAnalytics
    Status: STUB - to be implemented.
********************************************************************************/
USE AdventureWorks2022;
GO

SET NOCOUNT ON;

-- Section 1: Declare and initialize variables
DECLARE @CampaignCode          NVARCHAR(20) = 'SPRING25';
DECLARE @ProductCategory       NVARCHAR(100) = 'Bikes';
DECLARE @Region                NVARCHAR(50) = 'Northwest';
DECLARE @MinimumRevenue        MONEY = 10000;
DECLARE @MinimumDiscountRate   DECIMAL(4,3) = 0.20;

-- Section 2: Print variable values for verification
PRINT '=== VARIABLE DEMONSTRATION START ===';
PRINT 'User-defined analysis parameters:';
PRINT '  @CampaignCode        = ' + ISNULL(@CampaignCode, 'NULL');
PRINT '  @ProductCategory     = ' + ISNULL(@ProductCategory, 'NULL');
PRINT '  @Region              = ' + ISNULL(@Region, 'NULL');
PRINT '  @MinimumRevenue      = ' + ISNULL(CONVERT(NVARCHAR(20), @MinimumRevenue), 'NULL');
PRINT '  @MinimumDiscountRate = ' + ISNULL(CONVERT(NVARCHAR(20), @MinimumDiscountRate), 'NULL');
PRINT '';

-- Section 3: Discount analysis - checks if a specified discount rate exceeds the allowed 50% maximum
IF @MinimumDiscountRate > 0.50
BEGIN
    PRINT 'WARNING: @MinimumDiscountRate exceeds the allowed maximum discount rate (0.50).';
    PRINT 'Please adjust the variable to a value between 0.00 and 0.50.';
END
ELSE IF @MinimumDiscountRate < 0
BEGIN
    PRINT 'ERROR: @MinimumDiscountRate cannot be negative.';
END
ELSE
BEGIN
    PRINT 'Discount rate validation: passed.';
    PRINT 'Proceeding with discount analysis using threshold = ' + CAST(@MinimumDiscountRate AS NVARCHAR(10));
END
PRINT '';

-- Section 4: Dynamic campaign revenue analysis that uses @CampaignCode to show revenue for a specific campaign
IF EXISTS (SELECT 1 FROM RetailAnalytics.PromotionCampaign WHERE CampaignCode = @CampaignCode)
BEGIN
    PRINT '--- Campaign Revenue for ' + @CampaignCode + ' ---';
    SELECT 
        pc.CampaignName,
        SUM(cs.Revenue) AS TotalRevenue,
        SUM(cs.QuantitySold) AS TotalUnits,
        AVG(cs.DiscountRate) AS AvgDiscount
    FROM RetailAnalytics.PromotionCampaign pc
    INNER JOIN RetailAnalytics.CampaignSales cs ON pc.CampaignID = cs.CampaignID
    WHERE pc.CampaignCode = @CampaignCode
    GROUP BY pc.CampaignName;
END
ELSE
BEGIN
    PRINT 'Campaign code ' + @CampaignCode + ' does not exist. Skipping campaign revenue analysis.';
END
PRINT '';

-- Section 5: Product category and region filtered sales
PRINT '--- Filtered Sales (Category = ' + @ProductCategory + ', Region = ' + @Region + ') ---';
SELECT TOP 10
    cs.SalesOrderID,
    cs.OrderDate,
    cs.Region,
    pp.ProductName,
    cs.QuantitySold,
    cs.Revenue,
    cs.DiscountRate
FROM RetailAnalytics.CampaignSales cs
INNER JOIN RetailAnalytics.ProductPerformance pp ON cs.ProductID = pp.ProductID
WHERE pp.ProductCategory = @ProductCategory
  AND cs.Region = @Region
ORDER BY cs.Revenue DESC;

-- Section 6: Discount analysis – products with discount rate above threshold
PRINT '';
PRINT '--- Products with Discount Rate >= ' + CAST(@MinimumDiscountRate AS NVARCHAR(10)) + ' ---';
SELECT DISTINCT
    pp.ProductName,
    pp.ProductCategory,
    cs.DiscountRate,
    SUM(cs.Revenue) AS TotalRevenue
FROM RetailAnalytics.CampaignSales cs
INNER JOIN RetailAnalytics.ProductPerformance pp ON cs.ProductID = pp.ProductID
WHERE cs.DiscountRate >= @MinimumDiscountRate
GROUP BY pp.ProductName, pp.ProductCategory, cs.DiscountRate
ORDER BY cs.DiscountRate DESC;

-- Section 7: High‑revenue campaigns (minimum revenue threshold)
PRINT '';
PRINT '--- Campaigns with Revenue >= ' + CAST(@MinimumRevenue AS NVARCHAR(20)) + ' ---';
SELECT 
    pc.CampaignName,
    pc.CampaignCode,
    SUM(cs.Revenue) AS TotalRevenue
FROM RetailAnalytics.PromotionCampaign pc
INNER JOIN RetailAnalytics.CampaignSales cs ON pc.CampaignID = cs.CampaignID
GROUP BY pc.CampaignName, pc.CampaignCode
HAVING SUM(cs.Revenue) >= @MinimumRevenue
ORDER BY TotalRevenue DESC;

PRINT '=== END OF DEMO ===';
GO
