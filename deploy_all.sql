/*======================================================================
    File   : deploy_all.sql
    Purpose: Master deployment script. Runs every component in order.
    Author : Parth Patel

    HOW TO RUN (SQLCMD mode required for :r includes):
      - In SSMS:  Query menu -> "SQLCMD Mode", then execute this file.
      - From CLI: sqlcmd -S <server> -d <database> -E -i deploy_all.sql

    NOTE: The :r includes below are intentionally COMMENTED OUT for the
          initial empty structure. Each owner uncomments their line once
          their script is committed, following the dependency order.
======================================================================*/

:setvar SqlCmdMode "Use Query > SQLCMD Mode in SSMS before running"

PRINT '== Deploy started ==';
GO

-- 1) Schema (Parth)
-- :r .\scripts\schema\create_schema.sql

-- 2) Tables (Kelvin) - 4 tables with all constraints
-- :r .\scripts\tables\01_create_tables.sql

-- 3) Data load (Hassana) - INSERT ... SELECT from AdventureWorks2022
-- :r .\scripts\data_load\01_load_data.sql

-- 4) Functions (Sahasri) - 4 functions
-- :r .\scripts\functions\01_create_functions.sql

-- 5) Stored procedures (Joso) - 4 procedures
-- :r .\scripts\procedures\01_create_procedures.sql

-- 6) Reports (Brian, Dhruv, Li, Sahil, Parth)
-- :r .\scripts\reports\01_reports.sql

-- 7) Validation (team)
-- :r .\scripts\validation\01_validation.sql

PRINT '== Deploy finished ==';
GO
