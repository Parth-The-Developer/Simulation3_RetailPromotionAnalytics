USE RetailPromotionAnalytics;
GO

-- TABLE: ProductPerformance

IF OBJECT_ID('RetailAnalytics.ProductPerformance','U') IS NULL
BEGIN
    CREATE TABLE RetailAnalytics.ProductPerformance
    (
        ProductID INT NOT NULL PRIMARY KEY,
        ProductName NVARCHAR(100) NOT NULL,
        ProductNumber NVARCHAR(25) NOT NULL,
        ProductCategory NVARCHAR(100) NOT NULL,
        Color NVARCHAR(15) NULL,
        StandardCost MONEY NOT NULL,
        ListPrice MONEY NOT NULL,
        SafetyStockLevel SMALLINT NOT NULL,
        ReorderPoint SMALLINT NOT NULL,

        CreatedAt DATETIME2 NOT NULL
            CONSTRAINT DF_RetailAnalytics_ProductPerformance_CreatedAt DEFAULT(SYSDATETIME()),

        CONSTRAINT CK_RetailAnalytics_ProductPerformance_ListPrice CHECK (ListPrice > 0),
        CONSTRAINT CK_RetailAnalytics_ProductPerformance_StandardCost CHECK (StandardCost > 0)
    );
END
GO