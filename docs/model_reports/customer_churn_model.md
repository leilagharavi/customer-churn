# Model Performance & Feature Importance Report 

**Model Name:** `customer_churn_model`
**Model Type:** Binary Logistic Regression (`logistic_reg`)  
**Target Variable:** `churn_label` (1 = Churned, 0 = Retained)  
**Training Framework:** BigQuery ML (BQML)  
**Evaluation Strategy:** Class balancing via `auto_class_weights=TRUE`, $L_1/L_2$ regularization ($0.1$)  

## 📊 Model Evaluation Metrics (`ML.EVALUATE`)

The model was evaluated on the full feature dataset using BigQuery ML's evaluation procedures. Below are the key classification metrics:

| Metric | Score (Raw) | Score (Rounded) | Interpretation |
| :--- | :---: | :---: | :--- |
| **ROC AUC** | `0.8469` | **0.85** | **Excellent Discriminatory Power:** Strong ability to separate churning users from retained users. |
| **Accuracy** | `0.7764` | **77.6%** | Overall correct predictions across both classes. |
| **Recall** | `0.7676` | **76.8%** | **High Sensitivity:** Successfully captures nearly 77% of all actual churners (crucial for retention teams). |
| **Precision** | `0.5602` | **56.0%** | Of all predicted churners, 56% actually churned (balanced via auto class weights). |
| **F1 Score** | `0.6477` | **0.65** | Solid harmonic mean balancing precision and recall. |
| **Log Loss** | `0.4659` | **0.47** | Low prediction error calibration score. |


## 🧠 Learned Feature Weights Analysis (`ML.WEIGHTS`)

The following table breaks down the model coefficients: positive weights drive churn risk, while negative weights serve as protective retention anchors.

| Feature / Category | Weight | Impact | Technical & Business Interpretation |
| :--- | :---: | :---: | :--- |
| **Dependents (Yes)** | `-0.742` | ✅ Strong Retention | Strongest protective factor in the model. Multi-person/family households have high switching friction. |
| **Contract (Two year)** | `-0.698` | ✅ Strong Retention | High contractual lock-in. Significantly reduces voluntary attrition. |
| **Internet (None)** | `-0.576` | 🛡️ Retention | Basic utility subscribers exhibit lower price sensitivity and lower churn propensity. |
| **Contract (One year)** | `-0.415` | 🛡️ Retention | Moderate contractual commitment. |
| **Payment (Auto Credit Card)**| `-0.332` | 🛡️ Retention | Automated, friction-free billing reduces both voluntary and passive churn. |
| **Tenure (3+ years)** | `-0.304` | 🛡️ Retention | Long-standing account maturity strengthens customer loyalty. |
| **Tenure (0-1 year)** | `+0.416` | 🚨 High Risk | New subscribers are in the highest risk window during their first 12 months. |
| **Contract (Month-to-month)**| `+0.351` | 🚨 High Risk | Lack of commitment makes these accounts highly sensitive to competitor promotions. |
| **Payment (Electronic check)**| `+0.343` | 🚨 High Risk | Manual electronic payments show strong correlation with subscriber departure. |
| **Internet (Fiber optic)** | `+0.343` | 🚨 High Risk | Premium tier users exhibit higher price sensitivity and service expectations. |
| **Senior Citizen (Yes)** | `+0.237` | ⚠️ Moderate Risk | Senior demographics show elevated churn risk, indicating targeted support/plan needs. |


## 💡 Executive Actionable Recommendations

1. **Targeted First-Year Onboarding:**  
   Focus customer success efforts on the `0-1 year` tenure cohort (`+0.416` risk weight) with automated check-ins during the first 90 days.
2. **Contract Migration Incentives:**  
   Target `Month-to-month` subscribers (`+0.351` risk weight) with a small monthly billing discount if they commit to a 1-year or 2-year agreement.
3. **Automated Billing Transition:**  
   Incentivize `Electronic check` users (`+0.343` risk weight) to migrate to `Credit card (automatic)` billing (`-0.332` retention weight) with a one-time account credit.