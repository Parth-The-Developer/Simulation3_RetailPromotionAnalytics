USE RetailPromotionAnalytics;
GO

SELECT
    pc.CampaignName,
    pp.ProductCategory,
    SUM(cs.Revenue) AS TotalRevenue,
    AVG(cs.DiscountRate) AS AverageDiscountRate,
    SUM(cs.QuantitySold) AS UnitsSold
FROM RetailAnalytics.CampaignSales cs
INNER JOIN RetailAnalytics.PromotionCampaign pc
    ON cs.CampaignID = pc.CampaignID
INNER JOIN RetailAnalytics.ProductPerformance pp
    ON cs.ProductID = pp.ProductID
GROUP BY
    pc.CampaignName,
    pp.ProductCategory
ORDER BY
    TotalRevenue DESC;
GO