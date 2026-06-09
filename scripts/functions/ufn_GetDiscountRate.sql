/********************************************************************************
    File   : scripts/functions/ufn_GetDiscountRate.sql
    Owner  : Sahasri (Step 4)
    Purpose: Scalar function - calculate discount rate as a percentage (0.000 - 1.000)
    Formula: (ListPrice - DiscountedPrice) / ListPrice
    Notes  : Aligns with Kelvin's DECIMAL(4,3) discount columns and Hassana's
             CampaignSales.DiscountRate values loaded from AdventureWorks2022.
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
    -- NULL and zero-guard: cannot divide by zero or compute without inputs
    IF @ListPrice IS NULL OR @ListPrice <= 0 OR @DiscountedPrice IS NULL
        RETURN NULL;

    -- Invalid business case: discounted price cannot exceed list price
    IF @DiscountedPrice > @ListPrice
        RETURN NULL;

    DECLARE @Rate DECIMAL(4,3) = (@ListPrice - @DiscountedPrice) / @ListPrice;

    -- Enforce same business rule as Kelvin's CHECK constraints (0 - 0.50)
    IF @Rate < 0 OR @Rate > 0.50
        RETURN NULL;

    RETURN @Rate;
END;
GO

PRINT 'Function [RetailAnalytics.ufn_GetDiscountRate] created.';
GO
