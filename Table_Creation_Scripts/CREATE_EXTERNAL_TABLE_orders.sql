CREATE EXTERNAL TABLE orders (
    order_id BIGINT,
    user_id BIGINT,
    status STRING,
    gender STRING,
    created_at STRING,
    returned_at STRING,
    shipped_at STRING,
    delivered_at STRING,
    num_of_item INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION 'gs://dataset_ecommerce/orders'
TBLPROPERTIES ('skip.header.line.count'='1');