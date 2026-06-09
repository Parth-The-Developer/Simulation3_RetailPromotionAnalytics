/********************************************************************************
    File   : scripts/functions/ufn_GetDiscountRate.sql
    Owner  : Sahasri (Step 4)
    Purpose: Scalar function - calculate discount rate from list and discounted price
********************************************************************************/

USE RetailPromotionAnalytics;
GO

CREATE OR ALTER FUNCTION RetailAnalytics.ufn_GetDiscountRate
(
    @ListPrice MONEY,
    @DiscountedPrice MONEY
)
RETURNS DECIMAL(4,3)
AS
BEGIN
    IF @ListPrice IS NULL OR @ListPrice = 0 OR @DiscountedPrice IS NULL
        RETURN NULL;

    RETURN (@ListPrice - @DiscountedPrice) / @ListPrice;
END;
GO
