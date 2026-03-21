# Required Libraries
library(tidyverse)
library(lubridate)
library(gridExtra)
library(ggrepel)
library(maps)
library(scales)
library(splitstackshape)

# Loading the dataset as a dataframe
gun_data <- read.csv("C:/Users/akbak/Downloads/gun-violence-data_01-2013_03-2018.csv")

# Summary of the dataset
summary(gun_data)

# Checking data types of each column
data_types <- sapply(gun_data, class)
data_types_df <- tibble(Column = names(data_types), DataType = data_types)

# Counting unique values in each column
unique_counts <- sapply(gun_data, function(x) length(unique(x)))
unique_counts_df <- tibble(Column = names(unique_counts), UniqueValues = unique_counts)

# Combining data types and unique counts
data_summary <- left_join(data_types_df, unique_counts_df, by = "Column") %>%
  arrange(UniqueValues)
data_summary

# Finding and handling missing data
missing_data <- sapply(gun_data, function(x) sum(is.na(x)))
missing_percentage <- (missing_data / nrow(gun_data)) * 100
missing_summary <- tibble(
  Column = names(missing_data),
  MissingCount = missing_data,
  MissingPercentage = missing_percentage
) %>%
  arrange(desc(MissingPercentage))
missing_summary

# Detecting and removing duplicates
duplicate_count <- sum(duplicated(gun_data))
cat("Number of duplicate rows:", duplicate_count, "\n")

# Visualizing outliers in 'n_killed' and 'n_injured'
ggplot(gun_data, aes(y = n_killed)) +
  geom_boxplot(fill = "blue", color = "black", alpha = 0.7) +
  labs(title = "Outliers in n_killed", y = "Number of People Killed") +
  theme_minimal()

ggplot(gun_data, aes(y = n_injured)) +
  geom_boxplot(fill = "red", color = "black", alpha = 0.7) +
  labs(title = "Outliers in n_injured", y = "Number of People Injured") +
  theme_minimal()

# Identifying relationships between 'n_killed' and 'n_injured'
ggplot(gun_data, aes(x = n_killed, y = n_injured)) +
  geom_point(alpha = 0.5, color = "darkgreen") +
  labs(title = "Relationship between Number Killed and Number Injured", x = "Number of People Killed", y = "Number of People Injured") +
  theme_minimal()

# Bar chart for top 10 states by incident frequency
top_states <- gun_data %>%
  count(state, sort = TRUE) %>%
  slice_max(n, n = 10)

