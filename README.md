# relational-metro-analytics
# 🚇 Relational Metro Analytics: Enterprise E-Commerce Warehouse & BI Pipeline

An enterprise data engineering and analytics solution built on 100,000+ historical orders from the Olist Brazilian E-Commerce dataset. This project addresses untracked conversion leaks, volatile Average Order Values ($AOV$), and customer churn through Google BigQuery staging views and optimized analytical queries.

---

## 🏗 Tech Stack & Architecture

```mermaid
graph LR
    A[<b>1. Raw CSV Source</b><br/>• Kaggle Olist Dataset<br/>• 5 Relational Tables] -->|ETL & Staging| B[<b>2. Data Warehouse</b><br/>• Google BigQuery<br/>• View Logic & SQL Engine]
    B -->|Direct SQL Native Query| C[<b>3. BI & Reporting Layer</b><br/>• Looker Studio / Power BI<br/>• Interactive Executive Dashboards]
