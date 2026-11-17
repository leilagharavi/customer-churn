-- =========================================================================
-- BigQuery ML: Train Customer Churn Prediction Model
-- =========================================================================
-- Model Type: Logistic Regression (binary classification)
-- Target Label: churn_label (1 for churned, 0 for retained)
-- Features: Demographics, tenure, services, contract type, charges, and CLTV
-- =========================================================================

CREATE OR REPLACE MODEL `customer-churn-514612.ml.customer_churn_model`
OPTIONS(
    model_type = 'logistic_reg',
    input_label_cols = ['churn_label'],
    auto_class_weights = TRUE,
    l1_reg = 0.1,              
    l2_reg = 0.1
) AS

SELECT
    gender,
    is_senior_citizen,
    has_partner,
    has_dependents,
    tenure_months,
    tenure_cohort,
    has_phone_service,
    internet_service,
    contract_type,
    payment_method,
    monthly_charges,
    total_charges,
    avg_calculated_monthly_charge,
    state,
    cltv,
    churn_label
FROM `customer-churn-514612.analytics.customer_churn_features`;