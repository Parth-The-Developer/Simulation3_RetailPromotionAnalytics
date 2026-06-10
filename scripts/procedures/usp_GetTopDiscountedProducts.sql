/********************************************************************************
    File   : scripts/procedures/usp_GetTopDiscountedProducts.sql
    Owner  : Joshua (Step 4)
    Purpose: Top discounted products procedure
    Database: RetailPromotionAnalytics
    Schema  : RetailAnalytics
********************************************************************************/

USE RetailPromotionAnalytics;
GO

CREATE OR ALTER PROCEDURE RetailAnalytics.usp_GetTopDiscountedProducts
    @MinimumDiscountRate DECIMAL(4,3)
AS
BEGIN
    SET NOCOUNT ON;

    IF @MinimumDiscountRate IS NULL OR @MinimumDiscountRate < 0 OR @MinimumDiscountRate > 0.50
    BEGIN
        RAISERROR('Minimum discount rate must be between 0 and 0.50.',16,1);
        RETURN;
    END;

    SELECT TOP 20
        pp.ProductName,
        pp.ProductCategory,
        cs.DiscountRate,
        pp.ListPrice,
        pp.ListPrice * (1 - cs.DiscountRate) AS DiscountedPrice,
        SUM(cs.Revenue) AS TotalRevenue
    FROM RetailAnalytics.CampaignSales cs
    INNER JOIN RetailAnalytics.ProductPerformance pp
        ON cs.ProductID = pp.ProductID
    WHERE cs.DiscountRate >= @MinimumDiscountRate
    GROUP BY
        pp.ProductName,
        pp.ProductCategory,
        cs.DiscountRate,
        pp.ListPrice
    ORDER BY
        cs.DiscountRate DESC,
        TotalRevenue DESC;
END;
GO

PRINT 'Procedure RetailAnalytics.usp_GetTopDiscountedProducts created.';
GO