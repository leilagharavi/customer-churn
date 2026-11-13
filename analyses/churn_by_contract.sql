-- Ad-hoc query to analyze churn rates across different contract types
SELECT
    contract_type,
    COUNT(customer_id) AS total_customers,
    SUM(churn_label) AS total_churned,
    ROUND(SAFE_DIVIDE(SUM(churn_label), COUNT(customer_id)) * 100, 2) AS churn_rate_percentage,
    ROUND(AVG(monthly_charges), 2) AS avg_monthly_charges
FROM {{ ref('int_customer_features') }}
GROUP BY contract_type
ORDER BY churn_rate_percentage DESC;