# 🚇 Relational Metro Analytics: Custom E-Commerce Warehouse & Full-Stack Dashboard

An enterprise data engineering and web analytics platform built on 100,000+ historical orders from the Olist Brazilian E-Commerce dataset. This project addresses untracked conversion leaks, volatile Average Order Values ($AOV$), and customer churn through Google BigQuery staging views, complex SQL analytics, and a custom-coded HTML/CSS/JS web dashboard.

---

## 🏗 Tech Stack & System Architecture

```mermaid
graph LR
    A[<b>1. Raw CSV Source</b><br/>• Kaggle Olist Dataset<br/>• 5 Relational Tables] -->|ETL & Staging| B[<b>2. Data Warehouse</b><br/>• Google BigQuery<br/>• View Logic & SQL Engine]
    B -->|BigQuery JSON Export| C[<b>3. Data Pipeline</b><br/>• Static JSON Endpoints<br/>• /data/*.json]
    C -->|Fetch API| D[<b>4. Custom Web App</b><br/>• HTML5 / CSS3 / JavaScript<br/>• Chart.js / Netlify Hosting]
