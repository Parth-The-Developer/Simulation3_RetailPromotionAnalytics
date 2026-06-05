/*======================================================================
    File   : scripts/schema/create_schema.sql
    Owner  : Parth (Step 1)
    Purpose: Foundation script - everyone runs this FIRST before starting.
             1) Creates the project database  [RetailPromotionAnalytics]
             2) Creates the schema            [RetailAnalytics]
    Notes  : Fully idempotent / re-runnable. SQL Server has no
             "CREATE SCHEMA IF NOT EXISTS", so we check sys.schemas and use
             dynamic SQL (CREATE SCHEMA must be first statement in its batch).

    HOW TO RUN: just execute this file once against your SQL Server instance.
======================================================================*/

----------------------------------------------------------------------
-- 1) Project database
----------------------------------------------------------------------
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

----------------------------------------------------------------------
-- 2) RetailAnalytics schema
----------------------------------------------------------------------
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
