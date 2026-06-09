/*
    check_discounts.sql
    Author  : Sahil
    Purpose : Validate discount rates, revenue calculations, and audit integrity
              across the RetailAnalytics schema.
    Database: AdventureWorks2022

    Screenshots:
    1. Open diagrams/retail_analytics_er_diagram.drawio in draw.io
    2. Run this script in SSMS after deployment and capture the output
*/

USE AdventureWorks2022;
GO

SET NOCOUNT ON;
GO

PRINT '=================================================================';
PRINT 'Discount Validation Script - Sahil';
PRINT 'Schema : RetailAnalytics';
PRINT 'Run Date: ' + CONVERT(VARCHAR(30), SYSDATETIME(), 120);
PRINT '=================================================================';
GO

/* -------------------------------------------------------------------------
   Required T-SQL variables for reusable discount analysis
   ------------------------------------------------------------------------- */
DECLARE @MinimumDiscountRate DECIMAL(4, 3) = 0.000;
DECLARE @MaximumDiscountRate DECIMAL(4, 3) = 0.500;
DECLARE @InvalidCampaignCount INT = 0;
DECLARE @InvalidSalesCount INT = 0;
DECLARE @InvalidRevenueCount INT = 0;
DECLARE @InvalidAuditCount INT = 0;
DECLARE @TotalIssues INT = 0;

SET @MinimumDiscountRate = 0.000;
SET @MaximumDiscountRate = 0.500;

IF @MinimumDiscountRate < 0 OR @MaximumDiscountRate > 0.50
BEGIN
    PRINT 'Invalid discount range supplied. Using defaults 0.000 to 0.500.';
    SET @MinimumDiscountRate = 0.000;
    SET @MaximumDiscountRate = 0.500;
END
ELSE
BEGIN
    PRINT CONCAT(
        'Evaluating discounts between ',
        @MinimumDiscountRate,
        ' and ',
        @MaximumDiscountRate
    );
END;
GO

/* -------------------------------------------------------------------------
   Step 1: Confirm required tables exist
   ------------------------------------------------------------------------- */
PRINT '';
PRINT 'Step 1: Checking required RetailAnalytics tables...';
GO

DECLARE @MissingTableCount INT;

SELECT @MissingTableCount = COUNT(*)
FROM
(
    VALUES
        (N'RetailAnalytics.PromotionCampaign'),
        (N'RetailAnalytics.ProductPerformance'),
        (N'RetailAnalytics.CampaignSales'),
        (N'RetailAnalytics.DiscountAudit')
) AS required(ObjectName)
WHERE OBJECT_ID(required.ObjectName) IS NULL;

IF @MissingTableCount > 0
BEGIN
    PRINT 'Validation stopped. One or more RetailAnalytics tables are missing.';
    PRINT 'Execute deploy_all.sql before running this script.';

    SELECT
        required.ObjectName AS [Missing Table]
    FROM
    (
        VALUES
            (N'RetailAnalytics.PromotionCampaign'),
            (N'RetailAnalytics.ProductPerformance'),
            (N'RetailAnalytics.CampaignSales'),
            (N'RetailAnalytics.DiscountAudit')
    ) AS required(ObjectName)
    WHERE OBJECT_ID(required.ObjectName) IS NULL;

    RETURN;
END
ELSE
BEGIN
    PRINT 'All required RetailAnalytics tables exist.';
END;
GO

/* -------------------------------------------------------------------------
   Step 2: Validate promotion campaign discount rates
   ------------------------------------------------------------------------- */
PRINT '';
PRINT 'Step 2: Validating PromotionCampaign discount rates...';
GO

DECLARE @MinimumDiscountRate DECIMAL(4, 3) = 0.000;
DECLARE @MaximumDiscountRate DECIMAL(4, 3) = 0.500;
DECLARE @InvalidCampaignCount INT = 0;

SELECT @InvalidCampaignCount = COUNT(*)
FROM RetailAnalytics.PromotionCampaign AS pc
WHERE pc.DiscountRate < @MinimumDiscountRate
   OR pc.DiscountRate > @MaximumDiscountRate
   OR pc.CampaignName = N''
   OR pc.CampaignCode = N'';

IF @InvalidCampaignCount = 0
BEGIN
    PRINT 'PromotionCampaign discount validation passed.';
END
ELSE
BEGIN
    PRINT CONCAT('PromotionCampaign discount validation failed. Issues found: ', @InvalidCampaignCount);

    SELECT
        pc.CampaignCode AS [Campaign Code],
        pc.CampaignName AS [Campaign Name],
        pc.DiscountRate AS [Discount Rate],
        N'Invalid campaign discount or empty name/code' AS [Validation Message]
    FROM RetailAnalytics.PromotionCampaign AS pc
    WHERE pc.DiscountRate < @MinimumDiscountRate
       OR pc.DiscountRate > @MaximumDiscountRate
       OR pc.CampaignName = N''
       OR pc.CampaignCode = N'';
