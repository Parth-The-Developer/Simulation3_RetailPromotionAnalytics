# Step-by-Step Screenshot Documentation

**Simulation 3 — AdventureWorks Retail Promotion Analytics System**

| Field | Value |
| --- | --- |
| **Course** | SQL Server Database Development (ITE-5223) |
| **Delivery Type** | Group Simulation Project |
| **Instructor** | vbogudskyi |
| **Team Members** | Parth Patel, Kelvin Idoko, Hassana, Sahasri, Josó, Brian, Dhruv, Lien, Sahil, Joshua |

Use this document as your checklist when reviewing proof of execution. Save every screenshot in the `screenshots/` folder under each team member's subfolder.

For simulation overview, script locations, and deployment instructions, see [README.md](README.md).

---

## Task 1 — Create Retail Analytics Schema

**Script:** `scripts/schema/create_schema.sql`  
**Screenshot:** ![Schema creation](/screenshots/Parth/create_schema_execution.png)

---

## Task 2 — Create Analytics Tables

**Scripts:** `scripts/tables/*.sql`

**Screenshots:**

![PromotionCampaign](/screenshots/Kelvin/Task_6_1_promotion_campaign.png)

![ProductPerformance](/screenshots/Kelvin/Task_6_1_product_performance.png)

![CampaignSales](/screenshots/Kelvin/Task_6_1_campaign_sales.png)

![DiscountAudit](/screenshots/Kelvin/Task_6_1_discount_audit.png)

---

## Task 3 — Load Analytics Data

**Script:** `scripts/data_load/load_analytics_data.sql`

**Screenshots:**

![PromotionCampaign load](/screenshots/Hassana/PromotionCampaign.png)

![ProductPerformance load](/screenshots/Hassana/productPerformance.png)

![CampaignSales load](/screenshots/Hassana/CampaignSales.png)

![DiscountAudit load](/screenshots/Hassana/DiscountAudit.png)

---

## Task 4 — Campaign Revenue Stored Procedure

**Script:** `scripts/procedures/usp_GetCampaignRevenue.sql`  
**Screenshot:** ![Campaign revenue procedure](/screenshots/Joso/usp_GetCampaignRevenue.png)

```sql
EXEC RetailAnalytics.usp_GetCampaignRevenue @CampaignCode = N'SPRING25';
```

---

## Task 5 — Top Discounted Products Stored Procedure

**Script:** `scripts/procedures/usp_GetTopDiscountedProducts.sql`  
**Screenshot:** ![Top discounted products procedure](/screenshots/Joso/usp_GetTopDiscountedProducts.png)

```sql
EXEC RetailAnalytics.usp_GetTopDiscountedProducts @MinimumDiscountRate = 0.20;
```

---

## Task 6 — Discount Rate Scalar Function

**Script:** `scripts/functions/ufn_GetDiscountRate.sql`  
**Screenshot:** _Pending — `screenshots/Sahasri/ufn_GetDiscountRate.png`_

```sql
SELECT RetailAnalytics.ufn_GetDiscountRate(100.00, 75.00) AS DiscountRate;
```

---

## Task 7 — Campaign Revenue Scalar Function

**Script:** `scripts/functions/ufn_GetCampaignRevenue.sql`  
**Screenshot:** _Pending — `screenshots/Sahasri/ufn_GetCampaignRevenue.png`_

```sql
SELECT RetailAnalytics.ufn_GetCampaignRevenue(10, 25.00, 0.20) AS Revenue;
```

---

## Task 8 — Category Performance Stored Procedure

**Script:** `scripts/procedures/usp_GetCategoryPerformance.sql`  
**Screenshot:** ![Category performance procedure](/screenshots/Brian/8.4_usp_GetCategoryPerformance.sql_execution.png)

```sql
EXEC RetailAnalytics.usp_GetCategoryPerformance @CategoryName = N'Bikes';
```

---

## Task 9 — Regional Sales Stored Procedure

**Script:** `scripts/procedures/usp_GetRegionalSales.sql`  
**Screenshot:** ![Regional sales procedure](/screenshots/Brian/8.4_usp_GetRegionalSales.sql_execution.png)

```sql
EXEC RetailAnalytics.usp_GetRegionalSales @Region = N'Northwest';
```

---

## Task 10 — Products by Category Table-Valued Function

**Script:** `scripts/functions/ufn_GetProductsByCategory.sql`  
**Screenshot:** ![Products by category](/screenshots/Dhruv/ufn_GetProductsByCategory.png)

```sql
SELECT * FROM RetailAnalytics.ufn_GetProductsByCategory(N'Bikes');
```

---

## Task 11 — Products by Color Table-Valued Function

**Script:** `scripts/functions/ufn_GetProductsByColor.sql`  
**Screenshot:** ![Products by color](/screenshots/Dhruv/ufn_GetProductsByColor.png)

```sql
SELECT * FROM RetailAnalytics.ufn_GetProductsByColor(N'Red');
```

---

## Task 12 — T-SQL Variables and Control-Flow Demo

**Script:** `scripts/reports/variables_demo.sql`

**Screenshots:**

![Variables demo 1](/screenshots/Lien/Step%204_variables_demo1.png)

![Variables demo 2](/screenshots/Lien/Step%204_variables_demo2.png)

---

## Task 13 — Discount Validation Script

**Script:** `scripts/validation/check_discounts.sql`  
**Screenshot:** ![Discount validation](/screenshots/Sahil/simulation-3.png)

---

## Task 14 — Constraint Lifecycle Demonstration

**Script:** `scripts/validation/constraint_lifecycle_demo.sql`  
**Screenshot:** ![Constraint lifecycle demo](/screenshots/Parth/constraint_lifecycle_demo.png)

---

## Task 15 — SQLCMD Master Deployment Script

**Script:** `scripts/deployment/deploy_all.sql`  
**Screenshot:** ![Deploy all](/screenshots/Joshua/deploy_all.png)

---

## Task 16 — End-to-End Sample Execution

**Script:** `scripts/deployment/sample_execution.sql`  
**Screenshot:** ![Sample execution](/screenshots/Joshua/sample_execution.png)

---

## Report 1 — Campaign Revenue Report

**Script:** `scripts/reports/campaign_revenue_report.sql`  
**Screenshot:** ![Campaign revenue report](/screenshots/Joso/campaign_revenue_report.png)

---

## Report 2 — Top Discounted Products Report

**Script:** `scripts/reports/top_discounted_products_report.sql`  
**Screenshot:** _Pending — `screenshots/Sahasri/top_discounted_products_report.png`_

---

## Report 3 — Product Category Performance Report

**Script:** `scripts/reports/category_performance_report.sql`  
**Screenshot:** ![Category performance report](/screenshots/Brian/category_performance_report.png)

---

## Report 4 — Regional Sales Analysis Report

**Script:** `scripts/reports/regional_sales_report.sql`  
**Screenshot:** ![Regional sales report](/screenshots/Dhruv/regional_sales_report.png)

---

## Report 5 — Discount Validation Report

**Script:** `scripts/reports/discount_validation_report.sql`  
**Screenshot:** ![Discount validation report](/screenshots/Parth/discount_validation_report.png)

---

## ER Diagram

**File:** `diagrams/retail_analytics_er_diagram.jpg`

![ER Diagram](/diagrams/retail_analytics_er_diagram.jpg)

---
