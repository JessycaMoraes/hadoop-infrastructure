# 📊 Sales Performance Analysis Report – theLook eCommerce   

### 📌 About the Project
Project developed for the **Hadoop** course of the Postgraduate program in **Data Engineering: Big Data** (Faculdade Infnet). 

It implements a full **extraction, modeling, and analysis workflow** using the public dataset **theLook eCommerce**.

The infrastructure was deployed on a **Hadoop cluster created in Dataproc (Google Cloud Platform)**. All Hive queries were executed through the cluster VM.

---

### 🎯 Objectives  
- Build a Hive database from data extracted from BigQuery.
- Create external tables in Hive reflecting the dataset schema.
- Write SQL queries to answer business questions on e-commerce sales.
- Suggest optimizations and future improvements.

---

### 🛠 Tech Stack
- **Google BigQuery** (public dataset theLook eCommerce)  
- **Google Cloud Storage** (CSV storage) 
- **Hadoop / Hive** on **Dataproc (GCP)**
- **SQL**  

---

### 📂 Project Structure
```bash
README.md
Bigquery_Storage_Extraction.txt        # BigQuery → GCP extraction scripts
Table_Creation_Scripts/
  CREATE_EXTERNAL_TABLE_users.sql
  CREATE_EXTERNAL_TABLE_products.sql
  CREATE_EXTERNAL_TABLE_orders.sql
  CREATE_EXTERNAL_TABLE_order_items.sql
  CREATE_EXTERNAL_TABLE_inventory_items.sql
  CREATE_EXTERNAL_TABLE_events.sql
  CREATE_EXTERNAL_TABLE_distribution_centers.sql
SQL_Query_Scripts/
  01_monthly_sales_trend.sql
  02_top_products.sql
  03_order_status_distribution.sql
  04_avg_order_value_per_customer.sql
  05_revenue_by_state.sql
```

---

### 🚀 How to Reproduce
1. Export BigQuery tables to GCS
File: ```Bigquery_Storage_Extraction.txt```
```bash
bq extract --destination_format CSV \
bigquery-public-data:thelook_ecommerce.products \
gs://<YOUR_BUCKET>/products/products.csv
```

2. Create a Dataproc Cluster
In Google Cloud Console, create a Dataproc cluster (with Hive and Hadoop).
Access the master VM via SSH and run Hive commands.

3. Create Hive database
```sql
CREATE DATABASE IF NOT EXISTS thelook_ecommerce_db;
USE thelook_ecommerce_db;
```

4. Create Hive external tables
Example: ```CREATE_EXTERNAL_TABLE_users.sql```
```sql
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
LOCATION 'gs://<YOUR_BUCKET>/users'
TBLPROPERTIES ('skip.header.line.count'='1');
```

5. Run analytical queries
Example: ```01_monthly_sales_trend.sql```
```sql
SELECT
   date_format(o.created_at, 'yyyy-MM') AS period_month,
   COUNT(o.order_id) AS total_orders,
   SUM(oi.sale_price) AS total_revenue
FROM
   orders o
JOIN
   order_items oi ON o.order_id = oi.order_id
GROUP BY
   date_format(o.created_at, 'yyyy-MM')
ORDER BY
   period_month;
```

### 📊 Implemented Queries
- Sales and revenue trends (monthly)
- Best-selling products and categories
- Order status distribution
- Average order value per customer
- Revenue by geographic region

### 🔎 Key Findings
- Consistent growth in orders and revenue (2019–2025).
- Best sellers: strong dominance of Jeans and Shorts.
- Order status: high Shipped/Complete, but relevant Returned and Cancelled.
- Geographic insights: revenue concentrated in regions like Guangdong, California, São Paulo.

### 🛠 Next Steps
- Convert CSVs to Parquet/ORC.
- Implement table partitioning (e.g., by date).
- Connect Hive to Looker Studio dashboards.

### 📚 References
- Google Cloud — [theLook eCommerce (BigQuery public dataset)](https://console.cloud.google.com/marketplace/product/bigquery-public-data/thelook-ecommerce)
- Looker Team — [Looker Ecommerce Dataset (Kaggle)](https://www.kaggle.com/datasets/mustafakeser4/looker-ecommerce-bigquery-dataset)
- MDIC (2024) — [E-commerce no Brasil cresce 4% e alcança R$196 bi](https://www.gov.br/mdic/pt-br/assuntos/noticias/2024/setembro/e-commerce-no-brasil-cresce-4-e-alcanca-r-196-bi-em-2023)