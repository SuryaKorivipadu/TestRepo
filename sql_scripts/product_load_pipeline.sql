/******************************************************************************
    DEMO PURPOSE ONLY
    AI-GENERATED SYNTHETIC SQL

    No client data
    No healthcare data
    No production references
    No proprietary naming
******************************************************************************/

-- ============================================================
-- BEFORE STEP:
-- Insert dependency tracking record
-- ============================================================

INSERT INTO demo_control.process_tracker
(
    child_batch_name,
    parent_batch_name,
    parent_batch_id,
    process_status,
    process_type,
    insert_batch_id,
    insert_timestamp
)

SELECT
      'PRODUCT_LOAD_BATCH'
    , p.batch_name
    , p.batch_id
    , 'STARTED'
    , 'DEPENDENCY_TRACK'
    , c.batch_id
    , CURRENT_TIMESTAMP

FROM demo_control.batch_registry p

LEFT JOIN demo_control.process_tracker t
       ON p.batch_id = t.parent_batch_id
      AND t.process_type = 'DEPENDENCY_TRACK'

INNER JOIN demo_control.batch_registry c
        ON c.batch_name = 'PRODUCT_LOAD_BATCH'

WHERE p.batch_name = 'REFERENCE_DATA_LOAD'
  AND p.batch_status = 'COMPLETED'
  AND t.parent_batch_id IS NULL;

-- ============================================================
-- STAGING LOAD
-- ============================================================

INSERT INTO demo_staging.product_snapshot
(
    product_id,
    product_name,
    product_category,
    load_date,
    source_system
)

SELECT
      product_id
    , product_name
    , category
    , CURRENT_DATE
    , 'DEMO_SOURCE'

FROM demo_raw.product_master;

-- ============================================================
-- DATA QUALITY CHECK
-- ============================================================

SELECT
      COUNT(*) AS total_records
    , COUNT(DISTINCT product_id) AS unique_products
    , SUM(
        CASE
            WHEN product_name IS NULL THEN 1
            ELSE 0
        END
      ) AS null_product_names

FROM demo_staging.product_snapshot;

-- ============================================================
-- DIMENSION LOAD
-- ============================================================

MERGE INTO demo_warehouse.dim_product tgt

USING
(
    SELECT
          product_id
        , product_name
        , product_category
    FROM demo_staging.product_snapshot
) src

ON tgt.product_id = src.product_id

WHEN MATCHED THEN
UPDATE SET
      tgt.product_name = src.product_name
    , tgt.product_category = src.product_category
    , tgt.last_updated_ts = CURRENT_TIMESTAMP

WHEN NOT MATCHED THEN
INSERT
(
      product_id
    , product_name
    , product_category
    , created_ts
)
VALUES
(
      src.product_id
    , src.product_name
    , src.product_category
    , CURRENT_TIMESTAMP
);

-- ============================================================
-- PROCESS COMPLETION UPDATE
-- ============================================================

UPDATE demo_control.batch_registry

SET
      batch_status = 'COMPLETED'
    , completion_ts = CURRENT_TIMESTAMP

WHERE batch_name = 'PRODUCT_LOAD_BATCH';