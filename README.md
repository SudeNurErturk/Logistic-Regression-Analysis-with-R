# 📊 Employee Turnover Prediction using Logistic Regression

This project analyzes employee turnover using logistic regression, clustering, correlation analysis, and outlier detection on an HR dataset. It was developed as part of the **CMPE 343 - Business Intelligence and Applied Analytics** course.

## 📁 Dataset

The dataset includes key HR features such as:
- Satisfaction level
- Last evaluation
- Average monthly hours
- Number of projects
- Time spent at the company
- Whether the employee left the company (target)

## 🔍 Exploratory Data Analysis

### 📈 Correlation Analysis
- **Satisfaction Level**: Strong negative correlation with turnover.
- **Time Spent at the Company**: Positive correlation — may reflect burnout.
- **Number of Projects**: Moderate correlation — related to workload.

### ⚠️ Outlier Detection
Outliers were identified using Z-scores:
- Employees with extreme monthly hours or satisfaction levels were flagged.
- Many outliers belonged to the high-risk turnover group.

## 🔀 Clustering

Applied **K-Means clustering (k=3)** on satisfaction and evaluation scores:
- **Cluster 1**: High satisfaction and high evaluation (low turnover risk)
- **Cluster 2**: Low satisfaction and low evaluation (high turnover risk)
- **Cluster 3**: Mixed traits (moderate risk)

## 🧠 Logistic Regression Model

### ✅ Performance:
- **Accuracy**: 80% (0.80)

### 📊 Probability Distribution:
- **Class 0 (Stayed)**: Predictions mostly between 0.0–0.3
- **Class 1 (Left)**: Peaks around 0.6–1.0
- **Overlap**: Some ambiguity between 0.3–0.6 range

### 🧠 Key Insights:
- Predictions near 0 → Likely to stay  
- Predictions near 1 → Likely to leave  
- Most reliable predictions are at the extremes

## 🧪 Tools & Technologies

- Python
- Scikit-learn
- Pandas / Numpy
- Matplotlib / Seaborn
- Jupyter Notebook

## 📌 Author

**Sude Nur Ertürk**  
CMPE 343 - Istanbul Bilgi University

---


