# Step-by-Step Screenshot Documentation

**Simulation 3 — AdventureWorks Retail Promotion Analytics System**

| Field | Value |
| --- | --- |
| **Course** | SQL Server Database Development (ITE-5223) |
| **Delivery Type** | Group Simulation Project |
| **Instructor** | vbogudskyi |
| **Team Members** | Parth Patel, Kelvin Idoko, Hassana, Sahasri, Josó, Brian, Dhruv, Lien, Sahil, Joshua |

Use this document as your checklist when capturing and reviewing proof of execution. Save every screenshot in the `screenshots/` folder under each team member's subfolder.

For lab overview, script locations, deployment instructions, and task status, see [README.md](README.md).

---

## Task 1 — Create Retail Analytics Schema

**Owner:** Parth  
**Script:** `scripts/schema/create_schema.sql`  
**Screenshot:**

![Schema creation](/screenshots/Parth/create_schema_execution.png)

---

## Task 2 — Create Analytics Tables

**Owner:** Kelvin  
**Scripts:** `scripts/tables/*.sql`

| Table | Script | Screenshot |
| --- | --- | --- |
| PromotionCampaign | `promotion_campaign.sql` | ![PromotionCampaign](/screenshots/Kelvin/Task_6_1_promotion_campaign.png) |
| ProductPerformance | `product_performance.sql` | ![ProductPerformance](/screenshots/Kelvin/Task_6_1_product_performance.png) |
| CampaignSales | `campaign_sales.sql` | ![CampaignSales](/screenshots/Kelvin/Task_6_1_campaign_sales.png) |
| DiscountAudit | `discount_audit.sql` | ![DiscountAudit](/screenshots/Kelvin/Task_6_1_discount_audit.png) |

---

## Task 3 — Load Analytics Data

**Owner:** Hassana  
**Script:** `scripts/data_load/load_analytics_data.sql`

| Table | Screenshot |
| --- | --- |
| PromotionCampaign | ![PromotionCampaign load](/screenshots/Hassana/PromotionCampaign.png) |
| ProductPerformance | ![ProductPerformance load](/screenshots/Hassana/productPerformance.png) |
| CampaignSales | ![CampaignSales load](/screenshots/Hassana/CampaignSales.png) |
| DiscountAudit | ![DiscountAudit load](/screenshots/Hassana/DiscountAudit.png) |

---

## Task 4 — Campaign Revenue Stored Procedure

**Owner:** Josó  
**Script:** `scripts/procedures/usp_GetCampaignRevenue.sql`  
**Object:** `RetailAnalytics.usp_GetCampaignRevenue`

**Screenshot:**

![Campaign revenue procedure](/screenshots/Joso/usp_GetCampaignRevenue.png)

**Sample execution:**

```sql
EXEC RetailAnalytics.usp_GetCampaignRevenue @CampaignCode = N'SPRING25';
```

---

## Task 5 — Top Discounted Products Stored Procedure

**Owner:** Josó  
**Script:** `scripts/procedures/usp_GetTopDiscountedProducts.sql`  
**Object:** `RetailAnalytics.usp_GetTopDiscountedProducts`

**Screenshot:**

![Top discounted products procedure](/screenshots/Joso/usp_GetTopDiscountedProducts.png)

**Sample execution:**

```sql
EXEC RetailAnalytics.usp_GetTopDiscountedProducts @MinimumDiscountRate = 0.20;
```

---

## Task 6 — Discount Rate Scalar Function

**Owner:** Sahasri  
**Script:** `scripts/functions/ufn_GetDiscountRate.sql`  
**Object:** `RetailAnalytics.ufn_GetDiscountRate`

**Screenshot:** _Pending — add to `screenshots/Sahasri/ufn_GetDiscountRate.png`_

**Sample execution:**

```sql
SELECT RetailAnalytics.ufn_GetDiscountRate(100.00, 75.00) AS DiscountRate;
```

---

## Task 7 — Campaign Revenue Scalar Function

**Owner:** Sahasri  
**Script:** `scripts/functions/ufn_GetCampaignRevenue.sql`  
**Object:** `RetailAnalytics.ufn_GetCampaignRevenue`

**Screenshot:** _Pending — add to `screenshots/Sahasri/ufn_GetCampaignRevenue.png`_

**Sample execution:**

```sql
SELECT RetailAnalytics.ufn_GetCampaignRevenue(10, 25.00, 0.20) AS Revenue;
```

---

## Task 8 — Category Performance Stored Procedure

**Owner:** Brian  
**Script:** `scripts/procedures/usp_GetCategoryPerformance.sql`  
**Object:** `RetailAnalytics.usp_GetCategoryPerformance`

**Screenshot:**

![Category performance procedure](/screenshots/Brian/8.4_usp_GetCategoryPerformance.sql_execution.png)

**Sample execution:**

