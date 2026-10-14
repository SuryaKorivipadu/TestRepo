-- DDL: Create orders fact table
-- Source: Order management system landing zone

CREATE TABLE IF NOT EXISTS cos.fact_orders (
  order_id           BIGINT        NOT NULL,
  customer_id        BIGINT        NOT NULL,
  product_id         BIGINT        NOT NULL,
  order_date         DATE         NOT NULL,
  quantity           INT           NOT NULL,
  unit_price         DECIMAL(10,2) NOT NULL,
  total_amount       DECIMAL(12,2) GENERATED ALWAYS AS (quantity * unit_price),
  order_status       STRING        DEFAULT 'PENDING',
  created_at         TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (order_id)
)
USING DELTA
COMMENT 'Orders fact table sourced from OMS landing zone';
