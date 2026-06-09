/********************************************************************************
    File   : scripts/tables/discount_audit.sql
    Owner  : Kelvin (Step 2)
    Database: RetailPromotionAnalytics | Schema: RetailAnalytics
********************************************************************************/

USE RetailPromotionAnalytics;
GO

-- TABLE: DiscountAudit

IF OBJECT_ID('RetailAnalytics.DiscountAudit','U') IS NULL
BEGIN
    CREATE TABLE RetailAnalytics.DiscountAudit
    (
        AuditID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,

        CampaignID INT NOT NULL,
        ProductID INT NOT NULL,

        DiscountRate DECIMAL(4,3) NOT NULL,
        ValidationStatus NVARCHAR(20) NOT NULL,
        ValidationMessage NVARCHAR(200) NOT NULL,

        AuditDate DATETIME2 NOT NULL
            CONSTRAINT DF_RetailAnalytics_DiscountAudit_AuditDate DEFAULT(SYSDATETIME()),

        CONSTRAINT FK_RetailAnalytics_DiscountAudit_Campaign
            FOREIGN KEY (CampaignID)
            REFERENCES RetailAnalytics.PromotionCampaign(CampaignID),

        CONSTRAINT FK_RetailAnalytics_DiscountAudit_Product
            FOREIGN KEY (ProductID)
            REFERENCES RetailAnalytics.ProductPerformance(ProductID)
    );
END
GO