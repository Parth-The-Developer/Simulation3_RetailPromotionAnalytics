/********************************************************************************
    File   : scripts/procedures/usp_GetCampaignRevenue.sql
    Owner  : Joshua (Step 4)
    Purpose: Campaign revenue reporting procedure
    Database: RetailPromotionAnalytics
    Schema  : RetailAnalytics
********************************************************************************/

USE RetailPromotionAnalytics;
GO

CREATE OR ALTER PROCEDURE RetailAnalytics.usp_GetCampaignRevenue
    @CampaignCode NVARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    IF @CampaignCode IS NULL OR LTRIM(RTRIM(@CampaignCode)) = ''
    BEGIN
        RAISERROR('Campaign code cannot be empty.',16,1);
        RETURN;
    END;

    SELECT
        pc.CampaignCode,
        pc.CampaignName,
        SUM(cs.Revenue) AS TotalRevenue,
        SUM(cs.QuantitySold) AS TotalUnitsSold,
        AVG(cs.DiscountRate) AS AverageDiscount
    FROM RetailAnalytics.CampaignSales cs
    INNER JOIN RetailAnalytics.PromotionCampaign pc
        ON cs.CampaignID = pc.CampaignID
    WHERE pc.CampaignCode = @CampaignCode
    GROUP BY
        pc.CampaignCode,
        pc.CampaignName;
END;
GO

PRINT 'Procedure RetailAnalytics.usp_GetCampaignRevenue created.';
GO