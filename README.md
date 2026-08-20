# relational-metro-analytics
# 🚇 Relational Metro Analytics: Enterprise E-Commerce Warehouse & BI Pipeline

An enterprise data engineering and analytics solution built on 100,000+ historical orders from the Olist Brazilian E-Commerce dataset. This project addresses untracked conversion leaks, volatile Average Order Values ($AOV$), and customer churn through Google BigQuery staging views and optimized analytical queries.

---

## 🏗 Tech Stack & Architecture

RAW CSV SOURCE              DATA WAREHOUSE                    BI & REPORTING LAYER
┌──────────────────┐       ┌──────────────────────┐          ┌───────────────────────┐
│ • Kaggle CSVs    │ ────> │ • Google BigQuery    │ ───────> │ • Looker Studio /     │
│   (5 Core Tables)│ (ETL) │   (Staging Views &   │   (SQL)  │   Power BI            │
│                  │       │    Complex Analytics)│          │   (Interactive UI)    │
└──────────────────┘       └──────────────────────┘          └───────────────────────┘

