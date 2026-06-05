/*======================================================================
    File   : scripts/schema/create_schema.sql
    Purpose: Create the RetailAnalytics schema (idempotent / re-runnable).
    Author : Parth Patel
    Notes  : SQL Server has no "CREATE SCHEMA IF NOT EXISTS" syntax, so we
             check sys.schemas first and use dynamic SQL because
             CREATE SCHEMA must be the first statement in its batch.
======================================================================*/

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
