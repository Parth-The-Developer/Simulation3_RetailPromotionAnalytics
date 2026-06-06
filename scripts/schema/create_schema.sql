-- 1) Project database
IF DB_ID(N'RetailPromotionAnalytics') IS NULL
    CREATE DATABASE RetailPromotionAnalytics;
GO

USE RetailPromotionAnalytics;
GO
PRINT 'Database [RetailPromotionAnalytics] created.';
GO

-- 2) RetailAnalytics schema
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = N'RetailAnalytics')
    EXEC ('CREATE SCHEMA RetailAnalytics AUTHORIZATION dbo;');
GO
PRINT 'Schema [RetailAnalytics] created.';
GO

PRINT 'Foundation ready: database RetailPromotionAnalytics + schema RetailAnalytics. You can start your work.';
GO
