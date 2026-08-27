set global local_infile = 1;

-- 1. CUSTOMERS TABLE
CREATE TABLE IF NOT EXISTS customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix VARCHAR(10),
    customer_city VARCHAR(100),
    customer_state VARCHAR(10)
);

LOAD DATA LOCAL INFILE "C:\\Users\\Hp\\Documents\\Coding Ninjas DAJB\\Personal projects\\Brazilian supply chain\\olist_customers_dataset.csv"
INTO TABLE customers
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- 2. SELLERS TABLE
CREATE TABLE IF NOT EXISTS sellers (
    seller_id VARCHAR(50) PRIMARY KEY,
    seller_zip_code_prefix VARCHAR(10),
    seller_city VARCHAR(100),
    seller_state VARCHAR(10)
);

LOAD DATA LOCAL INFILE "C:\\Users\\Hp\\Documents\\Coding Ninjas DAJB\\Personal projects\\Brazilian supply chain\\olist_sellers_dataset.csv"
INTO TABLE sellers
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- 3. PRODUCTS TABLE
CREATE TABLE IF NOT EXISTS products (
    product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(100),
    product_name_length INT,
    product_description_length INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
);

LOAD DATA LOCAL INFILE "C:/Users/Hp/Documents/Coding Ninjas DAJB/Personal projects/Brazilian supply chain/olist_products_dataset.csv"
INTO TABLE products
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(product_id, product_category_name, @vname_len, @vdesc_len, @vphotos, @vweight, @vlen, @vheight, @vwidth)
SET 
    product_name_length = NULLIF(@vname_len, ''),
    product_description_length = NULLIF(@vdesc_len, ''),
    product_photos_qty = NULLIF(@vphotos, ''),
    product_weight_g = NULLIF(@vweight, ''),
    product_length_cm = NULLIF(@vlen, ''),
    product_height_cm = NULLIF(@vheight, ''),
    product_width_cm = NULLIF(@vwidth, '');
    
-- 4. ORDERS TABLE
CREATE TABLE IF NOT EXISTS orders (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50),
    order_status VARCHAR(20),
    order_purchase_timestamp DATETIME,
    order_approved_at DATETIME,
    order_delivered_carrier_date DATETIME,
    order_delivered_customer_date DATETIME,
    order_estimated_delivery_date DATETIME
);

LOAD DATA LOCAL INFILE "C:\\Users\\Hp\\Documents\\Coding Ninjas DAJB\\Personal projects\\Brazilian supply chain\\olist_orders_dataset.csv"
INTO TABLE orders
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(order_id, customer_id, order_status, @vpurch, @vapp, @vcarr, @vcust, @vest)
SET 
    order_purchase_timestamp = NULLIF(@vpurch, ''),
    order_approved_at = NULLIF(@vapp, ''),
    order_delivered_carrier_date = NULLIF(@vcarr, ''),
    order_delivered_customer_date = NULLIF(@vcust, ''),
    order_estimated_delivery_date = NULLIF(@vest, '');
    
-- 5. ORDER ITEMS TABLE
CREATE TABLE IF NOT EXISTS order_items (
    order_id VARCHAR(50),
    order_item_id INT,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date DATETIME,
    price DECIMAL(10,2),
    freight_value DECIMAL(10,2),
    PRIMARY KEY (order_id, order_item_id)
);

LOAD DATA LOCAL INFILE "C:\\Users\\Hp\\Documents\\Coding Ninjas DAJB\\Personal projects\\Brazilian supply chain\\olist_order_items_dataset.csv"
INTO TABLE order_items
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(order_id, order_item_id, product_id, seller_id, @vship_date, price, freight_value)
SET 
    shipping_limit_date = NULLIF(@vship_date, '');
    
-- verifying number of rows imported

select "customers" as table_name, count(*) as row_count
from customers
union all
select 'sellers', count(*)
from sellers
union all
select 'products', count(*)
from products
union all
select 'orders', count(*) 
from orders
union all
select 'order_items', count(*)
from order_items;

select * from orders
limit 10;