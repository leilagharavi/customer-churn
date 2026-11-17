-- View the learned weights for each feature in the Logistic Regression model
SELECT
    *
FROM
    ML.WEIGHTS(MODEL `customer-churn-514612.ml.customer_churn_model`)
ORDER BY ABS(weight) DESC;