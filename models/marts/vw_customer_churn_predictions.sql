{{
    config(
        materialized='view',
        schema='marts',
        description="BI-ready reporting view joining customer features with BQML churn probabilities and risk segmentation."
    )
}}

SELECT
    f.customer_id,
    f.gender,
    f.is_senior_citizen,
    f.tenure_months,
    f.tenure_cohort,
    f.contract_type,
    f.payment_method,
    f.monthly_charges,
    f.total_charges,
    f.cltv,
    f.state,
    p.predicted_churn_label,
    p.probability AS churn_probability,
    -- Business Segmentation: Categorize risk levels for the dashboard
    CASE 
        WHEN p.probability >= 0.7 THEN 'High Risk'
        WHEN p.probability >= 0.4 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS churn_risk_tier
FROM 
    {{ ref('customer_churn_features') }} f
LEFT JOIN 
    {{ source('customer_churn_ml', 'customer_churn_predictions') }} p
    ON f.customer_id = p.customer_id