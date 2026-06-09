/********************************************************************************
    File   : scripts/functions/ufn_GetCampaignRevenue.sql
    Owner  : Sahasri (Step 4)
    Purpose: Scalar function - calculate campaign line revenue
    Formula: QuantitySold x UnitPrice x (1 - DiscountRate)
    Notes  : Matches Kelvin's CampaignSales.Revenue rule and Hassana's load script:
             sod.OrderQty * sod.UnitPrice * (1 - sod.UnitPriceDiscount)
********************************************************************************/

USE RetailPromotionAnalytics;
GO

CREATE OR ALTER FUNCTION RetailAnalytics.ufn_GetCampaignRevenue
(
    @QuantitySold INT,
    @UnitPrice MONEY,
    @DiscountRate DECIMAL(4,3)
)
RETURNS MONEY
AS
BEGIN
    -- NULL guard
    IF @QuantitySold IS NULL OR @UnitPrice IS NULL OR @DiscountRate IS NULL
        RETURN NULL;

    -- Kelvin's CK_RetailAnalytics_CampaignSales_Qty: QuantitySold > 0
    IF @QuantitySold <= 0
        RETURN NULL;

    -- Kelvin's CK_RetailAnalytics_CampaignSales_Discount: 0 - 0.50
    IF @DiscountRate < 0 OR @DiscountRate > 0.50
        RETURN NULL;

    DECLARE @Revenue MONEY = @QuantitySold * @UnitPrice * (1 - @DiscountRate);

    -- Kelvin's CK_RetailAnalytics_CampaignSales_Revenue: Revenue >= 0
    IF @Revenue < 0
        RETURN NULL;

    RETURN @Revenue;
END;
GO

PRINT 'Function [RetailAnalytics.ufn_GetCampaignRevenue] created.';
GO
