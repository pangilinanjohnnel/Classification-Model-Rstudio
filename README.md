# 🏢 Philippine Housing Price Category Classification

Predicting whether a residential property in the Philippines falls into the **Affordable** or **Expensive** category based on structural and geographic characteristics.

---

## 📌 Problem Statement
The Philippine real estate market features diverse residential properties across varying locations, sizes, and price points. Real estate developers, investors, and homebuyers need an automated, data-driven method to categorize properties quickly. 

By leveraging property characteristics, this project builds a classification model to predict a property's price bracket accurately.

---

## ❓ Research Questions
1. **Predictive Capability:** Can physical and location-based housing characteristics reliably predict whether a property is classified as *Affordable* or *Expensive*?
2. **Feature Importance:** Which housing characteristics contribute most significantly to determining a property's price category?

---

## 📊 Dataset Overview
* **Dataset:** Philippines Housing Market
* **Source:** [Kaggle Dataset](https://www.kaggle.com/datasets/klekzee/phillipines-housing-market/data)
* **Features:** `Price`, `Location`, `Bedrooms`, `Bathrooms`, `Floor Area`, `Land Area`, `Latitude`, `Longitude`

---

## 🛠️ Feature Engineering & Data Setup
* **Target Variable (`Price_Category`):** Created using the **median housing price** as the threshold to handle potential extreme outliers.
  * 🟢 **Affordable:** Price $\le$ Median Price
  * 🔴 **Expensive:** Price $>$ Median Price
* **Data Leakage Prevention:** The raw `Price` variable was removed prior to modeling, forcing the classifier to rely solely on property attributes.
* **Predictors:** `Location`, `Bedrooms`, `Bathrooms`, `Floor Area`, `Land Area`, `Latitude`, `Longitude`

---

## ⚙️ Methodology & Modeling Workflow

1. **Preprocessing & Factor Encoding:** Convert `Price_Category` into a target factor variable and separate predictor variables.
2. **Model Training:** Fit the classification model using structural and geographical attributes.
3. **Feature Importance Analysis:** 
   * Extract numeric feature importance scores.
   * Generate a **Variable Importance Plot** to visually assess key pricing drivers.
4. **Prediction & Probability Scoring:**
   * Predict binary categories (*Affordable* vs. *Expensive*) on test data.
   * Calculate probability scores representing the likelihood of a property belonging to the *Expensive* class.
5. **Evaluation:**
   * **Confusion Matrix:** Evaluated with **"Expensive"** designated as the positive class.
   * **Overall Metrics:** Accuracy, Cohen’s Kappa.
   * **Class-Specific Metrics:** Sensitivity (Recall), Specificity, Precision, F1-Score.
   * **ROC & AUC Analysis:** Plot the Receiver Operating Characteristic (ROC) curve and compute the Area Under the Curve (AUC) to evaluate class separation capability.
