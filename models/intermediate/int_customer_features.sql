SELECT
    customer_id,
    gender,
    is_senior_citizen,
    has_partner,
    has_dependents,
    tenure_months,
    has_phone_service,
    internet_service,
    contract_type,
    payment_method,
    monthly_charges,
    total_charges,
    state,
    city,
    cltv,
    churn_label,
    -- Calculate average monthly spend vs total spend ratio
    SAFE_DIVIDE(total_charges, tenure_months) AS avg_calculated_monthly_charge,
    -- Group tenure into buckets
    CASE 
        WHEN tenure_months <= 12 THEN '0-1 year'
        WHEN tenure_months <= 36 THEN '1-3 years'
        ELSE '3+ years'
    END AS tenure_cohort 
FROM {{ ref('stg_customer_churn') }}