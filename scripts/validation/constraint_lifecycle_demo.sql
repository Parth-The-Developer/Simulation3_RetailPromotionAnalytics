/********************************************************************************
    File   : scripts/validation/constraint_lifecycle_demo.sql
    Owner  : Parth (Step 5)
    Purpose: Constraint lifecycle demo (disable, test, fix, re-enable)
    Database: RetailPromotionAnalytics | Schema: RetailAnalytics
    Target : Kelvin CHECK constraint on PromotionCampaign.DiscountRate
    Prereq : Run create_schema.sql + Kelvin table scripts first.
********************************************************************************/

USE RetailPromotionAnalytics;
GO

SET NOCOUNT ON;

DECLARE @ConstraintName SYSNAME = N'CK_RetailAnalytics_PromotionCampaign_DiscountRate';
DECLARE @TestCampaignCode NVARCHAR(20) = N'LIFE001';

PRINT '=================================================================';
PRINT 'Constraint Lifecycle Demo - Parth';
PRINT 'Constraint: ' + @ConstraintName;
PRINT 'Run Date  : ' + CONVERT(VARCHAR(30), SYSDATETIME(), 120);
PRINT '=================================================================';
GO

-- Clean up any prior demo row so the script stays idempotent.
DELETE FROM RetailAnalytics.PromotionCampaign
WHERE CampaignCode = N'LIFE001';
GO

PRINT '';
PRINT 'Step 1: Confirm constraint exists and is enabled.';
GO

SELECT
    cc.name         AS [Constraint Name],
    t.name          AS [Table Name],
    cc.is_disabled  AS [Is Disabled],
    cc.is_not_trusted AS [Is Not Trusted]
FROM sys.check_constraints AS cc
INNER JOIN sys.tables AS t ON cc.parent_object_id = t.object_id
WHERE cc.name = N'CK_RetailAnalytics_PromotionCampaign_DiscountRate';
GO

PRINT '';
PRINT 'Step 2: Disable the discount CHECK constraint (NOCHECK).';
GO

ALTER TABLE RetailAnalytics.PromotionCampaign
    NOCHECK CONSTRAINT CK_RetailAnalytics_PromotionCampaign_DiscountRate;

PRINT 'Constraint disabled.';
GO

PRINT '';
PRINT 'Step 3: Insert invalid discount (0.750) while constraint is disabled.';
GO

BEGIN TRY
    INSERT INTO RetailAnalytics.PromotionCampaign
        (CampaignCode, CampaignName, CampaignType, StartDate, EndDate, DiscountRate)
    VALUES
        (N'LIFE001', N'Constraint Demo Bad Rate', N'Test', '2025-01-01', '2025-01-31', 0.750);

    PRINT 'Invalid row inserted successfully while constraint was disabled.';
END TRY
BEGIN CATCH
    PRINT 'Unexpected error during disabled-constraint insert: ' + ERROR_MESSAGE();
END CATCH;
GO

SELECT
    pc.CampaignCode,
    pc.CampaignName,
    pc.DiscountRate,
    N'Inserted while CHECK was disabled' AS [Demo Note]
FROM RetailAnalytics.PromotionCampaign AS pc
WHERE pc.CampaignCode = N'LIFE001';
GO

PRINT '';
PRINT 'Step 4: Fix data by removing the invalid demo row.';
GO

DELETE FROM RetailAnalytics.PromotionCampaign
WHERE CampaignCode = N'LIFE001';

PRINT 'Invalid demo row removed.';
GO

PRINT '';
PRINT 'Step 5: Re-enable the constraint WITH CHECK.';
GO

ALTER TABLE RetailAnalytics.PromotionCampaign
    WITH CHECK CHECK CONSTRAINT CK_RetailAnalytics_PromotionCampaign_DiscountRate;

PRINT 'Constraint re-enabled and trusted.';
GO

PRINT '';
PRINT 'Step 6: Attempt the same invalid insert with constraint enabled (should fail).';
GO

BEGIN TRY
    INSERT INTO RetailAnalytics.PromotionCampaign
        (CampaignCode, CampaignName, CampaignType, StartDate, EndDate, DiscountRate)
    VALUES
        (N'LIFE001', N'Constraint Demo Bad Rate', N'Test', '2025-01-01', '2025-01-31', 0.750);

    PRINT 'Unexpected: invalid row was inserted while constraint was enabled.';
END TRY
BEGIN CATCH
    PRINT 'Expected failure: ' + ERROR_MESSAGE();
END CATCH;
GO

PRINT '';
PRINT 'Step 7: Final constraint status.';
GO

SELECT
    cc.name           AS [Constraint Name],
    t.name            AS [Table Name],
    cc.is_disabled    AS [Is Disabled],
    cc.is_not_trusted AS [Is Not Trusted]
FROM sys.check_constraints AS cc
INNER JOIN sys.tables AS t ON cc.parent_object_id = t.object_id
WHERE cc.name = N'CK_RetailAnalytics_PromotionCampaign_DiscountRate';
GO

PRINT 'Constraint lifecycle demo completed successfully.';
GO
