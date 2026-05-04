# Project Walkthrough

## 1. Project Overview

This project was my individual final project for ALY6040: Data Mining at Northeastern University.

I used a public U.S. gun violence dataset to study incident patterns from January 2013 to March 2018. The analysis focused on where incidents were more common, when incident counts were higher, what participant patterns appeared, and how carefully a simple high-casualty classification task could be evaluated.

This repository is a cleaned public version for portfolio use. It keeps the original course materials for traceability, but the public story is intentionally more cautious than some of the original slide metrics.

## 2. Business Problem

Large incident datasets can be hard to interpret without a structured analysis. This project frames the data as a public-safety analytics exercise: use incident-level records to find clear observed patterns and test whether a model can help identify higher-casualty incidents.

The main questions were:

1. What observed factors are connected with more severe incidents?
2. Are incident counts higher during certain months, quarters, or weekdays?
3. Which incidents are more likely to have multiple casualties?
4. How do state, city, and local fields relate to high incident counts?

This made the project a mix of exploratory analysis and basic predictive modeling. The findings are descriptive, not causal, and there is no confirmed real stakeholder engagement.

## 3. Project Objective

The goal was to build a complete R workflow that could:

- load and inspect a large public incident dataset
- review missing values, duplicates, and outliers
- engineer time and severity features
- parse participant-related string fields
- create visual summaries for time, geography, participant, and incident-type patterns
- explore location text with word clouds
- test classification model experiments for high-casualty incidents
- explain why the final model should be interpreted carefully

## 4. Dataset

### Main Dataset

- **Name:** Gun Violence Dataset
- **Source:** Kaggle
- **Time range:** January 2013 to March 2018
- **Size:** 239,677 rows and 29 columns
- **Granularity:** one row per incident

### Main Fields Used

- `incident_id`
- `date`
- `state`
- `city_or_county`
- `n_killed`
- `n_injured`
- `congressional_district`
- `state_house_district`
- `state_senate_district`
- `latitude`
- `longitude`
- `n_guns_involved`
- `location_description`
- `participant_age`
- `participant_gender`
- `participant_status`
- `participant_type`
- `incident_characteristics`

### Data Access Note

The raw CSV is expected locally at:

```r
gun_data <- read.csv("data/raw/gun-violence-data_01-2013_03-2018.csv")
```

The public portfolio repo does not rely on redistributing the raw dataset. See [`../data/README.md`](../data/README.md) for the data note and [`../data/data-dictionary.md`](../data/data-dictionary.md) for the working data dictionary.

## 5. My Role / Contribution

This was an individual course-based project.

I completed the analysis and report on my own. My work included:

- data loading and cleaning
- missing value, duplicate, and outlier checks
- time-feature engineering
- severity-feature engineering
- exploratory data analysis
- participant-field parsing
- word cloud analysis
- classification model testing and comparison
- final report writing
- presentation preparation

I also reviewed Kaggle notebooks and discussion posts to improve my ideas for handling messy fields and model setup.

See:

- [`../contribution-note.md`](../contribution-note.md)
- [`../archive/reflection/individual-reflection.pdf`](../archive/reflection/individual-reflection.pdf)

## 6. Tools and Methods

### Tools

- R
- tidyverse
- lubridate
- ggplot2
- splitstackshape
- tidytext
- wordcloud
- caret
- fastDummies
- randomForest
- xgboost

### Methods

- data cleaning
- missingness review
- duplicate checks
- outlier checks
- time-feature engineering
- severity-feature engineering
- participant-field parsing
- text mining with word clouds
- one-hot encoding
- train/test split
- model evaluation with confusion-matrix metrics

### Models Tested or Documented

- Logistic Regression
- KNN
- LightGBM
- Random Forest
- XGBoost

The final public model reference is the Random Forest result from the final report and archived model-output notes.

## 7. Workflow

My project flow was:

1. Load the dataset.
2. Check data types, unique values, missing values, and duplicates.
3. Explore outliers in `n_killed` and `n_injured`.
4. Create time-based features such as year, quarter, month, day, and weekday.
5. Analyze incident counts by state, city, month, quarter, and weekday.
6. Parse participant-related string fields into usable rows.
7. Explore `location_description` text with word clouds.
8. Create `total_casualties`.
9. Create `high_casualty` as a binary target.
10. One-hot encode selected categorical fields.
11. Split the data into training and testing sets.
12. Test several model experiments.
13. Compare results and explain limitations.

## 8. Selected Code and Evidence References

- Full analysis script: [`../scripts/01_full_analysis.R`](../scripts/01_full_analysis.R)
- Report source: [`../scripts/02_final_report_source.Rmd`](../scripts/02_final_report_source.Rmd)
- Final report PDF: [`../reports/final-report.pdf`](../reports/final-report.pdf)
- Portfolio summary PDF: [`../reports/portfolio-project-summary.pdf`](../reports/portfolio-project-summary.pdf)
- Original model output: [`../archive/model-output/model-output.txt`](../archive/model-output/model-output.txt)
- Selected figures: [`../outputs/figures/selected/`](../outputs/figures/selected/)

## 9. Key Findings

### A. Incident Counts Increased Over the Main Full Years

From 2014 to 2017, the total number of incidents increased steadily. The 2018 count is lower because the dataset only includes January through March 2018.

### B. Time Patterns Were Visible

Incidents were more frequent on weekends, especially Sunday and Saturday. January, March, July, and August also had higher counts in the monthly chart.

### C. Geographic Concentration Was Clear

Illinois, California, Florida, and Texas had high raw incident counts. Chicago stood out as the top city by incident count.

These charts show raw counts, not per-capita risk. They should be used as descriptive evidence, not as proof that one place is more dangerous after adjusting for population.

