/********************************************************************************
    File   : scripts/functions/ufn_GetProductsByColor.sql
    Owner  : Dhruv (Step 4)
    Purpose: Inline table-valued function - products by color
    Database: RetailPromotionAnalytics | Schema: RetailAnalytics
    Source  : Kelvin ProductPerformance table (Hassana data load)
********************************************************************************/

USE RetailPromotionAnalytics;
GO

CREATE OR ALTER FUNCTION RetailAnalytics.ufn_GetProductsByColor
(
    @Color NVARCHAR(15)
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        pp.ProductID,
        pp.ProductName,
        pp.ProductNumber,
        pp.ProductCategory,
        pp.Color,
        pp.ListPrice
    FROM RetailAnalytics.ProductPerformance pp
    WHERE pp.Color = @Color
      AND pp.Color IS NOT NULL
);
GO

PRINT 'Function [RetailAnalytics.ufn_GetProductsByColor] created.';
GO

-- Sample execution:
-- SELECT * FROM RetailAnalytics.ufn_GetProductsByColor(N'Red');
-- SELECT * FROM RetailAnalytics.ufn_GetProductsByColor(N'Black');
