{{
    config(
        materialized='table',
        description='Feature-engineered customer churn table ready for BQML training and analytics.'
    )
}}

SELECT
    customer_id,
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
    city,
    cltv,
    churn_label
FROM {{ ref('int_customer_features') }}