### D. Participant Patterns Were Useful

Many parsed participant records were marked as unharmed, injured, or arrested. The most common ages were around 18 to 26, and most parsed gender records were male.

### E. Location Text Added Context

The most common location-description words included apartments, parks, schools, and neighborhoods. This was useful context, but the word clouds should not be treated as causal evidence.

## 10. Visual Highlights

### Time and Trend Visuals

<p align="center">
  <img src="../outputs/figures/selected/number-of-incidents-by-year-2013-2018.jpeg" alt="Number of incidents by year" width="48%">
  <img src="../outputs/figures/selected/incidents-by-weekday.jpeg" alt="Incidents by weekday" width="48%">
</p>

### Geography Visuals

<p align="center">
  <img src="../outputs/figures/selected/top-states-by-incident-frequency.jpeg" alt="Top states by incident frequency" width="48%">
  <img src="../outputs/figures/selected/top-10-cities-by-number-of-incidents.jpeg" alt="Top cities by number of incidents" width="48%">
</p>

### Participant and Text Visuals

<p align="center">
  <img src="../outputs/figures/selected/distribution-of-participant-statuses.jpeg" alt="Distribution of participant statuses" width="48%">
  <img src="../outputs/figures/selected/top-10-most-common-participant-ages.jpeg" alt="Top participant ages" width="48%">
</p>

<p align="center">
  <img src="../outputs/figures/selected/gender-distribution-of-participants.jpeg" alt="Gender distribution of participants" width="48%">
  <img src="../outputs/figures/selected/wordcloud-1.jpeg" alt="Location description word cloud" width="48%">
</p>

## 11. Feature Engineering for Modeling

To represent incident severity, I created:

```r
gun_data_encoded$total_casualties <- gun_data_encoded$n_killed + gun_data_encoded$n_injured
gun_data_encoded$high_casualty <- ifelse(gun_data_encoded$total_casualties >= 3, 1, 0)
```

I also:

- one-hot encoded state, month, and weekday
- scaled numeric predictors
- split the data into training and testing sets
- excluded `total_casualties` from the Random Forest formula

Any model version that uses `n_killed` or `n_injured` as predictors for a target derived from those same fields would create leakage risk. This is one reason the public write-up uses the conservative final report metrics instead of the stronger original slide metrics.

## 12. Model Evaluation Note

I tested or documented Logistic Regression, KNN, LightGBM, Random Forest, and XGBoost experiments. The checked-in script shows Random Forest, KNN, and XGBoost sections, while the archived model notes preserve additional LightGBM output from the original course work.

For this public GitHub version, the final report and archived model output are the safest reference.

### Final Public Random Forest Metrics

- Accuracy: 97.45%
- Precision: 86.67%
- Recall: 2.94%
- F1 Score: 5.68%

### What This Means

The model looked strong on accuracy, but recall was very weak. It missed many true high-casualty incidents, so it should be treated as a coursework classification experiment rather than a reliable prediction system.

### Important Note About Original Slides

Some values shown in [`../slides/original-presentation.pdf`](../slides/original-presentation.pdf) are much higher than the final report version. I keep the slide deck as an original course artifact, but the public project story follows the final report and archived model-output notes more conservatively.

## 13. Main Insights From the Model

The final report highlighted these important features:

- `state_house_district`
- `state_senate_district`
- `year`
- `congressional_district`
- `quarter`
- `n_guns_involved`
- some month features

This suggests that geography and time-related fields were important to the model. Because the target class was rare and recall was weak, these should be interpreted as model signals from a coursework experiment, not as validated predictors for real-world deployment.

See [`../archive/model-output/model-output.txt`](../archive/model-output/model-output.txt).

## 14. Limitations

This project has several important limitations:

- It is an individual course and portfolio project, not a deployed analytics product.
- The findings are descriptive and should not be presented as causal.
- No real stakeholder engagement or policy validation is confirmed.
- There is no dashboard app, SQL layer, GenAI component, or MLOps workflow.
- State and city charts show raw incident counts, not per-capita rates.
- Several fields have missing values, especially participant, relationship, gun, and location-description fields.
- The high-casualty class is rare, which makes accuracy misleading.
- The final Random Forest recall was very weak.
- Older slide metrics should not be used as the final public model claim.
- Future model work would need stronger validation, threshold tuning, and class-imbalance handling before any decision-support use.

## 15. What I Learned

This project helped me practice a full analysis workflow instead of only one part of analytics.

I learned how to:

- clean and inspect a large messy dataset
- work with multi-value text fields
- turn raw incident data into time and location insights
- compare model outputs more carefully
- explain why a high accuracy score can still be misleading
- keep portfolio claims honest when older artifacts show different metrics

## 16. Files to Read First

If you want the shortest path through this repo, I suggest this order:

1. [`../README.md`](../README.md)
2. [`../reports/portfolio-project-summary.pdf`](../reports/portfolio-project-summary.pdf)
3. [`../reports/final-report.pdf`](../reports/final-report.pdf)
4. [`../outputs/figures/selected/`](../outputs/figures/selected/)
5. [`../scripts/01_full_analysis.R`](../scripts/01_full_analysis.R)
6. [`../archive/model-output/model-output.txt`](../archive/model-output/model-output.txt)

## 17. Short Interview Version

This was my individual final project for a data mining course. I used a public U.S. gun violence dataset in R to study time, location, participant, and severity patterns. I also tested high-casualty classification models, but the final Random Forest recall was very weak, so I would not describe it as a reliable prediction system. The strongest value of the project is the full R workflow: cleaning the data, parsing messy fields, building visuals, testing models, and being honest about the limits of the result.
