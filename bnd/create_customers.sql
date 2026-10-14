-- DDL: Create customers dimension table
-- Source: CRM landing zone
-- test line

CREATE TABLE IF NOT EXISTS bnd.dim_customers (
  customer_id        BIGINT       NOT NULL,
  customer_name      STRING        NOT NULL,
  email              STRING,
  phone              STRING,
  signup_date        DATE         NOT NULL,
  region             STRING,
  is_active          BOOLEAN       DEFAULT TRUE,
  created_at         TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
  updated_at         TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (customer_id)
)
USING DELTA
COMMENT 'Customer dimension table sourced from CRM landing zone';
