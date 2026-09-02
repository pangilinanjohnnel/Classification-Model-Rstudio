# ============================================================
# CLASSIFICATION MODEL PHILIPPINE HOUSING 
# ============================================================


# 1. Dataset(Source:Kaggle)
# Philippine housing
# location, price, bedrooms, bathrooms, floor area, and land area.


# 2. Load the readxl for excel

library(readxl)

Housing <- read.csv("C:/Users/Johnnel/Desktop/TIP folder/2nd year 1st sem/business intellegence/W7/archive/Housing_v2.csv")

# 3. Check

head(Housing)
str(Housing)
colSums(is.na(Housing))
summary(Housing)

# 4. Classification model
#Price was used to create the Target variable: Price_Category.
#Predictors: Location, Bedrooms, Bathrooms, Floor Area, Land Area, Latitude, and Longitude 

Housing_Model <- Housing[, c(
  "Location",
  "Price",
  "Bedrooms",
  "Bathrooms",
  "Floor.Area",
  "Land.Area",
  "Latitude",
  "Longitude")]

# 5. Clean

Housing_Model <- na.omit(Housing_Model)
dim(Housing_Model)

# 6. Median housing price
# The median will be used as the basis for creating the two price categories.

median_price <- median(Housing_Model$Price)
median_price


#7. Create the classification target variable
# Affordable = price is equal to or below the median
# Expensive  = price is above the median

Housing_Model$Price_Category <- ifelse(
  Housing_Model$Price <= median_price,
  "Affordable",
  "Expensive")


# Convert Price_Category into a factor.
# Classification models in R use factors

Housing_Model$Price_Category <- as.factor(Housing_Model$Price_Category)


# Check how many properties belong to each category.

table(Housing_Model$Price_Category)


# 8. Prepare the final variables for the model
# Remove Price from the dataset used for modeling to prevent leakage
# The model will instead use the property characteristics
# to predict whether a property is Affordable or Expensive.

Housing_Model <- Housing_Model[, c(
  "Location",
  "Bedrooms",
  "Bathrooms",
  "Floor.Area",
  "Land.Area",
  "Latitude",
  "Longitude",
  "Price_Category")]


# Check 

str(Housing_Model)
head(Housing_Model)


# 9. Split
library(caret)

set.seed(123)

# 80% for training 20% for testing

train_index <- createDataPartition(
  Housing_Model$Price_Category,
  p = 0.80,
  list = FALSE)

Train <- Housing_Model[train_index, ]
Test <- Housing_Model[-train_index, ]

# Check

dim(Train)
dim(Test)
str(Train)


# 10. Random Forest classification model

library(randomForest)

Model <- randomForest(
  Price_Category ~ .,
  data = Train,
  ntree = 500,
  importance = TRUE)

Model


# 11. Display the importance scores of the predictor variables.
# This helps identify which housing characteristics contribute the most in Price Category.

importance(Model)

# Variable importance plot.
# The plot provides a visual representation of the importance of each predictor.

varImpPlot(Model)


# #12. Predict the price category of the test data
Prediction <- predict(Model, Test)

head(Prediction)


# 13. Evaluate the classification model using a confusion matrix
# Compare the predicted categories with actual
# "Expensive" is designated as the positive class.



Confusion_Matrix <- confusionMatrix(
  Prediction,
  Test$Price_Category,
  positive = "Expensive")

Confusion_Matrix


# 14. Display the overall classification metrics
# Display overall performance measures such as: Accuracy and Kappa.
Confusion_Matrix$overall

# Display class-specific measures such as:
# Sensitivity/Recall, Specificity, Precision, and F1-score.
Confusion_Matrix$byClass

# 15. ROC and AUC

library(pROC)

# Probability that each property belongs to the Expensive category.
# Instead of simply predicting Affordable/Expensive,
# this gives the model's probability for being Expensive.

Probability <- predict(
  Model,
  Test,
  type = "prob"
)[, "Expensive"]


# Create the ROC curve.
# The ROC curve evaluates how well the model can
# distinguish between Affordable and Expensive properties.
ROC <- roc(
  Test$Price_Category,
  Probability,
  levels = c("Affordable", "Expensive"))
plot(ROC)


# Area Under the Curve (AUC).
# A higher AUC means that the model is better at distinguishing between the two price categories.
auc(ROC)

