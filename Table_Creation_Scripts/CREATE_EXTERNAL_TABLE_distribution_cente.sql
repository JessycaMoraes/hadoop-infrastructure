CREATE EXTERNAL TABLE distribution_centers (
    id BIGINT,
    name STRING,
    latitude DOUBLE,
    longitude DOUBLE,
    distribution_center_geom STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION 'gs://dataset_ecommerce/distribution_centers'
TBLPROPERTIES ('skip.header.line.count'='1');