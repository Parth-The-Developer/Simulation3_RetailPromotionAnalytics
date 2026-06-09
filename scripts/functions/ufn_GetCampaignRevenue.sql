/*======================================================================
    File   : scripts/functions/ufn_GetCampaignRevenue.sql
    Owner  : Sahasri (Step 4)
    Purpose: Scalar function: campaign revenue
    Status : STUB - to be implemented.
======================================================================*/

CREATE FUNCTION ufn_GetCampaignRevenue
(
    @QuantitySold INT,
    @UnitPrice MONEY,
    @DiscountRate DECIMAL(4,3)
)
RETURNS MONEY
AS
BEGIN
    IF @QuantitySold IS NULL OR @UnitPrice IS NULL OR @DiscountRate IS NULL
        RETURN NULL;

    RETURN @QuantitySold * @UnitPrice * (1 - @DiscountRate);
END;