END;
GO

/* -------------------------------------------------------------------------
   Step 3: Validate campaign sales discount rates
   ------------------------------------------------------------------------- */
PRINT '';
PRINT 'Step 3: Validating CampaignSales discount rates...';
GO

DECLARE @MinimumDiscountRate DECIMAL(4, 3) = 0.000;
DECLARE @MaximumDiscountRate DECIMAL(4, 3) = 0.500;
DECLARE @InvalidSalesCount INT = 0;

SELECT @InvalidSalesCount = COUNT(*)
FROM RetailAnalytics.CampaignSales AS cs
WHERE cs.DiscountRate < @MinimumDiscountRate
   OR cs.DiscountRate > @MaximumDiscountRate
   OR cs.QuantitySold <= 0
   OR cs.UnitPrice <= 0
   OR cs.Revenue < 0;

IF @InvalidSalesCount = 0
BEGIN
    PRINT 'CampaignSales discount validation passed.';
END
ELSE
BEGIN
    PRINT CONCAT('CampaignSales discount validation failed. Issues found: ', @InvalidSalesCount);

    SELECT TOP (20)
        cs.CampaignSalesID AS [Campaign Sales ID],
        cs.SalesOrderID AS [Sales Order ID],
        cs.DiscountRate AS [Discount Rate],
        cs.QuantitySold AS [Quantity Sold],
        cs.UnitPrice AS [Unit Price],
        cs.Revenue AS [Revenue],
        N'Invalid sales discount or related business rule' AS [Validation Message]
    FROM RetailAnalytics.CampaignSales AS cs
    WHERE cs.DiscountRate < @MinimumDiscountRate
       OR cs.DiscountRate > @MaximumDiscountRate
       OR cs.QuantitySold <= 0
       OR cs.UnitPrice <= 0
       OR cs.Revenue < 0
    ORDER BY cs.CampaignSalesID;
END;
GO

/* -------------------------------------------------------------------------
   Step 4: Validate revenue calculation formula
   Revenue = QuantitySold x UnitPrice x (1 - DiscountRate)
   ------------------------------------------------------------------------- */
PRINT '';
PRINT 'Step 4: Validating revenue calculations...';
GO

DECLARE @InvalidRevenueCount INT = 0;

SELECT @InvalidRevenueCount = COUNT(*)
FROM RetailAnalytics.CampaignSales AS cs
WHERE ABS(
        cs.Revenue -
        CAST(cs.QuantitySold * cs.UnitPrice * (1.0 - cs.DiscountRate) AS MONEY)
      ) > 0.01;

IF @InvalidRevenueCount = 0
BEGIN
    PRINT 'Revenue calculation validation passed.';
END
ELSE
BEGIN
    PRINT CONCAT('Revenue calculation validation failed. Issues found: ', @InvalidRevenueCount);

    SELECT TOP (20)
        cs.CampaignSalesID AS [Campaign Sales ID],
        cs.QuantitySold AS [Quantity Sold],
        cs.UnitPrice AS [Unit Price],
        cs.DiscountRate AS [Discount Rate],
        cs.Revenue AS [Stored Revenue],
        CAST(cs.QuantitySold * cs.UnitPrice * (1.0 - cs.DiscountRate) AS MONEY) AS [Expected Revenue],
        N'Revenue does not match required formula' AS [Validation Message]
    FROM RetailAnalytics.CampaignSales AS cs
    WHERE ABS(
            cs.Revenue -
            CAST(cs.QuantitySold * cs.UnitPrice * (1.0 - cs.DiscountRate) AS MONEY)
          ) > 0.01
    ORDER BY cs.CampaignSalesID;
END;
GO

/* -------------------------------------------------------------------------
   Step 5: Validate DiscountAudit records
   ------------------------------------------------------------------------- */
PRINT '';
PRINT 'Step 5: Validating DiscountAudit records...';
GO

DECLARE @InvalidAuditCount INT = 0;

SELECT @InvalidAuditCount = COUNT(*)
FROM RetailAnalytics.DiscountAudit AS da
WHERE da.DiscountRate < 0
   OR da.DiscountRate > 0.50
   OR da.ValidationStatus NOT IN (N'Valid', N'Invalid')
   OR da.ValidationMessage = N'';

IF @InvalidAuditCount = 0
BEGIN
    PRINT 'DiscountAudit validation passed.';
