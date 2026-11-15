# End-to-End Customer Churn Prediction 

[![dbt](https://img.shields.io/badge/dbt-1.7+-orange)](https://www.getdbt.com/)
[![BigQuery](https://img.shields.io/badge/BigQuery-Sandbox-blue)](https://cloud.google.com/bigquery)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Business Problem

This project builds an end-to-end customer churn prediction pipeline that:
- cleans and transforms raw Telco customer data using **dbt**,
- trains a **logistic regression model** in **BigQuery ML** to predict churn probability, 
- exposes results via a **Looker Studio dashboard** and static charts for business stakeholders.

The entire workflow runs on the **BigQuery Sandbox** and **dbt Core** locally.

## Dataset

- **Telco Customer Churn** (public, ~7,000 rows, 21 columns)
- Source: [Kaggle - Telco Customer Churn](https://www.kaggle.com/datasets/blastchar/telco-customer-churn)
- Label: `Churn` (Yes/No)
- Features: demographics, account information, services subscribed, contract type, monthly charges, tenure.

## dbt Project Structure