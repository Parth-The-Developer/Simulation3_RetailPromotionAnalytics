-- Stored Procedure: RetailAnalytics.usp_GetRegionalSales
-- Purpose: Analyzes sales by region (total orders, total revenue, ave. revenue per order) for a given region.


CREATE OR ALTER PROCEDURE RetailAnalytics.usp_GetRegionalSales
    @Region NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    -- Parameter validation
    IF @Region IS NULL OR LTRIM(RTRIM(@Region)) = ''
    BEGIN
        THROW 50002, '@Region cannot be NULL or empty.', 1;
    END;

    BEGIN TRY
        -- Compute regional sales metrics
        SELECT
            cs.Region                   AS [Region],
            COUNT(DISTINCT cs.SalesOrderID) AS [Total Orders],
            SUM(cs.Revenue)             AS [Total Revenue],
            SUM(cs.Revenue) / NULLIF(COUNT(DISTINCT cs.SalesOrderID), 0) 
                                        AS [Average Revenue Per Order]
        FROM
            RetailAnalytics.CampaignSales cs
        WHERE
            cs.Region = @Region
        GROUP BY
            cs.Region;
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH;
END;
GO

-- Sample execution statements:
-- EXEC RetailAnalytics.usp_GetRegionalSales 'Northwest';
-- EXEC RetailAnalytics.usp_GetRegionalSales 'Central';