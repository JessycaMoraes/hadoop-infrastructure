CREATE EXTERNAL TABLE inventory_items (
    id BIGINT,
    product_id BIGINT,
    created_at STRING,
    sold_at STRING,
    cost DOUBLE,
    product_category STRING,
    product_name STRING,
    product_brand STRING,
    product_retail_price DOUBLE,
    product_department STRING,
    product_sku STRING,
    product_distribution_center_id BIGINT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION 'gs://dataset_ecommerce/inventory_items'
TBLPROPERTIES ('skip.header.line.count'='1');