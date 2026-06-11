/********************************************************************************
    Report : Report #5 - Discount Validation Report
    Owner  : Parth (Step 5)
    Purpose: Summarize discount validation results across analytics tables.
    Database: RetailPromotionAnalytics | Schema: RetailAnalytics
    Source  : Kelvin tables + Hassana data load + DiscountAudit
********************************************************************************/

USE RetailPromotionAnalytics;
GO

SET NOCOUNT ON;

PRINT 'Report #5 - Discount Validation Report';
GO

-- Section 1: Campaign-level discount validation summary
SELECT
    pc.CampaignCode                                         AS [Campaign Code],
    pc.CampaignName                                         AS [Campaign Name],
    pc.DiscountRate                                         AS [Campaign Discount Rate],
    CASE
        WHEN pc.DiscountRate BETWEEN 0 AND 0.50 THEN N'VALID'
        ELSE N'INVALID'
    END                                                     AS [Campaign Status],
    COUNT(da.AuditID)                                       AS [Audit Records],
    SUM(CASE WHEN da.ValidationStatus = N'VALID' THEN 1 ELSE 0 END)   AS [Valid Audits],
    SUM(CASE WHEN da.ValidationStatus = N'INVALID' THEN 1 ELSE 0 END) AS [Invalid Audits]
FROM
    RetailAnalytics.PromotionCampaign pc
    LEFT JOIN RetailAnalytics.DiscountAudit da
        ON pc.CampaignID = da.CampaignID
GROUP BY
    pc.CampaignCode,
    pc.CampaignName,
    pc.DiscountRate
ORDER BY
    [Invalid Audits] DESC,
    pc.CampaignCode;
GO

-- Section 2: Invalid discount audit details (if any)
SELECT
    pc.CampaignCode         AS [Campaign Code],
    pp.ProductName          AS [Product Name],
    da.DiscountRate         AS [Discount Rate],
    da.ValidationStatus     AS [Validation Status],
    da.ValidationMessage    AS [Validation Message],
    da.AuditDate            AS [Audit Date]
FROM
    RetailAnalytics.DiscountAudit da
    INNER JOIN RetailAnalytics.PromotionCampaign pc
        ON da.CampaignID = pc.CampaignID
    INNER JOIN RetailAnalytics.ProductPerformance pp
        ON da.ProductID = pp.ProductID
WHERE
    da.ValidationStatus = N'INVALID'
ORDER BY
    da.AuditDate DESC,
    pc.CampaignCode;
GO

-- Section 3: Overall validation totals
SELECT
    N'PromotionCampaign' AS [Source Table],
    COUNT(*) AS [Total Records],
    SUM(CASE WHEN pc.DiscountRate BETWEEN 0 AND 0.50 THEN 1 ELSE 0 END) AS [Valid Records],
    SUM(CASE WHEN pc.DiscountRate < 0 OR pc.DiscountRate > 0.50 THEN 1 ELSE 0 END) AS [Invalid Records]
FROM RetailAnalytics.PromotionCampaign pc

UNION ALL

SELECT
    N'CampaignSales',
    COUNT(*),
    SUM(CASE WHEN cs.DiscountRate BETWEEN 0 AND 0.50 THEN 1 ELSE 0 END),
    SUM(CASE WHEN cs.DiscountRate < 0 OR cs.DiscountRate > 0.50 THEN 1 ELSE 0 END)
FROM RetailAnalytics.CampaignSales cs

UNION ALL

SELECT
    N'DiscountAudit',
    COUNT(*),
    SUM(CASE WHEN da.ValidationStatus = N'VALID' THEN 1 ELSE 0 END),
    SUM(CASE WHEN da.ValidationStatus = N'INVALID' THEN 1 ELSE 0 END)
FROM RetailAnalytics.DiscountAudit da;
GO

PRINT 'Report #5 (Discount Validation) executed successfully.';
GO
