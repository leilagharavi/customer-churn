-- Report model evaluation metrics
SELECT
    *
FROM
    ML.EVALUATE(MODEL `customer-churn-514612.ml.customer_churn_model`);