# 🏢 Philippine Housing Price Category Classification

Predicting whether a residential property in the Philippines falls into the **Affordable** or **Expensive** category based on structural and geographic characteristics.

---

## 📌 Problem Statement
The Philippine real estate market features diverse residential properties across varying locations, sizes, and price points. Real estate developers, investors, and homebuyers need an automated, data-driven method to categorize properties quickly. 
* **Research Questions:**
  1. Can housing characteristics reliably predict if a property is *Affordable* or *Expensive*?
  2. Which features contribute most significantly to determining the price category?
* **Dataset:** [Philippines Housing Market (Kaggle)](https://www.kaggle.com/datasets/klekzee/phillipines-housing-market/data)
* **Target Variable (`Price_Category`):** Binary split using the median price (**PHP 10,500,000**) to mitigate extreme outliers.
  * 🟢 **Affordable:** $\le$ PHP 10.5M (530 properties)
  * 🔴 **Expensive:** $>$ PHP 10.5M (528 properties)
* **Predictors:** `Location`, `Bedrooms`, `Bathrooms`, `Floor.Area`, `Land.Area`, `Latitude`, `Longitude` *(Raw `Price` removed to prevent leakage)*.

---

## ⚙️ Workflow & Model Performance

A **Random Forest** classifier (500 trees) was trained on 847 samples and evaluated on a 211-sample test set (80/20 split).

### Results

| Evaluation Metric | Value | Model Performance Summary |
| :--- | :---: | :--- |
| **Accuracy** | **92.89%** | 95% CI: (88.55%, 95.97%) |
| **Kappa Statistic** | **0.8578** | High inter-rater agreement |
| **ROC - AUC** | **0.9863** | Outstanding class separation |
| **Sensitivity (Recall)** | **94.29%** | Correctly identified Expensive homes |
| **Specificity** | **91.51%** | Correctly identified Affordable homes |
| **F1-Score** | **92.96%** | Balanced precision and recall |

### Confusion Matrix
| | Actual: Affordable | Actual: Expensive |
| :--- | :---: | :---: |
| **Predicted: Affordable** | **97** *(True Neg)* | **6** *(False Neg)* |
| **Predicted: Expensive** | **9** *(False Pos)* | **99** *(True Pos)* |

---

## 🔑 Key Drivers (Feature Importance)

The Random Forest model identified structural footprint as the primary determinant of price tier:

1. **Floor Area** (*Top Predictor* — 55.67 MDA / 153.03 Gini)
2. **Land Area** (46.07 MDA / 85.55 Gini)
3. **Bathrooms** (28.58 MDA / 70.74 Gini)

