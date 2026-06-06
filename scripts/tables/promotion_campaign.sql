USE RetailPromotionAnalytics;
GO

-- TABLE: PromotionCampaign

IF OBJECT_ID('RetailAnalytics.PromotionCampaign','U') IS NULL
BEGIN
    CREATE TABLE RetailAnalytics.PromotionCampaign
    (
        CampaignID INT IDENTITY(1,1) NOT NULL,
        CampaignCode NVARCHAR(20) NOT NULL,
        CampaignName NVARCHAR(100) NOT NULL,
        CampaignType NVARCHAR(50) NOT NULL,
        StartDate DATE NOT NULL,
        EndDate DATE NOT NULL,
        DiscountRate DECIMAL(4,3) NOT NULL,

        IsActive BIT NOT NULL
            CONSTRAINT DF_RetailAnalytics_PromotionCampaign_IsActive DEFAULT(1),

        CreatedAt DATETIME2 NOT NULL
            CONSTRAINT DF_RetailAnalytics_PromotionCampaign_CreatedAt DEFAULT(SYSDATETIME()),

        CONSTRAINT PK_RetailAnalytics_PromotionCampaign PRIMARY KEY (CampaignID),

        CONSTRAINT UQ_RetailAnalytics_PromotionCampaign_CampaignCode UNIQUE (CampaignCode),

        CONSTRAINT CK_RetailAnalytics_PromotionCampaign_DiscountRate CHECK (DiscountRate BETWEEN 0 AND 0.50),

        CONSTRAINT CK_RetailAnalytics_PromotionCampaign_Dates CHECK (EndDate > StartDate),

        CONSTRAINT CK_RetailAnalytics_PromotionCampaign_Name CHECK (CampaignName <> '' AND CampaignCode <> '')
    );
END
GO