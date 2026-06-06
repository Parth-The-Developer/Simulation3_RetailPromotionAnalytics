USE RetailPromotionAnalytics;
GO

-- TABLE: CampaignSales

IF OBJECT_ID('RetailAnalytics.CampaignSales','U') IS NULL
BEGIN
    CREATE TABLE RetailAnalytics.CampaignSales
    (
        CampaignSalesID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,

        CampaignID INT NOT NULL,
        ProductID INT NOT NULL,

        SalesOrderID INT NOT NULL,
        OrderDate DATETIME NOT NULL,
        Region NVARCHAR(50) NOT NULL,

        QuantitySold INT NOT NULL,
        UnitPrice MONEY NOT NULL,
        DiscountRate DECIMAL(4,3) NOT NULL,

        Revenue MONEY NOT NULL,

        CreatedAt DATETIME2 NOT NULL
            CONSTRAINT DF_RetailAnalytics_CampaignSales_CreatedAt DEFAULT(SYSDATETIME()),

        CONSTRAINT FK_RetailAnalytics_CampaignSales_Campaign
            FOREIGN KEY (CampaignID)
            REFERENCES RetailAnalytics.PromotionCampaign(CampaignID),

        CONSTRAINT FK_RetailAnalytics_CampaignSales_Product
            FOREIGN KEY (ProductID)
            REFERENCES RetailAnalytics.ProductPerformance(ProductID),

        CONSTRAINT CK_RetailAnalytics_CampaignSales_Qty CHECK (QuantitySold > 0),

        CONSTRAINT CK_RetailAnalytics_CampaignSales_Discount CHECK (DiscountRate BETWEEN 0 AND 0.50),

        CONSTRAINT CK_RetailAnalytics_CampaignSales_Revenue CHECK (Revenue >= 0)
    );
END
GO