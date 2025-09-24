CREATE EXTERNAL TABLE events (
    id BIGINT,
    user_id BIGINT,
    sequence_number INT,
    session_id STRING,
    created_at STRING,
    ip_address STRING,
    city STRING,
    state STRING,
    postal_code STRING,
    browser STRING,
    traffic_source STRING,
    uri STRING,
    event_type STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION 'gs://dataset_ecommerce/events'
TBLPROPERTIES ('skip.header.line.count'='1');