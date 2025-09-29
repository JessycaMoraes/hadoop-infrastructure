# 📊 Relatório de Análise de Desempenho de Vendas em E-Commerce  

### 📌 Sobre o Projeto  
Este projeto foi desenvolvido como parte da disciplina **Hadoop** da Pós-graduação em **Engenharia de Dados: Big Data** (Faculdade Infnet).  

O objetivo foi implementar um fluxo completo de **extração, modelagem e análise de dados em e-commerce** utilizando o dataset público **theLook eCommerce**.  

A infraestrutura foi executada em um **cluster Hadoop criado no Dataproc (Google Cloud Platform)**.  
Todas as consultas Hive foram rodadas através da **VM do cluster**.  

---

### 🎯 Objetivos  
- Construir um ambiente de banco de dados em **Hive** a partir de dados extraídos do **BigQuery**.  
- Criar tabelas externas no Hive para representar o esquema do dataset.  
- Executar consultas SQL no cluster Hadoop/Hive para responder perguntas de negócio sobre e-commerce.  
- Propor evoluções futuras de otimização e visualização dos dados.  

---

### 🛠 Tecnologias Utilizadas  
- **Google BigQuery** (dataset público *theLook eCommerce*)  
- **Google Cloud Storage** (armazenamento dos CSVs)  
- **Hadoop / Hive** no **Dataproc (GCP)**  
- **HiveQL**  

---

### 📂 Estrutura do Projeto  
```bash
README.md
Bigquery_Storage_Extraction.txt        # Scripts de extração BigQuery → GCS
Table_Creation_Scripts/
  CREATE_EXTERNAL_TABLE_users.sql
  CREATE_EXTERNAL_TABLE_products.sql
  CREATE_EXTERNAL_TABLE_orders.sql
  CREATE_EXTERNAL_TABLE_order_items.sql
  CREATE_EXTERNAL_TABLE_inventory_items.sql
  CREATE_EXTERNAL_TABLE_events.sql
  CREATE_EXTERNAL_TABLE_distribution_centers.sql
queries/
  01_monthly_sales_trend.sql
  02_top_products.sql
  03_order_status_distribution.sql
  04_avg_order_value_per_customer.sql
  05_revenue_by_state.sql
```

### 🚀 Como Reproduzir
1. Exportar tabelas do BigQuery para o GCS
Arquivo: ```Bigquery_Storage_Extraction.txt```
```bash
bq extract --destination_format CSV \
bigquery-public-data:thelook_ecommerce.products \
gs://<SEU_BUCKET>/products/products.csv
```

2. Criar cluster no Dataproc
No Google Cloud Console, criar um cluster Dataproc (com Hive e Hadoop habilitados).
Acesse a VM master via SSH e rode os comandos Hive.

3. Criar o database no Hive
```sql
CREATE DATABASE IF NOT EXISTS thelook_ecommerce_db;
USE thelook_ecommerce_db;
```

4. Criar tabelas externas no Hive
Exemplo: ```CREATE_EXTERNAL_TABLE_users.sql```
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
LOCATION 'gs://<SEU_BUCKET>/users'
TBLPROPERTIES ('skip.header.line.count'='1');
```

5. Executar consultas no Hive
Examplo: ```01_monthly_sales_trend.sql```
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

### 📊 Consultas Implementadas
- Tendência de vendas e receita ao longo do tempo (mensal)
- Produtos e categorias mais vendidos
- Distribuição do status dos pedidos (entregues, devolvidos, cancelados etc.)
- Valor médio do pedido por cliente
- Padrões de compra por localização geográfica

### 🔎 Principais Resultados
- Crescimento consistente em pedidos e receita entre 2019–2025.
- Produtos mais vendidos: destaque para Jeans e Shorts.
- Distribuição de status: maioria Shipped e Complete, mas com Returned e Cancelled relevantes.
- Insights geográficos: maiores receitas concentradas em regiões específicas (ex.: Guangdong, California, São Paulo).

### 🛠 Próximos Passos
- Migrar para formato colunar (Parquet/ORC).
- Implementar particionamento de tabelas (ex.: por data).
- Conectar ao Looker Studio para dashboards.

### 📚 Referências
- Google Cloud — [theLook eCommerce (BigQuery public dataset)](https://console.cloud.google.com/marketplace/product/bigquery-public-data/thelook-ecommerce)
- Looker Team — [Looker Ecommerce Dataset (Kaggle)](https://www.kaggle.com/datasets/mustafakeser4/looker-ecommerce-bigquery-dataset)
- MDIC (2024) — [E-commerce no Brasil cresce 4% e alcança R$196 bi](https://www.gov.br/mdic/pt-br/assuntos/noticias/2024/setembro/e-commerce-no-brasil-cresce-4-e-alcanca-r-196-bi-em-2023)