/*======================================================================
    File   : scripts/functions/ufn_GetDiscountRate.sql
    Owner  : Sahasri (Step 4)
    Purpose: Scalar function: discount rate
    Status : STUB - to be implemented.
======================================================================*/

CREATE FUNCTION ufn_GetDiscountRate
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
