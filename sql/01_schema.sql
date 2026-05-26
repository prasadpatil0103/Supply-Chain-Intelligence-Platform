-- ============================================================
-- Supply Chain Intelligence Platform
-- Star Schema DDL
-- File: sql/01_schema.sql
-- ============================================================

-- ============================================================
-- DIMENSION TABLES (create before fact table)
-- ============================================================

CREATE TABLE IF NOT EXISTS dim_date (
    date_id         INTEGER PRIMARY KEY AUTOINCREMENT,
    full_date       TEXT NOT NULL,
    year            INTEGER NOT NULL,
    month           INTEGER NOT NULL,
    month_name      TEXT NOT NULL,
    quarter         INTEGER NOT NULL,
    day             INTEGER NOT NULL,
    day_of_week     TEXT NOT NULL,
    is_weekend      INTEGER NOT NULL  -- 0 or 1
);

CREATE TABLE IF NOT EXISTS dim_customer (
    customer_id     INTEGER PRIMARY KEY,
    first_name      TEXT,
    last_name       TEXT,
    segment         TEXT,   -- Consumer / Corporate / Home Office
    city            TEXT,
    state           TEXT,
    country         TEXT,
    street          TEXT,
    zipcode         TEXT,
    market          TEXT    -- Europe / LATAM / etc
);

CREATE TABLE IF NOT EXISTS dim_product (
    product_id      INTEGER PRIMARY KEY,
    product_name    TEXT NOT NULL,
    category_id     INTEGER,
    category_name   TEXT,
    department_id   INTEGER,
    department_name TEXT,
    product_price   REAL,
    product_status  INTEGER  -- 0 = active, 1 = inactive
);

CREATE TABLE IF NOT EXISTS dim_location (
    location_id     INTEGER PRIMARY KEY AUTOINCREMENT,
    order_city      TEXT,
    order_state     TEXT,
    order_country   TEXT,
    order_region    TEXT,
    market          TEXT,
    shipping_mode   TEXT,   -- Standard Class / First Class / etc
    latitude        REAL,
    longitude       REAL
);

-- ============================================================
-- FACT TABLE (create after all dimension tables)
-- ============================================================

CREATE TABLE IF NOT EXISTS fact_orders (
    order_item_id           INTEGER PRIMARY KEY,
    order_id                INTEGER NOT NULL,
    date_id                 INTEGER REFERENCES dim_date(date_id),
    customer_id             INTEGER REFERENCES dim_customer(customer_id),
    product_id              INTEGER REFERENCES dim_product(product_id),
    location_id             INTEGER REFERENCES dim_location(location_id),

    -- Measures
    sales_amount            REAL,
    order_item_total        REAL,
    benefit_per_order       REAL,
    order_profit_per_order  REAL,
    sales_per_customer      REAL,
    order_item_discount     REAL,
    order_item_discount_rate REAL,
    order_item_profit_ratio REAL,
    order_item_quantity     INTEGER,
    order_item_product_price REAL,

    -- Delivery metrics
    days_shipping_real      INTEGER,  -- actual days taken
    days_shipping_scheduled INTEGER,  -- planned days
    days_late               INTEGER,  -- computed: real - scheduled
    is_late                 INTEGER,  -- 0 or 1 flag
    late_delivery_risk      INTEGER,  -- from source: 0 or 1
    delivery_status         TEXT,
    order_status            TEXT,
    shipping_date           TEXT,
    order_date              TEXT,
    order_type              TEXT      -- DEBIT / TRANSFER / CASH / etc
);

-- ============================================================
-- VALIDATION QUERIES (run after loading data)
-- ============================================================

-- Check row counts match source
-- SELECT COUNT(*) FROM fact_orders;        -- expect 180519
-- SELECT COUNT(*) FROM dim_customer;
-- SELECT COUNT(*) FROM dim_product;
-- SELECT COUNT(*) FROM dim_location;
-- SELECT COUNT(*) FROM dim_date;

-- Check no orphaned FKs in fact table
-- SELECT COUNT(*) FROM fact_orders WHERE date_id NOT IN (SELECT date_id FROM dim_date);
-- SELECT COUNT(*) FROM fact_orders WHERE customer_id NOT IN (SELECT customer_id FROM dim_customer);
-- SELECT COUNT(*) FROM fact_orders WHERE product_id NOT IN (SELECT product_id FROM dim_product);
-- SELECT COUNT(*) FROM fact_orders WHERE location_id NOT IN (SELECT location_id FROM dim_location);