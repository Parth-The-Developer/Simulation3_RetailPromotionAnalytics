/********************************************************************************
-- Stored Procedure: RetailAnalytics.usp_GetCategoryPerformance
-- Purpose: Returns category-level sales performance for a given product category.
********************************************************************************/

CREATE OR ALTER PROCEDURE RetailAnalytics.usp_GetCategoryPerformance
    @CategoryName NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    -- Parameter validation
    IF @CategoryName IS NULL OR LTRIM(RTRIM(@CategoryName)) = ''
    BEGIN
        THROW 50001, '@CategoryName cannot be NULL or empty.', 1;
    END;

    BEGIN TRY
        SELECT
            pp.ProductCategory      AS [Product Category],
            SUM(cs.Revenue)         AS [Total Revenue],
            SUM(cs.QuantitySold)    AS [Total Units Sold],
            AVG(cs.DiscountRate)    AS [Average Discount Rate]
        FROM
            RetailAnalytics.CampaignSales cs
            INNER JOIN RetailAnalytics.ProductPerformance pp
                ON cs.ProductID = pp.ProductID
        WHERE
            pp.ProductCategory = @CategoryName
        GROUP BY
            pp.ProductCategory
        ORDER BY
            [Total Revenue] DESC;
    END TRY
    BEGIN CATCH
        -- Re-throw the original error
        THROW;
    END CATCH;
END;
GO

-- Sample execution statements:
-- EXEC RetailAnalytics.usp_GetCategoryPerformance 'Bikes';
-- EXEC RetailAnalytics.usp_GetCategoryPerformance 'Clothing';
