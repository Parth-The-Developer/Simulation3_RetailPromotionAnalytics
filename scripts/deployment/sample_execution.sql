/********************************************************************************
    File   : scripts/deployment/sample_execution.sql
    Owner  : Joshua (Step 6)
    Purpose: Sample end-to-end execution / smoke test after deploy_all.sql
    Database: RetailPromotionAnalytics | Schema: RetailAnalytics
    Prereq  : Run deploy_all.sql first.
********************************************************************************/

USE RetailPromotionAnalytics;
GO

SET NOCOUNT ON;

PRINT '=================================================================';
PRINT 'Sample Execution Smoke Test - Joshua';
PRINT 'Database: RetailPromotionAnalytics';
PRINT 'Schema  : RetailAnalytics';
PRINT 'Run Date: ' + CONVERT(VARCHAR(30), SYSDATETIME(), 120);
PRINT '=================================================================';
GO

----------------------------------------------------------------------
-- 1) Confirm core tables and row counts
----------------------------------------------------------------------
PRINT '';
PRINT 'Step 1: Table row counts';
GO

SELECT
    t.TableName,
    t.[Row Count]
FROM
(
    SELECT N'PromotionCampaign' AS TableName, COUNT(*) AS [Row Count]
    FROM RetailAnalytics.PromotionCampaign
    UNION ALL
    SELECT N'ProductPerformance', COUNT(*) FROM RetailAnalytics.ProductPerformance
    UNION ALL
    SELECT N'CampaignSales', COUNT(*) FROM RetailAnalytics.CampaignSales
    UNION ALL
    SELECT N'DiscountAudit', COUNT(*) FROM RetailAnalytics.DiscountAudit
) AS t
ORDER BY t.TableName;
GO

----------------------------------------------------------------------
-- 2) Scalar functions (Sahasri)
----------------------------------------------------------------------
PRINT '';
PRINT 'Step 2: Scalar function samples';
GO

SELECT
    RetailAnalytics.ufn_GetDiscountRate(100.00, 75.00) AS [Discount Rate Sample],
    RetailAnalytics.ufn_GetCampaignRevenue(10, 25.00, 0.20) AS [Revenue Sample];
GO

----------------------------------------------------------------------
-- 3) Table-valued functions (Dhruv)
----------------------------------------------------------------------
PRINT '';
PRINT 'Step 3: Table-valued function samples';
GO

SELECT TOP 5 * FROM RetailAnalytics.ufn_GetProductsByCategory(N'Bikes');
GO

SELECT TOP 5 * FROM RetailAnalytics.ufn_GetProductsByColor(N'Red');
GO

----------------------------------------------------------------------
-- 4) Stored procedures (Josó + Brian)
----------------------------------------------------------------------
PRINT '';
PRINT 'Step 4: Stored procedure samples';
GO

EXEC RetailAnalytics.usp_GetCampaignRevenue @CampaignCode = N'SPRING25';
GO

EXEC RetailAnalytics.usp_GetTopDiscountedProducts @MinimumDiscountRate = 0.20;
GO

EXEC RetailAnalytics.usp_GetCategoryPerformance @CategoryName = N'Bikes';
GO

EXEC RetailAnalytics.usp_GetRegionalSales @Region = N'Northwest';
GO

----------------------------------------------------------------------
-- 5) Quick validation summary
----------------------------------------------------------------------
PRINT '';
PRINT 'Step 5: Discount audit summary';
GO

SELECT
    da.ValidationStatus AS [Validation Status],
    COUNT(*)            AS [Record Count]
FROM RetailAnalytics.DiscountAudit AS da
GROUP BY da.ValidationStatus
ORDER BY da.ValidationStatus;
GO

PRINT '=================================================================';
PRINT 'Sample execution completed successfully.';
PRINT '=================================================================';
GO
