SELECT
    CustomerID AS customer_id,
    Gender AS gender,
    `Senior Citizen` AS is_senior_citizen,
    Partner AS has_partner,
    Dependents AS has_dependents,
    `Tenure Months` AS tenure_months,
    `Phone Service` AS has_phone_service,
    `Internet Service` AS internet_service,
    Contract AS contract_type,
    `Monthly Charges` AS monthly_charges,
    `Total Charges` AS total_charges,
    `Churn Value` AS churn_label,
    `State` AS state,
    City AS city,
    `Payment Method` AS payment_method,
    CLTV AS cltv
FROM {{ source('raw_data', 'telco_customer_churn') }}