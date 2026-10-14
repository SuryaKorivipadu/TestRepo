# Pipeline Summary

## Overview

Quick reference for the dummy pipeline files created in TestRepo.

### DAG Table

| DAG Name | Status |
| --- | --- |
| CUSTOMER_LANDING_LOAD | ✅ Complete |
| CUSTOMER_TRANSFORM | ✅ Complete |
| CUSTOMER_DQ_CHECK | ⏳ Pending |
| CUSTOMER_FINAL_LOAD | ⏳ Pending |
| CUSTOMER_ARCHIVE | ⏳ Pending |

All DAGs run in sequence — each task depends on the previous one completing successfully.

### YAML Config Files

| YAML File Name | Status |
| --- | --- |
| customer_master_migration.yaml | ✅ Active |

One config file currently defines the full customer master load pipeline.

### SQL Table

| SQL File Name | Target Table | Load Type | Status |
| --- | --- | --- | --- |
| product_load_pipeline.sql | demo_warehouse.dim_product | UPSERT | ✅ Ready |
| product_load_pipeline.sql | demo_staging.product_snapshot | FULL | ✅ Ready |

These SQL scripts are synthetic and for demo purposes only.