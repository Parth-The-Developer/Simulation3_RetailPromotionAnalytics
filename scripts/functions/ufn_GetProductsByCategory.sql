/********************************************************************************
    File   : scripts/functions/ufn_GetProductsByCategory.sql
    Owner  : Dhruv (Step 4)
    Purpose: Inline table-valued function - products by category
    Database: RetailPromotionAnalytics | Schema: RetailAnalytics
    Source  : Kelvin ProductPerformance table (Hassana data load)
********************************************************************************/

USE RetailPromotionAnalytics;
GO

CREATE OR ALTER FUNCTION RetailAnalytics.ufn_GetProductsByCategory
(
    @CategoryName NVARCHAR(100)
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
    WHERE pp.ProductCategory = @CategoryName
);
GO

PRINT 'Function [RetailAnalytics.ufn_GetProductsByCategory] created.';
GO

-- Sample execution:
-- SELECT * FROM RetailAnalytics.ufn_GetProductsByCategory(N'Bikes');
-- SELECT * FROM RetailAnalytics.ufn_GetProductsByCategory(N'Clothing');