```sql
EXEC RetailAnalytics.usp_GetCategoryPerformance @CategoryName = N'Bikes';
```

---

## Task 9 — Regional Sales Stored Procedure

**Owner:** Brian  
**Script:** `scripts/procedures/usp_GetRegionalSales.sql`  
**Object:** `RetailAnalytics.usp_GetRegionalSales`

**Screenshot:**

![Regional sales procedure](/screenshots/Brian/8.4_usp_GetRegionalSales.sql_execution.png)

**Sample execution:**

```sql
EXEC RetailAnalytics.usp_GetRegionalSales @Region = N'Northwest';
```

---

## Task 10 — Products by Category Table-Valued Function

**Owner:** Dhruv  
**Script:** `scripts/functions/ufn_GetProductsByCategory.sql`  
**Object:** `RetailAnalytics.ufn_GetProductsByCategory`

**Screenshot:**

![Products by category function](/screenshots/Dhruv/ufn_GetProductsByCategory.png)

**Sample execution:**

```sql
SELECT * FROM RetailAnalytics.ufn_GetProductsByCategory(N'Bikes');
```

---

## Task 11 — Products by Color Table-Valued Function

**Owner:** Dhruv  
**Script:** `scripts/functions/ufn_GetProductsByColor.sql`  
**Object:** `RetailAnalytics.ufn_GetProductsByColor`

**Screenshot:**

![Products by color function](/screenshots/Dhruv/ufn_GetProductsByColor.png)

**Sample execution:**

```sql
SELECT * FROM RetailAnalytics.ufn_GetProductsByColor(N'Red');
```

---

## Task 12 — T-SQL Variables and Control-Flow Demo

**Owner:** Lien  
**Script:** `scripts/reports/variables_demo.sql`

**Screenshots:**

![Variables demo 1](/screenshots/Lien/Step%204_variables_demo1.png)

![Variables demo 2](/screenshots/Lien/Step%204_variables_demo2.png)

---

## Task 13 — Discount Validation Script

**Owner:** Sahil  
**Script:** `scripts/validation/check_discounts.sql`

**Screenshot:**

![Discount validation](/screenshots/Sahil/simulation-3.png)

---

## Task 14 — Constraint Lifecycle Demonstration

**Owner:** Parth  
**Script:** `scripts/validation/constraint_lifecycle_demo.sql`

**Screenshot:**

![Constraint lifecycle demo](/screenshots/Parth/constraint_lifecycle_demo.png)

---

## Task 15 — SQLCMD Master Deployment Script

**Owner:** Parth  
**Script:** `scripts/deployment/deploy_all.sql`

**Screenshot:**

![Deploy all](/screenshots/Joshua/deploy_all.png)

**Notes:**

- Enable **SQLCMD Mode** before execution.
- Update `ScriptsRoot` in `deploy_all.sql` to your local `scripts` folder path.

---

## Task 16 — End-to-End Sample Execution

**Owner:** Joshua  
**Script:** `scripts/deployment/sample_execution.sql`

**Screenshot:**

![Sample execution](/screenshots/Joshua/sample_execution.png)

**Prerequisite:** Run `deploy_all.sql` first.

---

## Business Reports

### Report #1 — Campaign Revenue Report

**Owner:** Josó  
**Script:** `scripts/reports/campaign_revenue_report.sql`

![Campaign revenue report](/screenshots/Joso/campaign_revenue_report.png)

---

### Report #2 — Top Discounted Products Report

**Owner:** Sahasri  
**Script:** `scripts/reports/top_discounted_products_report.sql`

**Screenshot:** _Pending — add to `screenshots/Sahasri/top_discounted_products_report.png`_

---

### Report #3 — Product Category Performance Report

**Owner:** Brian  
**Script:** `scripts/reports/category_performance_report.sql`

![Category performance report](/screenshots/Brian/category_performance_report.png)

---

### Report #4 — Regional Sales Analysis Report

**Owner:** Dhruv  
**Script:** `scripts/reports/regional_sales_report.sql`

![Regional sales report](/screenshots/Dhruv/regional_sales_report.png)

---

### Report #5 — Discount Validation Report

**Owner:** Parth  
**Script:** `scripts/reports/discount_validation_report.sql`

![Discount validation report](/screenshots/Parth/discount_validation_report.png)

---

## ER Diagram

**Location:** `diagrams/retail_analytics_er_diagram.jpg`

![ER Diagram](/diagrams/retail_analytics_er_diagram.jpg)

---

## Submission Checklist

- [ ] All scripts execute without manual code changes
- [ ] `deploy_all.sql` runs successfully in SQLCMD Mode
- [ ] `sample_execution.sql` completes after deployment
- [ ] All required screenshots are saved in `screenshots/`
- [ ] Sahasri screenshots added (Tasks 6, 7, Report #2)
- [ ] Private GitHub repository link submitted to instructor

---
