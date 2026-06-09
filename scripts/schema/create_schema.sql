/********************************************************************************
    File   : scripts/schema/create_schema.sql
    Owner  : Parth (Step 1)
    Purpose: Create project database + RetailAnalytics schema (idempotent).

    Database architecture:
      - RetailPromotionAnalytics  → project database (tables, functions, reports)
      - RetailAnalytics           → schema inside it (required by spec)
      - AdventureWorks2022        → source only (Hassana reads from it; not modified here)
********************************************************************************/

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

-- 2) RetailAnalytics schema (spec requirement)
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

PRINT 'Foundation ready: RetailPromotionAnalytics + RetailAnalytics schema. Team can start.';
GO
