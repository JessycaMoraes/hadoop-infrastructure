CREATE EXTERNAL TABLE users (
    id BIGINT,
    first_name STRING,
    last_name STRING,
    email STRING,
    age INT,
    gender STRING,
    state STRING,
    street_address STRING,
    postal_code STRING,
    city STRING,
    country STRING,
    latitude DOUBLE,
    longitude DOUBLE,
    traffic_source STRING,
    created_at STRING,
    user_geom STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION 'gs://dataset_ecommerce/users'
TBLPROPERTIES ('skip.header.line.count'='1');