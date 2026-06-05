 
 
-- 1) Project database
 
IF DB_ID(N'RetailPromotionAnalytics') IS NULL
BEGIN
    CREATE DATABASE RetailPromotionAnalytics;
    PRINT 'Database [RetailPromotionAnalytics] created.';
END
ELSE
BEGIN
    PRINT 'Database [RetailPromotionAnalytics] already exists - skipped.';
END
GO

USE RetailPromotionAnalytics;
GO
 
-- 2) RetailAnalytics schema
 
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = N'RetailAnalytics')
BEGIN
    EXEC ('CREATE SCHEMA RetailAnalytics AUTHORIZATION dbo;');
    PRINT 'Schema [RetailAnalytics] created.';
END
ELSE
BEGIN
    PRINT 'Schema [RetailAnalytics] already exists - skipped.';
END
GO

PRINT 'Foundation ready: database RetailPromotionAnalytics + schema RetailAnalytics. You can start your work.';
GO
