{{
    config(
        materialized='view',
        schema='analytics'
    )
}}

SELECT
    f.customer_id,
    f.gender,
    f.tenure_cohort,
    f.contract_type,
    f.monthly_charges,
    f.total_charges,
    f.cltv,
    p.predicted_churn_label,
    p.probability AS churn_probability,
    CASE 
        WHEN p.probability >= 0.7 THEN 'High Risk'
        WHEN p.probability >= 0.4 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS churn_risk_tier
FROM 
    {{ ref('customer_churn_features') }} f
LEFT JOIN 
    {{ ref('customer_churn_predictions') }} p
    ON f.customer_id = p.customer_id