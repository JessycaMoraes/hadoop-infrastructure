CREATE EXTERNAL TABLE order_items (
    id BIGINT,
    order_id BIGINT,
    user_id BIGINT,
    product_id BIGINT,
    inventory_item_id BIGINT,
    status STRING,
    created_at STRING,
    shipped_at STRING,
    delivered_at STRING,
    returned_at STRING,
    sale_price DOUBLE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION 'gs://dataset_ecommerce/order_items'
TBLPROPERTIES ('skip.header.line.count'='1');