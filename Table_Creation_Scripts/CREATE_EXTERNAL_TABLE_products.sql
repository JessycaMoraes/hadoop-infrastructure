CREATE EXTERNAL TABLE products (
    id BIGINT,
    cost DOUBLE,
    category STRING,
    name STRING,
    brand STRING,
    retail_price DOUBLE,
    department STRING,
    sku STRING,
    distribution_center_id BIGINT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION 'gs://dataset_ecommerce/products'
TBLPROPERTIES ('skip.header.line.count'='1');