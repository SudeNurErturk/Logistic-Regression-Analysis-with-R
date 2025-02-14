library(ggplot2)
library(reshape2)

# Veri kümesini yükle
data <- read.csv("/Users/sudenurerturk/Downloads/HR_comma_sep.csv")

# İlk birkaç satırı kontrol et
head(data)

# Veri yapısını kontrol et
str(data)

# Özet istatistikler
summary(data)

# Eksik verileri kontrol etme
colSums(is.na(data))

# Department sütunundaki değerlerin frekansını say
table(data$Department)

# "Department" ve "salary" sütunlarını çıkartarak yeni bir veri çerçevesi oluşturma
df_no_strings <- data[, !names(data) %in% c("Department", "salary")]

# İlk birkaç satırı görüntüleme
head(df_no_strings)

# Korelasyon matrisini hesaplama
correlation_matrix <- cor(df_no_strings)

# Korelasyon matrisini görüntüleme
print(correlation_matrix)

# Korelasyon matrisini uzun forma dönüştürme
correlation_matrix_long <- melt(correlation_matrix)

# Isı haritasını oluşturma
ggplot(correlation_matrix_long, aes(x = Var1, y = Var2, fill = value)) +
  geom_tile(color = "white") +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", 
                       midpoint = 0, limit = c(-1, 1), space = "Lab",
                       name = "Correlation") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
  labs(title = "Correlation Matrix Heatmap", x = "", y = "")

# 3. Cluster bulma (K-means)
# Veriyi normalize etme
data_normalized <- scale(data[, c("satisfaction_level", "last_evaluation", "number_project", "average_montly_hours", "time_spend_company", "Work_accident", "promotion_last_5years")])

# K-means clustering (3 cluster seçelim)
set.seed(123)
kmeans_model <- kmeans(data_normalized, centers = 3, nstart = 25)

# Cluster sonuçlarını veri kümesine ekle
data$cluster <- as.factor(kmeans_model$cluster)

# Kümeleme sonuçlarını görselleştirme
ggplot(data, aes(x = satisfaction_level, y = last_evaluation, color = cluster)) +
  geom_point() +
  labs(title = "Clusters based on Satisfaction Level and Last Evaluation",
       x = "Satisfaction Level", y = "Last Evaluation") +
  scale_color_manual(values = c("red", "blue", "green")) +
  theme_minimal()


# 1. Aykırı Değerleri Bulma (Z-skoru)
z_scores <- scale(data[, c("satisfaction_level", "last_evaluation", "number_project", 
                           "average_montly_hours", "time_spend_company", 
                           "Work_accident", "promotion_last_5years")])

# Aykırı değerlerin satırlarını tespit etme (Z-skoru > 3 veya < -3)
outliers <- which(abs(z_scores) > 3, arr.ind = TRUE)
outlier_rows <- unique(outliers[, 1])  # Her aykırı değerin satırını al
outliers_data <- data[outlier_rows, ]  # Aykırı değerleri içeren veri alt kümesi

# 2. Aykırı Değerlerin Veri Setinden Çıkarılması
data_cleaned <- data[-outlier_rows, ]  # Aykırı değerlerin çıkarıldığı veri seti

# 3. Görselleştirme: Aykırı Değerler (Silinmeden Önce)
plot_before <- ggplot(data, aes(x = satisfaction_level, y = last_evaluation)) +
  geom_point(aes(color = ifelse(row.names(data) %in% row.names(outliers_data), "Outlier", "Normal"))) +
  labs(title = "Outliers Before Removal",
       x = "Satisfaction Level", y = "Last Evaluation") +
  scale_color_manual(values = c("Normal" = "blue", "Outlier" = "red")) +
  theme_minimal()

# 4. Görselleştirme: Temizlenmiş Veri Seti (Silindikten Sonra)
plot_after <- ggplot(data_cleaned, aes(x = satisfaction_level, y = last_evaluation)) +
  geom_point(color = "blue") +
  labs(title = "Data Without Outliers",
       x = "Satisfaction Level", y = "Last Evaluation") +
  theme_minimal()

# 5. Görselleştirmeleri Gösterme
print(plot_before)  # Aykırı değerlerin olduğu grafik
print(plot_after)   # Temizlenmiş veri seti ile grafik



# 5. Regresyon doğrusu (logistik) çizme
# Logistik regresyon modeli kurma
model <- glm(left ~ satisfaction_level + last_evaluation + number_project + average_montly_hours + 
               time_spend_company + Work_accident + promotion_last_5years + Department + salary,
             data = data_cleaned, family = binomial(link = "logit"))

# Logistik regresyon eğrisini çizme
ggplot(data_cleaned, aes(x = satisfaction_level, y = left)) +
  geom_point(alpha = 0.5, color = "blue") +
  stat_smooth(method = "glm", method.args = list(family = "binomial"), color = "red", se = FALSE) +
  labs(title = "Logistic Regression Curve (Outliers Removed)",
       x = "Satisfaction Level", y = "Probability of Leaving (Left)") +
  theme_minimal()

# 6. Logistik regresyon analizi
# Y ve X değişkenlerini ayırma
y <- data_cleaned$left
x <- data_cleaned[, !names(data_cleaned) %in% c('left')]

# Veriyi eğitim ve test kümelerine ayırma (80% eğitim, 20% test)
set.seed(123)  # Rastgelelik için kontrol
train_indices <- sample(1:nrow(data_cleaned), size = 0.8 * nrow(data_cleaned))
x_train <- x[train_indices, ]
y_train <- y[train_indices]
x_test <- x[-train_indices, ]
y_test <- y[-train_indices]

# Logistik regresyon modeli
log_reg_model <- glm(y_train ~ ., data = cbind(x_train, y_train), family = binomial(link = "logit"))

# Model özetini görüntüleme (koefisiyentler)
summary(log_reg_model)

# Tahminler yapma
predictions <- predict(log_reg_model, newdata = x_test, type = "response")
predicted_class <- ifelse(predictions > 0.5, 1, 0)  # 0.5 eşik değeri ile sınıflandırma

# Doğruluk hesaplama
accuracy <- mean(predicted_class == y_test)
accuracy

# Karışıklık matrisi (Confusion Matrix)
confusion_matrix <- table(TrueClass = y_test, PredClass = predicted_class)
print(confusion_matrix)

# Gerçek ve tahmin edilen olasılıkların görselleştirilmesi
ggplot(data.frame(PredictedProb = predictions, ActualClass = y_test), aes(x = PredictedProb, fill = factor(ActualClass))) +
  geom_histogram(position = "identity", alpha = 0.5, binwidth = 0.05) +
  labs(title = paste("Logistic Regression - Accuracy (Outliers Removed):", round(accuracy, 2)),
       x = "Predicted Probability", y = "Count", fill = "Actual Class") +
  theme_minimal()