END
ELSE
BEGIN
    PRINT CONCAT('DiscountAudit validation failed. Issues found: ', @InvalidAuditCount);

    SELECT TOP (20)
        da.AuditID AS [Audit ID],
        da.DiscountRate AS [Discount Rate],
        da.ValidationStatus AS [Validation Status],
        da.ValidationMessage AS [Validation Message]
    FROM RetailAnalytics.DiscountAudit AS da
    WHERE da.DiscountRate < 0
       OR da.DiscountRate > 0.50
       OR da.ValidationStatus NOT IN (N'Valid', N'Invalid')
       OR da.ValidationMessage = N''
    ORDER BY da.AuditID;
END;
GO

/* -------------------------------------------------------------------------
   Step 6: Discount summary for screenshot evidence
   ------------------------------------------------------------------------- */
PRINT '';
PRINT 'Step 6: Discount validation summary...';
GO

SELECT
    N'PromotionCampaign' AS [Source Table],
    COUNT(*) AS [Total Records],
    SUM(CASE WHEN pc.DiscountRate >= 0 AND pc.DiscountRate <= 0.50 THEN 1 ELSE 0 END) AS [Valid Discounts],
    SUM(CASE WHEN pc.DiscountRate < 0 OR pc.DiscountRate > 0.50 THEN 1 ELSE 0 END) AS [Invalid Discounts],
    MIN(pc.DiscountRate) AS [Minimum Discount Rate],
    MAX(pc.DiscountRate) AS [Maximum Discount Rate],
    AVG(pc.DiscountRate) AS [Average Discount Rate]
FROM RetailAnalytics.PromotionCampaign AS pc

UNION ALL

SELECT
    N'CampaignSales',
    COUNT(*),
    SUM(CASE WHEN cs.DiscountRate >= 0 AND cs.DiscountRate <= 0.50 THEN 1 ELSE 0 END),
    SUM(CASE WHEN cs.DiscountRate < 0 OR cs.DiscountRate > 0.50 THEN 1 ELSE 0 END),
    MIN(cs.DiscountRate),
    MAX(cs.DiscountRate),
    AVG(cs.DiscountRate)
FROM RetailAnalytics.CampaignSales AS cs

UNION ALL

SELECT
    N'DiscountAudit',
    COUNT(*),
    SUM(CASE WHEN da.ValidationStatus = N'Valid' THEN 1 ELSE 0 END),
    SUM(CASE WHEN da.ValidationStatus = N'Invalid' THEN 1 ELSE 0 END),
    MIN(da.DiscountRate),
    MAX(da.DiscountRate),
    AVG(da.DiscountRate)
FROM RetailAnalytics.DiscountAudit AS da;
GO

SELECT
    da.ValidationStatus AS [Validation Status],
    COUNT(*) AS [Record Count]
FROM RetailAnalytics.DiscountAudit AS da
GROUP BY da.ValidationStatus
ORDER BY da.ValidationStatus;
GO

/* -------------------------------------------------------------------------
   Step 7: Confirm discount-related check constraints are enabled
   ------------------------------------------------------------------------- */
PRINT '';
PRINT 'Step 7: Checking discount check constraints...';
GO

SELECT
    SCHEMA_NAME(t.schema_id) AS [Schema Name],
    t.name AS [Table Name],
    cc.name AS [Constraint Name],
    cc.is_disabled AS [Is Disabled],
    cc.is_not_trusted AS [Is Not Trusted]
FROM sys.check_constraints AS cc
INNER JOIN sys.tables AS t
    ON cc.parent_object_id = t.object_id
WHERE SCHEMA_NAME(t.schema_id) = N'RetailAnalytics'
  AND cc.name LIKE N'%DiscountRate%'
ORDER BY t.name, cc.name;
GO

DECLARE @DisabledConstraintCount INT;

SELECT @DisabledConstraintCount = COUNT(*)
FROM sys.check_constraints AS cc
INNER JOIN sys.tables AS t
    ON cc.parent_object_id = t.object_id
WHERE SCHEMA_NAME(t.schema_id) = N'RetailAnalytics'
  AND cc.name LIKE N'%DiscountRate%'
  AND cc.is_disabled = 1;

IF @DisabledConstraintCount = 0
BEGIN
    PRINT 'All discount check constraints are enabled.';
    PRINT 'Discount validation completed successfully.';
END
ELSE
BEGIN
    PRINT CONCAT('Warning: ', @DisabledConstraintCount, ' discount constraint(s) are disabled.');
    PRINT 'Review constraint lifecycle results before final submission.';
END;
GO

PRINT '=================================================================';
PRINT 'End of check_discounts.sql';
PRINT '=================================================================';
GO
