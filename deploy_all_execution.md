# deploy_all.sql — Execution Documentation

**Simulation 3 — AdventureWorks Retail Promotion Analytics System**

| Field | Value |
| --- | --- |
| **Script** | `scripts/deployment/deploy_all.sql` |
| **Owner** | Parth (Task 15) |
| **Verified by** | Joshua (Task 16) |
| **Course** | SQL Server Database Development (ITE-5223) |

This document records how to execute the master deployment script and provides proof-of-execution screenshots. For full project documentation, see [README.md](README.md) and [document.md](document.md).

---

## Prerequisites

Before running `deploy_all.sql`, confirm the following:

| Requirement | Details |
| --- | --- |
| SQL Server | Developer Edition (local instance) |
| Client tool | SSMS or Azure Data Studio |
| Source database | `AdventureWorks2022` attached on the same instance |
| SQLCMD Mode | Must be enabled in SSMS / Azure Data Studio |
| `ScriptsRoot` | Set to your local `scripts` folder path (see below) |

---

## Configure ScriptsRoot

Open `scripts/deployment/deploy_all.sql` and set line 19 to your local clone path:

```sql
:setvar ScriptsRoot "C:\Users\parth\Desktop\sem-2\SQL_SERVER_DEVELOPMENT\Simulation_3\scripts"
```

Replace the path if your repository is cloned elsewhere. When using `deploy.ps1`, this value is overridden automatically.

---

## How to Run

### Option A — SSMS / Azure Data Studio

1. Open `scripts/deployment/deploy_all.sql`
2. Update `ScriptsRoot` if needed
3. Enable **Query → SQLCMD Mode**
4. Execute the full script
5. Confirm messages show `== Deploy started ==` and `== Deploy finished ==`

### Option B — PowerShell

From the repository root:

```powershell
.\scripts\deployment\deploy.ps1
```

This sets `ScriptsRoot` automatically and runs `sqlcmd`.

---

## Deployment Order

`deploy_all.sql` runs all components in dependency order using SQLCMD `:r` includes:

| Step | Component | Scripts |
| --- | --- | --- |
| 1 | Schema | `create_schema.sql` |
| 2 | Tables | `promotion_campaign`, `product_performance`, `campaign_sales`, `discount_audit` |
| 3 | Data load | `load_analytics_data.sql` |
| 4 | Functions | `ufn_GetDiscountRate`, `ufn_GetCampaignRevenue`, `ufn_GetProductsByCategory`, `ufn_GetProductsByColor` |
| 5 | Procedures | `usp_GetCampaignRevenue`, `usp_GetTopDiscountedProducts`, `usp_GetCategoryPerformance`, `usp_GetRegionalSales` |
| 6 | Reports | All 6 report scripts |
| 7 | Validation | `check_discounts.sql`, `constraint_lifecycle_demo.sql` |

---

## Expected Results

After a successful run you should see:

- Database **`RetailPromotionAnalytics`** created (or already exists)
- Schema **`RetailAnalytics`** created
- All four tables populated with data
- All functions, procedures, and reports executed without fatal errors
- Final message: **`== Deploy finished ==`**

Typical row counts after data load:

| Table | Approximate Rows |
| --- | --- |
| PromotionCampaign | 5 |
| ProductPerformance | 285 |
| CampaignSales | 120,950 |
| DiscountAudit | 120,950 |

---

## Proof of Execution

**Screenshot:** Joshua — full `deploy_all.sql` run

![deploy_all.sql execution](/screenshots/Joshua/deploy_all.png)

**Follow-up smoke test:** Run `scripts/deployment/sample_execution.sql` after deployment.

![sample_execution.sql](/screenshots/Joshua/sample_execution.png)

---

## Troubleshooting

| Error | Cause | Fix |
| --- | --- | --- |
| `Incorrect syntax near ':'` | SQLCMD Mode is off | Enable **Query → SQLCMD Mode** |
| `Cannot find directory in the path specified for ":r"` | Wrong `ScriptsRoot` path | Update line 19 to your local `scripts` folder |
| `Invalid object name 'RetailAnalytics.*'` | Tables not created yet | Run Kelvin table scripts before data load, or re-run full `deploy_all.sql` |
| `AdventureWorks2022` not found | Source DB missing | Attach AdventureWorks2022 on the same SQL Server instance |

---
