# End-to-End Customer Churn Prediction 

This project builds an end-to-end customer churn prediction pipeline that:
- cleans and transforms raw Telco customer data using **dbt**,
- trains a **logistic regression model** in **BigQuery ML** to predict churn probability, 
- exposes results via a **Looker Studio dashboard** and static charts for business stakeholders.

The entire workflow runs on the **BigQuery Sandbox** and **dbt Core** locally.

[![dbt](https://img.shields.io/badge/dbt-1.7+-orange)](https://www.getdbt.com/)
[![BigQuery](https://img.shields.io/badge/BigQuery-Sandbox-blue)](https://cloud.google.com/bigquery)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)


## 🛠️ Quickstart & Setup Instructions
### Prerequisites
- dbt-core or dbt Cloud account
- Google Cloud Platform (GCP) Account with BigQuery enabled
- Git CLI

### Installation & Execution

#### Clone the repository
```Bash
git clone https://github.com/leilagharavi/customer-churn.git
cd customer-churn
```

#### Install dbt dependencies
```Bash
dbt deps
```

#### Test raw source connection
```Bash
dbt debug
```

#### Build the dbt models
```Bash
dbt run
```

#### Train the BQML Model

Execute the query inside `analyses/train_churn_model.sql` within your BigQuery console to train the model and evaluate metrics (`ML.EVALUATE`).

## 🚀 Data Transformations & Feature Engineering

#### Raw dataset

- **Telco Customer Churn** (public, ~7,000 rows, 21 columns)
- Source: [Kaggle - Telco Customer Churn](https://www.kaggle.com/datasets/blastchar/telco-customer-churn)
- Label: `Churn` (Yes/No)
- Features: demographics, account information, services subscribed, contract type, monthly charges, tenure.

#### dbt Project Structure

The project uses a domain-driven, modular architecture designed for scalability, maintainability, and clean separation of concerns:

```customer-churn-dbt/
├── analyses/
│   ├── churn_by_contract.sql           # Ad-hoc SQL exploration on contract risks
│   └── train_churn_model.sql           # BigQuery ML model creation & evaluation script
│   └── view_learned_weights.sql        # Query to view the learned weights of the ML model
│   └── model_evaluation_metrics.sql    # Query to report the ML model evaluation metrics
├── models/
│   ├── staging/
│   │   ├── _sources_.yml               # Source definitions & data tests
│   │   └── stg_customer_churn.sql      # Cleaning & standardizing raw columns
│   ├── intermediate/
│   │   └── int_customer_features.sql   # Feature engineering layer
│   └── marts/
│       └── customer_churn_features.sql # Production table feeding BQML
├── dbt_project.yml                     # dbt configuration file
├── packages.yml                        # Package management (dbt-utils)
└── README.md
```

#### Staging layer : `stg_customer_churn`
- Standardizes raw column names into strict snake_case.
- Handles whitespace edge cases in numerical fields (e.g. `TotalCharges`) using `NULLIF`.
- Converts binary text targets (`Yes/No`) into numeric indicators (`1/0`) for ML ingestion.

#### Intermediate layer : `int_customer_features`
- Tenure Cohorts: Categorizes customer lifespan (0-1 year, 1-3 years, 3+ years).
- Spend Ratios: Calculates `avg_calculated_monthly_charge` via `SAFE_DIVIDE(total_charges, tenure_months)`.
- Materialization: Configured as ephemeral to optimize BigQuery execution costs and eliminate warehouse clutter.

#### Mart layer : `customer_churn_features`
- Materialized as a table for fast querying by analytics tools and BigQuery ML algorithms.
- Integrates Customer Lifetime Value (CLTV) to enable value-based churn prioritization.


## 🤖 Machine Learning with BigQuery ML (BQML)
Instead of exporting data out of the warehouse into Python environments, a binary logistic regression model is trained directly in BigQuery:
- Model Type: `logistic_reg`
- Class Balancing: `auto_class_weights = TRUE`
- Regularization: `l1_reg = 0.1` and `l2_reg` = 0.1 (prevent overfitting)