ggplot(top_states, aes(x = reorder(state, n), y = n)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  labs(title = "Top 10 States by Incident Frequency", x = "State", y = "Number of Incidents") +
  theme_minimal()

# Extracting year and quarter
gun_data$date <- ymd(gun_data$date)
gun_data <- gun_data %>% mutate(year = year(date), quarter = quarter(date))

# Plotting number of incidents by year
gun_data %>%
  ggplot(aes(x = as.factor(year))) +
  geom_bar(stat = 'count', fill = 'red') +
  scale_y_continuous(labels = comma) +
  geom_label(stat = "count", aes(label = after_stat(count), y = after_stat(count))) +
  labs(x = 'Year', y = 'Number of Incidents', title = 'Number of Incidents by Year (2013-2018)')

# Plotting number of incidents by quarter each year, excluding 2013
q1 <- gun_data %>%
  filter(year != 2013) %>%
  count(year, quarter) %>%
  ggplot(aes(x = as.factor(quarter), y = n)) +
  geom_col(fill = 'red') +
  scale_y_continuous(labels = comma) +
  facet_grid(. ~ year) +
  labs(x = 'Quarter', y = 'Number of Incidents', title = 'Incidents by Quarter (2014-2018)')

# Plotting number of incidents in Q1 of each year, excluding 2013
q2 <- gun_data %>%
  filter(year != 2013 & quarter == 1) %>%
  count(year) %>%
  ggplot(aes(x = as.factor(year), y = n)) +
  geom_col(fill = 'red') +
  scale_y_continuous(labels = comma) +
  labs(x = 'Year', y = 'Number of Incidents in Q1', title = 'Incidents in Q1 by Year (2014-2018)')

# Displaying the plots side by side
grid.arrange(q1, q2, ncol = 1)

# Extracting month
gun_data <- gun_data %>% mutate(month = month(date, label = TRUE))

# Plotting incidents by month
gun_data %>%
  filter(year %in% 2014:2018) %>%
  count(month) %>%
  ggplot(aes(x = month, y = n)) +
  geom_col(fill = 'red') +
  scale_y_continuous(labels = comma) +
  geom_text(aes(label = n), vjust = 1.2, color = "white", size = 3) +
  labs(x = 'Month', y = 'Number of Incidents', title = 'Incidents by Month (2014-2018)') +
  theme_minimal()

# Extracting day from date
gun_data <- gun_data %>% mutate(day = day(date), date2 = str_c(year, " ", month, " ", day))

# Plotting top 10 most frequent dates with incidents
gun_data %>%
  filter(year %in% 2014:2018) %>%
  count(date2, sort = TRUE) %>%
  slice_max(n, n = 10) %>%
  ggplot(aes(x = reorder(date2, -n), y = n)) +
  geom_col(fill = 'red') +
  geom_text(aes(label = n), vjust = 1.2, color = "white", size = 4) +
  scale_y_continuous(labels = comma) +
  labs(x = 'Date (Year, Month, and Day)', y = 'Total Number of Incidents', title = 'Top 10 Dates with Highest Number of Gun Incidents') +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Extracting weekday and plotting incidents by weekday
gun_data <- gun_data %>% mutate(weekday = wday(date, label = TRUE))

gun_data %>%
  count(weekday) %>%
  ggplot(aes(x = weekday, y = n)) +
  geom_col(fill = 'red') +
  scale_y_continuous(labels = comma) +
  geom_text(aes(label = n), vjust = 1.2, color = "white", size = 4) +
  labs(x = 'Weekday', y = 'Number of Incidents', title = 'Incidents by Weekday') +
  theme_minimal()

# Converting 'state' and 'city_or_county' columns to factors
gun_data <- gun_data %>%
  mutate(across(c(state, city_or_county), as.factor))

str(gun_data$state)
str(gun_data$city_or_county)

# Plotting incidents by state on the US map
us_states <- map_data("state")

gun_state_data <- gun_data %>%
  count(state) %>%
  mutate(state = tolower(state))

map_data <- us_states %>%
  left_join(gun_state_data, by = c("region" = "state"))

state_centroids <- map_data %>%
  group_by(region) %>%
  summarise(long = mean(range(long)), lat = mean(range(lat)), n = mean(n, na.rm = TRUE)) %>%
  filter(!is.na(n))

ggplot() +
  geom_polygon(data = map_data, aes(long, lat, group = group, fill = n), color = "white") +
  geom_text_repel(data = state_centroids, aes(x = long, y = lat, label = round(n)), 
                  size = 3, color = "black", max.overlaps = 10, box.padding = 0.5, point.padding = 0.5) +
  scale_fill_gradient(low = "yellow", high = "red", na.value = "grey90", name = "Incidents") +
  theme_minimal() +
  labs(title = "Number of Gun Incidents by State in the US", x = "", y = "") +
  theme(axis.text = element_blank(),
        axis.ticks = element_blank(),
        panel.grid = element_blank())

# Plotting the top 10 cities by the number of incidents
incidentsByCity <- gun_data %>%
  count(city = city_or_county, state, name = "cityIncidents")

incidentsByCity %>%
  slice_max(order_by = cityIncidents, n = 10) %>%
  ggplot(aes(x = reorder(city, cityIncidents), y = cityIncidents)) +
  geom_col(fill = 'red') +
  labs(x = 'City', y = 'Number of Incidents', title = 'Top 10 Cities by Number of Incidents') +
  coord_flip() +
  theme_minimal()

# Defining the categories and color palette
overallCats <- c("Shot - Wounded/Injured", "Shot - Dead (murder, accidental, suicide)", 
                 "Non-Shooting Incident", "Shots Fired - No Injuries")
coloursShot <- c("Shot - Wounded/Injured" = "orange", 
                 "Shot - Dead (murder, accidental, suicide)" = "red", 
                 "Non-Shooting Incident" = "green", 
                 "Shots Fired - No Injuries" = "yellow")

# Data cleaning and processing function
prepare_data <- function(data) {
  data %>%
    mutate(incident_characteristics = gsub("\\|\\|", "|", incident_characteristics)) %>%
    separate_rows(incident_characteristics, sep = "\\|") %>%
    filter(incident_characteristics %in% overallCats)
}

# Plotting incidents for the entire US or a specific city
plot_incident_characteristics <- function(data, cityName = NULL, fixedX = 0.8) {
  plot_data <- if (is.null(cityName)) {
    data
  } else {
    filter(data, city_or_county == cityName)
  }
  
  plot_data %>%
    prepare_data() %>%
    count(incident_characteristics) %>%
    ggplot(aes(x = reorder(incident_characteristics, n), y = n / sum(n), fill = incident_characteristics)) +
    geom_col(width = 0.5) +
    scale_fill_manual(values = coloursShot) +
    theme_minimal() +
    theme(legend.position = "none") +
    coord_flip() +
    scale_y_continuous(limits = c(0, fixedX), labels = percent) +
    labs(x = "", y = ifelse(is.null(cityName), "US overall", cityName))
}

# Loading the data
IncCharac <- prepare_data(gun_data)

# Creating plots for the US and specified cities
usOverallCats <- plot_incident_characteristics(IncCharac, fixedX = 0.8)
chicagoCats <- plot_incident_characteristics(IncCharac, 'Chicago', fixedX = 0.8)
baltimoreCats <- plot_incident_characteristics(IncCharac, 'Baltimore', fixedX = 0.8)
washingtonCats <- plot_incident_characteristics(IncCharac, 'Washington', fixedX = 0.8)

# plotting vertically
grid.arrange(usOverallCats, chicagoCats, baltimoreCats, washingtonCats, ncol = 1)

# Participant - Series
gun_data$participant_status[1:5]

# Splitting the 'participant_status' column into multiple rows
participant_status_cleaned <- gun_data %>%
  filter(participant_status != "") %>%
  mutate(participant_status = gsub("\\|\\|", "|", participant_status)) %>% # Replace "||" with "|"
  select(incident_id, state, city_or_county, participant_status) %>%
  cSplit('participant_status', sep = '|', direction = "long") %>%
  mutate(status = sub("^[0-9]+::", "", participant_status)) %>%
  separate_rows(status, sep = ", ") %>%
  mutate(status = trimws(status)) %>%
  filter(!grepl("^[0-9]+:", status)) %>%
  drop_na(status)

# Counting the frequency of each participant status
status_distribution <- participant_status_cleaned %>%
  count(status) %>%
  arrange(desc(n))

# Plotting the participant status distribution
ggplot(status_distribution, aes(x = reorder(status, n), y = n)) +
  geom_col(fill = 'purple') +
  geom_text(aes(label = n), hjust = 1.1, color = "white", size = 4) +
  coord_flip() +
  labs(x = 'Status', y = 'Number of Occurrences', title = 'Distribution of Participant Statuses') +
  theme_minimal() +
  theme(axis.text.y = element_text(size = 10),
        axis.title = element_text(size = 12),
        plot.title = element_text(hjust = 0.5, size = 14))

gun_data$participant_type[1:5]

# Splitting the 'participant_type' column into multiple rows
participant_type_cleaned <- gun_data %>%
  filter(participant_type != "") %>%
  mutate(participant_type = gsub("\\|\\|", "|", participant_type)) %>%
  select(incident_id, state, city_or_county, participant_type) %>%
  cSplit('participant_type', sep = '|', direction = "long") %>%
  mutate(type = gsub("^[0-9]+::", "", participant_type)) %>%
  mutate(type = trimws(type)) %>%
  filter(type %in% c("Victim", "Subject-Suspect")) %>%
  drop_na(type)

# Counting the frequency of each participant type
type_distribution <- participant_type_cleaned %>%
  count(type) %>%
  arrange(desc(n))

# Plotting the distribution of participant types
ggplot(type_distribution, aes(x = reorder(type, n), y = n, fill = type)) +
  geom_col() +
  geom_text(aes(label = n), vjust = 1.2, color = "white", size = 4) + 
  labs(x = 'Participant Type', y = 'Number of Occurrences', title = 'Distribution of Participant Types') +
  theme_minimal() +
  theme(axis.text.y = element_text(size = 10),
        axis.title = element_text(size = 12),
        plot.title = element_text(hjust = 0.5, size = 14)) +
  scale_fill_manual(values = c("Subject-Suspect" = "darkgreen", "Victim" = "purple"))

gun_data$participant_age[1:5]

# Splitting the 'participant_age' column into multiple rows
participant_age_cleaned <- gun_data %>%
  filter(participant_age != "") %>%
  mutate(participant_age = gsub("\\|\\|", "|", participant_age)) %>%
  select(incident_id, state, city_or_county, participant_age) %>%
  cSplit('participant_age', sep = '|', direction = "long") %>%
  mutate(age = as.numeric(sub(".*::", "", participant_age))) %>%
  drop_na(age)

# Counting the top 10 most common ages
top10_age_distribution <- participant_age_cleaned %>%
  count(age) %>%
  arrange(desc(n)) %>%
  slice_max(order_by = n, n = 10)

# Plotting the top 10 most common participant ages
ggplot(top10_age_distribution, aes(x = reorder(age, n), y = n)) +
  geom_col(fill = 'blue') +
  geom_text(aes(label = n), hjust = 1.1, color = "white", size = 4) +
  coord_flip() +
  labs(x = 'Age', y = 'Number of Participants', title = 'Top 10 Most Common Participant Ages') +
  theme_minimal() +
  theme(axis.text.y = element_text(size = 10),
        axis.title = element_text(size = 12),
        plot.title = element_text(hjust = 0.5, size = 14))

gun_data$participant_gender[1:5]

# Splitting the 'participant_gender' column into multiple rows
participant_gender_cleaned <- gun_data %>%
  filter(participant_gender != "") %>%
  mutate(participant_gender = gsub("\\|\\|", "|", participant_gender)) %>%
  select(incident_id, state, city_or_county, participant_gender) %>%
  cSplit('participant_gender', sep = '|', direction = "long") %>%
  mutate(gender = sub(".*::", "", participant_gender)) %>%
  drop_na(gender)

# Grouping all "Male" and "Female" together
gender_aggregated <- participant_gender_cleaned %>%
  filter(gender %in% c("Male", "Female")) %>%
  count(gender) %>%
  mutate(proportion = n / sum(n) * 100)

# Plotting the gender distribution
ggplot(gender_aggregated, aes(x = gender, y = proportion, fill = gender)) +
  geom_col() +
  geom_text(aes(label = paste0(round(proportion, 1), "%")), 
            vjust = 1.2, color = "white", size = 4) +
  labs(x = 'Gender', y = 'Proportion (%)', title = 'Gender Distribution of Participants') +
  theme_minimal() +
  theme(axis.text.x = element_text(size = 10),
        axis.title = element_text(size = 12),
        plot.title = element_text(hjust = 0.5, size = 14)) +
  scale_fill_manual(values = c("Male" = "blue", "Female" = "red"))

gun_data$incident_characteristics[1:5]

# Splitting the 'incident_characteristics' column into multiple rows
incident_characteristics_cleaned <- gun_data %>%
  filter(incident_characteristics != "") %>% # Filter out empty values
  mutate(incident_characteristics = gsub("\\|\\|", "|", incident_characteristics)) %>%
  select(incident_id, state, city_or_county, incident_characteristics) %>%
  cSplit('incident_characteristics', sep = '|', direction = "long") %>%
  mutate(characteristic = trimws(incident_characteristics)) %>%
  drop_na(characteristic)

# Counting the frequency of each characteristic
top10_characteristics <- incident_characteristics_cleaned %>%
  count(characteristic) %>%
  arrange(desc(n)) %>%
  slice_max(order_by = n, n = 10)

# Plotting the top 10 most common incident characteristics
ggplot(top10_characteristics, aes(x = reorder(characteristic, n), y = n)) +
  geom_col(fill = 'blue') +
  coord_flip() +
  labs(x = 'Incident Characteristic', y = 'Number of Incidents', title = 'Top 10 Most Common Incident Characteristics') +
  theme_minimal() +
  theme(axis.text.y = element_text(size = 10),
        axis.title = element_text(size = 12),
        plot.title = element_text(hjust = 0.5, size = 14))

#----------------------- Data Mining (Wordcloud) -----------------------#
library(tidytext)
library(tm)
library(wordcloud)
library(RColorBrewer)

# Extracting and preprocessing the 'location_description' and 'n_killed' columns
location_data <- gun_data %>%
  select(location = location_description, killed = n_killed) %>%
  filter(!is.na(location), !is.na(killed)) %>%
  mutate(location = tolower(location),
         location = str_replace_all(location, "[[:punct:]]", " "),
         location = str_squish(location))

# Tokenizing the text and removing stopwords
location_words <- location_data %>%
  unnest_tokens(word, location, drop = FALSE) %>%
  anti_join(stop_words)

# Calculating word frequencies
word_freqs <- location_words %>%
  count(word, sort = TRUE)
head(word_freqs)

# Plotting the basic word cloud
set.seed(123)
wordcloud(words = word_freqs$word, freq = word_freqs$n, 
          min.freq = 10, max.words = 200, random.order = FALSE,
          colors = brewer.pal(8, "Dark2"))

# Calculating the total number of deaths for each location
location_weights <- location_data %>%
  group_by(location) %>%
  summarise(total_killed = sum(killed))

# Associating words with the total deaths at their locations
weighted_words <- location_words %>%
  inner_join(location_weights, by = "location") %>%
  group_by(word) %>%
  summarise(freq = n(),
            weighted_freq = sum(total_killed)) %>%
  arrange(desc(weighted_freq))
head(weighted_words)

# Plotting the weighted word cloud
set.seed(123)
wordcloud(words = weighted_words$word, freq = weighted_words$weighted_freq, 
          min.freq = 10, max.words = 200, random.order = FALSE,
          colors = brewer.pal(8, "Dark2"))

#----------------------- RandomForest -----------------------#
library(caret)
library(fastDummies)
library(randomForest)

# Dropping missing values
gun_data_clean <- gun_data %>% drop_na()

# Convert 'state', 'month', and 'weekday' to factor type
gun_data_clean$state <- as.factor(gun_data_clean$state)
gun_data_clean$month <- as.factor(gun_data_clean$month)
gun_data_clean$weekday <- as.factor(gun_data_clean$weekday)

# Applying one-hot encoding using fastDummies
gun_data_encoded <- dummy_cols(
  gun_data_clean,
  select_columns = c("state", "month", "weekday"),
  remove_first_dummy = FALSE,
  remove_selected_columns = TRUE
)

# Creating a new variable for total casualties
gun_data_encoded$total_casualties <- gun_data_encoded$n_killed + gun_data_encoded$n_injured

# Creating the 'high_casualty' variable
gun_data_encoded$high_casualty <- ifelse(gun_data_encoded$total_casualties >= 3, 1, 0)

# List of columns to remove
columns_to_remove <- c(
  "incident_id", "date", "city_or_county", "address", "incident_url", "source_url",
  "incident_url_fields_missing", "gun_stolen", "gun_type", "incident_characteristics",
  "latitude", "location_description", "longitude", "notes", "participant_age",
  "participant_age_group", "participant_gender", "participant_name",
  "participant_relationship", "participant_status", "participant_type",
  "sources", "day", "date2", "n_injured", "n_killed")

# Removing the specified columns
gun_data_encoded <- gun_data_encoded[, !(names(gun_data_encoded) %in% columns_to_remove)]

# Splitting the dataset into training and testing sets
set.seed(123)
train_index <- sample(seq_len(nrow(gun_data_encoded)), size = 0.7 * nrow(gun_data_encoded))
train_data <- gun_data_encoded[train_index, ]
test_data <- gun_data_encoded[-train_index, ]

# Ensuring column names have no spaces
names(train_data) <- gsub(" ", "_", names(train_data))
names(test_data) <- gsub(" ", "_", names(test_data))

# Identifying numeric columns for scaling, EXCLUDING 'total_casualties' and 'high_casualty'
numeric_columns <- sapply(train_data, is.numeric)
numeric_columns <- names(train_data)[numeric_columns]
numeric_columns <- setdiff(numeric_columns, c("total_casualties", "high_casualty"))

# Scaling numeric columns
scaling_params <- preProcess(train_data[numeric_columns], method = c("center", "scale"))
train_data_scaled <- train_data
train_data_scaled[numeric_columns] <- predict(scaling_params, train_data[numeric_columns])
test_data_scaled <- test_data
test_data_scaled[numeric_columns] <- predict(scaling_params, test_data[numeric_columns])

# Removing the 'state_Vermont' column if present
if ("state_Vermont" %in% names(train_data_scaled)) {
  train_data_scaled <- train_data_scaled[, !(names(train_data_scaled) %in% "state_Vermont")]
}
if ("state_Vermont" %in% names(test_data_scaled)) {
  test_data_scaled <- test_data_scaled[, !(names(test_data_scaled) %in% "state_Vermont")]
}

# Convert 'high_casualty' to a factor for classification
train_data_scaled$high_casualty <- as.factor(train_data_scaled$high_casualty)
test_data_scaled$high_casualty <- as.factor(test_data_scaled$high_casualty)
summary(train_data_scaled)
summary(test_data_scaled)

# Fitting a random forest model to predict high casualty incidents
# Exclude 'total_casualties' from predictors to prevent data leakage
rf_model <- randomForest(
  high_casualty ~ . - total_casualties,
  data = train_data_scaled,
  ntree = 100
)

# Predicting on the test set
# Remove 'high_casualty' from test data predictors
test_predictors <- test_data_scaled[, !(names(test_data_scaled) %in% c("high_casualty"))]
predictions <- predict(rf_model, newdata = test_predictors)

# Evaluating the model with a confusion matrix
confusion_matrix <- table(test_data_scaled$high_casualty, predictions)
print(confusion_matrix)

# Calculating accuracy
accuracy <- sum(diag(confusion_matrix)) / sum(confusion_matrix)
print(paste("Accuracy:", round(accuracy, 4)))

library(PRROC)
library(pROC)
library(ModelMetrics)

# Calculate Precision, Recall, and F1 Score
true_negatives <- confusion_matrix[1, 1]
false_positives <- confusion_matrix[1, 2]
false_negatives <- confusion_matrix[2, 1]
true_positives <- confusion_matrix[2, 2]

# Precision
precision <- true_positives / (true_positives + false_positives)

# Recall
recall <- true_positives / (true_positives + false_negatives)

# F1 Score
f1_score <- 2 * (precision * recall) / (precision + recall)

# Print the results
cat("Precision:", round(precision, 4), "\n")
cat("Recall:", round(recall, 4), "\n")
cat("F1 Score:", round(f1_score, 4), "\n")

# Permutation Feature Importance - Displaying Top 10 Features
importance_values <- importance(rf_model)
importance_df <- data.frame(Feature = rownames(importance_values), 
                            Importance = importance_values[, "MeanDecreaseGini"])

# Order the features by importance and select the top 10
top10_features <- importance_df[order(importance_df$Importance, decreasing = TRUE), ][1:10, ]
top10_features

# Plot the top 10 variable importance
ggplot(top10_features, aes(x = reorder(Feature, Importance), y = Importance)) +
  geom_col(fill = "blue") +
  coord_flip() +
  labs(title = "Top 10 Features in Random Forest Model",
       x = "Feature",
       y = "Importance") +
  theme_minimal()

# Predicting probabilities on the test set
test_probabilities <- predict(rf_model, newdata = test_data_scaled, type = "prob")

# Extracting the probabilities for the positive class (high casualty incidents)
positive_probabilities <- test_probabilities[, "1"]

# Generating the ROC curve
roc_curve <- roc(test_data_scaled$high_casualty, positive_probabilities)

# Plotting the ROC curve
plot(roc_curve, col = "blue", main = "ROC Curve for Random Forest Model", lwd = 2)
abline(a = 0, b = 1, lty = 2, col = "red")

# Set up cross-validation parameters
train_control <- trainControl(method = "cv", number = 10)

# Train the random forest model using cross-validation
rf_cv_model <- train(high_casualty ~ . - total_casualties, 
                     data = train_data, 
                     method = "rf", 
                     trControl = train_control,
                     ntree = 10)

# Print the cross-validation results
print(rf_cv_model)

#----------------------- K-Nearest Neighbors -----------------------#
# Load necessary libraries
library(class)
library(caret)

# Scale and normalize numeric columns for KNN
# Already preprocessed data, so no need for additional scaling

# Set up cross-validation
train_control <- trainControl(method = "cv", number = 10)
# Define the range for k-values
k_values <- data.frame(k = c(1, 3, 5, 7, 9))

# Train KNN model using cross-validation
knn_model <- train(
  high_casualty ~ ., 
  data = train_data_scaled, 
  method = "knn",
  trControl = train_control,
  tuneGrid = k_values
)

# Print the best k-value
print(knn_model)
best_k <- knn_model$bestTune$k
cat("Best k-value:", best_k, "\n")

# Predict on test set with the best k
knn_predictions <- predict(knn_model, newdata = test_data_scaled)

# Confusion matrix and performance metrics
knn_confusion <- confusionMatrix(knn_predictions, test_data_scaled$high_casualty)
print(knn_confusion)

#----------------------- XGBoost -----------------------#
# Load the xgboost library
library(xgboost)

# Convert data to matrix for XGBoost (it requires a numeric matrix format)
train_matrix <- as.matrix(train_data_scaled[, -which(names(train_data_scaled) == "high_casualty")])
test_matrix <- as.matrix(test_data_scaled[, -which(names(test_data_scaled) == "high_casualty")])
train_labels <- as.numeric(train_data_scaled$high_casualty) - 1  # Convert factor to 0 and 1
test_labels <- as.numeric(test_data_scaled$high_casualty) - 1

# Define parameters for XGBoost
xgb_params <- list(
  objective = "binary:logistic",
  eval_metric = "error",
  max_depth = 6,
  eta = 0.1,
  nthread = 2
)

# Set up cross-validation parameters
cv_nround <- 100
cv_nfold <- 10

# Run cross-validation
xgb_cv <- xgb.cv(
  params = xgb_params,
  data = train_matrix,
  label = train_labels,
  nrounds = cv_nround,
  nfold = cv_nfold,
  verbose = 0
)

# Choose the number of rounds with the lowest error rate
optimal_nrounds <- which.min(xgb_cv$evaluation_log$test_error_mean)
cat("Optimal number of rounds:", optimal_nrounds, "\n")

# Train the final model with the optimal number of rounds
xgb_model <- xgboost(
  params = xgb_params,
  data = train_matrix,
  label = train_labels,
  nrounds = optimal_nrounds,
  verbose = 0
)

# Make predictions on the test set
xgb_predictions <- predict(xgb_model, test_matrix)
xgb_predictions_class <- ifelse(xgb_predictions > 0.5, 1, 0)

# Convert predictions to a factor for comparison
xgb_predictions_factor <- factor(xgb_predictions_class, levels = c(0, 1), labels = c("0", "1"))
test_labels_factor <- factor(test_labels, levels = c(0, 1), labels = c("0", "1"))

# Confusion matrix and performance metrics
xgb_confusion <- confusionMatrix(xgb_predictions_factor, test_labels_factor)
print(xgb_confusion)

