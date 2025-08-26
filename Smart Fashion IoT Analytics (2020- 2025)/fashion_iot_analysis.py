"""
fashion_iot_analysis.py
Basic EDA and modeling script for Smart Fashion IoT Analytics 2025.
Run: python fashion_iot_analysis.py
"""

import pandas as pd
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import classification_report, accuracy_score
import joblib

df = pd.read_csv("fashion_iot_data.csv", parse_dates=["Purchase_Date"])
print("Rows:", len(df))
print(df.head())

# Quick EDA: IoT adoption over years
df["Year"] = df["Purchase_Date"].dt.year
iot_by_year = df[df["IoT_Feature_Used"]=='Yes'].groupby("Year").size()
print("IoT purchases by year:\n", iot_by_year)

# Simple feature engineering for modeling: predict IoT_Feature_Used
df_model = df.copy()
df_model["IoT_Label"] = (df_model["IoT_Feature_Used"]=='Yes').astype(int)
# Encode simple features
df_model = pd.get_dummies(df_model, columns=["Product_Category","Device_Connectivity","Age_Group","Gender","City"], drop_first=True)
X = df_model.drop(columns=["Transaction_ID","Customer_ID","Purchase_Date","IoT_Feature_Used","IoT_Label","Price","Total_Spend","Carbon_Footprint_gCO2"], errors="ignore")
y = df_model["IoT_Label"]

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42, stratify=y)
clf = RandomForestClassifier(n_estimators=100, random_state=42)
clf.fit(X_train, y_train)
y_pred = clf.predict(X_test)
print("Accuracy:", accuracy_score(y_test, y_pred))
print(classification_report(y_test, y_pred))

# Save model
joblib.dump(clf, "fashion_iot_model.joblib")

# Plot and save a trend figure
iot_by_year.plot(kind="bar", title="IoT Purchases by Year")
plt.tight_layout()
plt.savefig("iot_purchases_by_year.png")
print("Artifacts saved: model, plot")
